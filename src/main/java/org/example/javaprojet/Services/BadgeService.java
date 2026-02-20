package org.example.javaprojet.Services;

import lombok.RequiredArgsConstructor;
import org.example.javaprojet.Entity.*;
import org.example.javaprojet.Repository.*;
import org.springframework.stereotype.Service;

import jakarta.annotation.PostConstruct;
import java.util.*;

@Service
@RequiredArgsConstructor
public class BadgeService {

    private final BadgeRepository badgeRepository;
    private final UtilisateurBadgeRepository utilisateurBadgeRepository;
    private final EvaluationRepository evaluationRepository;
    private final CommentaireRepository commentaireRepository;
    private final UtilisateurContenuFavoriRepository favoriRepository;
    private final HistoriqueInteractionRepository interactionRepository;

    @PostConstruct
    public void initBadges() {
        // Force refresh or create initial badges with healthy limits (Increased for
        // better UX)
        List<Badge> defaultBadges = Arrays.asList(
                new Badge("b1", "Nouveau", 1, "Nouveau venu sur la plateforme", 0, 50, 50, 20, 100),
                new Badge("b2", "Actif", 2, "Utilisateur régulier", 51, 200, 100, 50, 200),
                new Badge("b3", "Cinéphile", 3, "Grand amateur de cinéma", 201, 500, 200, 100, 500),
                new Badge("b4", "Critique", 4, "Analyse les films avec passion", 501, 1000, 500, 200, 1000),
                new Badge("b5", "Expert", 5, "Maître incontesté de la culture ciné", 1001, Integer.MAX_VALUE, 1000, 500,
                        2000));

        for (Badge def : defaultBadges) {
            Optional<Badge> existing = badgeRepository.findById(def.getId());
            // Update if badge is missing or has very restrictive old limits
            if (existing.isEmpty() || existing.get().getLimiteNotesParJour() < 10) {
                badgeRepository.save(def);
                System.out
                        .println("[AntiSpam Log] Initialized/Updated badge: " + def.getNom() + " with higher limits.");
            }
        }
    }

    public double calculateUserScore(String userId) {
        Calendar cal = Calendar.getInstance();
        cal.add(Calendar.DAY_OF_YEAR, -30);
        Date thirtyDaysAgo = cal.getTime();

        long ratings = evaluationRepository.countByUtilisateurIdAndDateEvaluationGreaterThan(userId, thirtyDaysAgo);
        long comments = commentaireRepository.countByUtilisateurIdAndDateCreationGreaterThan(userId, thirtyDaysAgo);
        long favors = favoriRepository.countByUtilisateurIdAndDateAjouterGreaterThan(userId, thirtyDaysAgo);
        long views = interactionRepository.countByUtilisateurIdAndTypeInteractionAndDateHeureGreaterThan(userId, "VUE",
                thirtyDaysAgo);

        double score = (ratings * 3) + (comments * 5) + (favors * 1) + (views * 0.2);
        System.out.println("[AntiSpam Log] Score calculation for " + userId + ": R=" + ratings + ", C=" + comments
                + ", F=" + favors + ", V=" + views + " => Score=" + score);
        return score;
    }

    public Badge updateAndGetBadge(String userId) {
        double score = calculateUserScore(userId);
        List<Badge> allBadges = badgeRepository.findAll();
        allBadges.sort(Comparator.comparingInt(Badge::getNiveau));

        Badge currentBadgeEntity = allBadges.stream()
                .filter(b -> score >= b.getScoreMin()
                        && (b.getScoreMax() == Integer.MAX_VALUE || score <= b.getScoreMax()))
                .findFirst()
                .orElse(allBadges.isEmpty() ? new Badge("default", "Nouveau", 1, "Default", 0, 50, 50, 20, 100)
                        : allBadges.get(0));

        Optional<Utilisateur_Badge> existing = utilisateurBadgeRepository
                .findTopByUtilisateurIdOrderByDateAttributionDesc(userId);

        if (existing.isEmpty() || !existing.get().getBadgeId().equals(currentBadgeEntity.getId())) {
            Utilisateur_Badge ub = new Utilisateur_Badge();
            ub.setUtilisateurId(userId);
            ub.setBadgeId(currentBadgeEntity.getId());
            ub.setDateAttribution(new Date());
            utilisateurBadgeRepository.save(ub);
            System.out.println("[AntiSpam Log] User " + userId + " assigned badge " + currentBadgeEntity.getNom());
        }

        return currentBadgeEntity;
    }

