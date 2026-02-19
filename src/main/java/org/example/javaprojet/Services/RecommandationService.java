package org.example.javaprojet.Services;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Data;
import lombok.extern.slf4j.Slf4j;
import org.example.javaprojet.Entity.Contenu;
import org.example.javaprojet.Entity.Recommandation;
import org.example.javaprojet.Entity.Utilisateur;
import org.example.javaprojet.Repository.ContenuRepository;
import org.example.javaprojet.Repository.RecommandationRepository;
import org.example.javaprojet.Repository.UtilisateurRepository;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.reactive.function.client.WebClient;
import reactor.core.publisher.Mono;

import java.util.*;
import java.util.stream.Collectors;

@Service
@Slf4j
public class RecommandationService {

    private final WebClient webClient;
    private final RecommandationRepository recommandationRepository;
    private final UtilisateurRepository utilisateurRepository;
    private final ContenuRepository contenuRepository;

    public RecommandationService(
            @Value("${ai.service.url:http://localhost:5000}") String aiServiceUrl,
            RecommandationRepository recommandationRepository,
            UtilisateurRepository utilisateurRepository,
            ContenuRepository contenuRepository) {
        this.webClient = WebClient.builder()
                .baseUrl(aiServiceUrl)
                .build();
        this.recommandationRepository = recommandationRepository;
        this.utilisateurRepository    = utilisateurRepository;
        this.contenuRepository        = contenuRepository;
    }

    // ─────────────────────────────────────────────────────────
    //  Save user preferences (genres + liked films from onboarding)
    // ─────────────────────────────────────────────────────────
    public void saveUserPreferences(String userId, List<String> genreIds, List<String> contentIds) {
        Utilisateur user = utilisateurRepository.findById(userId)
                .orElseThrow(() -> new RuntimeException("User not found: " + userId));
        user.setPreferredGenreIds(genreIds);
        user.setLikedContentIds(contentIds);
        utilisateurRepository.save(user);
        log.info("Saved preferences for user {}: {} genres, {} contents", userId, genreIds.size(), contentIds.size());
    }

    // ─────────────────────────────────────────────────────────
    //  Called after first login onboarding (genre + film selection)
    //  Calls Flask AI → saves results in MongoDB recommandation collection
    // ─────────────────────────────────────────────────────────
    public List<Recommandation> generateOnboardingRecommendations(String userId) {
        Utilisateur user = utilisateurRepository.findById(userId)
                .orElseThrow(() -> new RuntimeException("User not found: " + userId));

        OnboardingRequest payload = new OnboardingRequest();
        payload.setUserId(userId);
        payload.setPreferredGenreIds(user.getPreferredGenreIds());
        payload.setLikedContentIds(user.getLikedContentIds());
        payload.setTopN(20);

        log.info("Calling AI /recommend/onboarding for user {}", userId);

        RecommendResponse response = webClient.post()
                .uri("/recommend/onboarding")
                .bodyValue(payload)
                .retrieve()
                .bodyToMono(RecommendResponse.class)
                .onErrorResume(e -> {
                    log.error("AI service error: {}", e.getMessage());
                    return Mono.just(new RecommendResponse());
                })
                .block();

        if (response == null || response.getRecommendations() == null) {
            return Collections.emptyList();
        }

        // Delete old recommendations for this user
        recommandationRepository.deleteByUtilisateurId(userId);

        // Save new recommendations
        List<Recommandation> saved = response.getRecommendations().stream().map(rec -> {
            Recommandation r = new Recommandation();
            r.setUtilisateurId(userId);
            r.setContenuId(rec.getContentId());
            r.setScore(rec.getScore());
            r.setDateCreation(new Date());
            r.setModeleId("content-based-v1");
            return recommandationRepository.save(r);
        }).collect(Collectors.toList());

        // Mark first login done
        user.setFirstLogin(false);
        utilisateurRepository.save(user);

        log.info("Saved {} recommendations for user {}", saved.size(), userId);
        return saved;
    }

    // ─────────────────────────────────────────────────────────
    //  Refresh recommendations based on latest user activity
    // ─────────────────────────────────────────────────────────
    public List<Recommandation> refreshRecommendations(String userId) {
        Utilisateur user = utilisateurRepository.findById(userId)
                .orElseThrow(() -> new RuntimeException("User not found: " + userId));

        List<String> seedIds = new ArrayList<>();
        seedIds.addAll(user.getLikedContentIds());
        seedIds.addAll(user.getSeenContentIds());

        if (seedIds.isEmpty()) {
            return Collections.emptyList();
        }

        Map<String, Object> payload = new HashMap<>();
        payload.put("likedContentIds", seedIds);
        payload.put("topN", 20);

        RecommendResponse response = webClient.post()
                .uri("/recommend")
                .bodyValue(payload)
                .retrieve()
                .bodyToMono(RecommendResponse.class)
                .onErrorResume(e -> {
                    log.error("AI service error on refresh: {}", e.getMessage());
                    return Mono.just(new RecommendResponse());
                })
                .block();

        if (response == null || response.getRecommendations() == null) {
            return Collections.emptyList();
        }

        recommandationRepository.deleteByUtilisateurId(userId);

        return response.getRecommendations().stream().map(rec -> {
            Recommandation r = new Recommandation();
            r.setUtilisateurId(userId);
            r.setContenuId(rec.getContentId());
            r.setScore(rec.getScore());
            r.setDateCreation(new Date());
            r.setModeleId("content-based-v1");
            return recommandationRepository.save(r);
        }).collect(Collectors.toList());
    }

    // ─────────────────────────────────────────────────────────
    //  Get full Contenu objects for a user's recommendations
    //  This is what RecommendationPageController calls
    // ─────────────────────────────────────────────────────────
    public List<Contenu> getRecommendedContentForUser(String userId) {
        List<Recommandation> recs = recommandationRepository.findByUtilisateurId(userId);

        if (recs.isEmpty()) {
            return Collections.emptyList();
        }

        // Sort by score descending
        recs.sort((a, b) -> Float.compare(
                b.getScore() != null ? b.getScore() : 0f,
                a.getScore() != null ? a.getScore() : 0f
        ));

        // Fetch actual Contenu objects from MongoDB
        List<String> contentIds = recs.stream()
                .map(Recommandation::getContenuId)
                .collect(Collectors.toList());

        List<Contenu> contents = contenuRepository.findAllById(contentIds);

        // Re-order by recommendation score
        Map<String, Contenu> contenuMap = contents.stream()
                .collect(Collectors.toMap(Contenu::getId, c -> c));

        return contentIds.stream()
                .map(contenuMap::get)
                .filter(Objects::nonNull)
                .collect(Collectors.toList());
    }

    // ─────────────────────────────────────────────────────────
    //  Get raw Recommandation entities for a user
    // ─────────────────────────────────────────────────────────
    public List<Recommandation> getRecommendationsForUser(String userId) {
        return recommandationRepository.findByUtilisateurId(userId);
    }

    // ─────────────────────────────────────────────────────────
    //  DTOs for Flask AI communication
    // ─────────────────────────────────────────────────────────
    @Data
    static class OnboardingRequest {
        private String userId;
        private List<String> preferredGenreIds;
        private List<String> likedContentIds;
        private int topN;
    }

    @Data
    @JsonIgnoreProperties(ignoreUnknown = true)
    static class RecommendResponse {
        private List<RecommendItem> recommendations = new ArrayList<>();
    }

    @Data
    @JsonIgnoreProperties(ignoreUnknown = true)
    static class RecommendItem {
        @JsonProperty("contentId")
        private String contentId;
        @JsonProperty("titre")
        private String titre;
        @JsonProperty("score")
        private Float score;
    }
}