    public Badge getCurrentBadge(String userId) {
        Badge b = utilisateurBadgeRepository.findTopByUtilisateurIdOrderByDateAttributionDesc(userId)
                .map(ub -> badgeRepository.findById(ub.getBadgeId()).orElse(null))
                .orElse(null);

        if (b == null) {
            return updateAndGetBadge(userId);
        }
        return b;
    }

    public boolean canPerformAction(String userId, String actionType) {
        Badge badge = getCurrentBadge(userId);
        if (badge == null || badge.getLimiteNotesParJour() < 5) {
            badge = new Badge("default", "Nouveau", 1, "Fallback", 0, 50, 50, 20, 100);
        }

        // Precise start of day
        Calendar cal = Calendar.getInstance();
        cal.set(Calendar.HOUR_OF_DAY, 0);
        cal.set(Calendar.MINUTE, 0);
        cal.set(Calendar.SECOND, 0);
        cal.set(Calendar.MILLISECOND, 0);
        Date todayStart = cal.getTime();

        System.out.println(
                "[AntiSpam Log] Action Check: User=" + userId + ", Action=" + actionType + ", Badge=" + badge.getNom());

        if ("EVALUATION".equalsIgnoreCase(actionType)) {
            long count = evaluationRepository.countByUtilisateurIdAndDateEvaluationGreaterThan(userId, todayStart);
            boolean allowed = count < badge.getLimiteNotesParJour();
            System.out.println("[AntiSpam Log] EVALUATION status: TodayCount=" + count + ", Limit="
                    + badge.getLimiteNotesParJour() + " => " + (allowed ? "ALLOWED" : "BLOCKED"));
            return allowed;
        } else if ("COMMENTAIRE".equalsIgnoreCase(actionType)) {
            long count = commentaireRepository.countByUtilisateurIdAndDateCreationGreaterThan(userId, todayStart);
            boolean allowed = count < badge.getLimiteCommentairesParJour();
            System.out.println("[AntiSpam Log] COMMENTAIRE status: TodayCount=" + count + ", Limit="
                    + badge.getLimiteCommentairesParJour() + " => " + (allowed ? "ALLOWED" : "BLOCKED"));
            return allowed;
        } else if ("FAVORI".equalsIgnoreCase(actionType)) {
            long count = favoriRepository.countByUtilisateurIdAndDateAjouterGreaterThan(userId, todayStart);
            boolean allowed = count < badge.getLimiteFavorisParJour();
            System.out.println("[AntiSpam Log] FAVORI status: TodayCount=" + count + ", Limit="
                    + badge.getLimiteFavorisParJour() + " => " + (allowed ? "ALLOWED" : "BLOCKED"));
            return allowed;
        }

        return true;
    }

    // --- CRUD Methods for BadgeController ---

    public Badge ajouterBadge(Badge badge) {
        return badgeRepository.save(badge);
    }

    public List<Badge> getAllBadges() {
        return badgeRepository.findAll();
    }

    public Badge getBadgeById(String id) {
        return badgeRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Badge non trouvé"));
    }

    public Badge getBadgeByNom(String nom) {
        return badgeRepository.findByNom(nom)
                .orElseThrow(() -> new RuntimeException("Badge non trouvé"));
    }

    public Badge modifierBadge(String id, Badge badge) {
        Badge b = getBadgeById(id);
        b.setNom(badge.getNom());
        b.setNiveau(badge.getNiveau());
        b.setDescription(badge.getDescription());
        b.setScoreMin(badge.getScoreMin());
        b.setScoreMax(badge.getScoreMax());
        b.setLimiteNotesParJour(badge.getLimiteNotesParJour());
        b.setLimiteCommentairesParJour(badge.getLimiteCommentairesParJour());
        b.setLimiteFavorisParJour(badge.getLimiteFavorisParJour());
        return badgeRepository.save(b);
    }

    public void supprimerBadge(String id) {
        badgeRepository.deleteById(id);
    }
}
