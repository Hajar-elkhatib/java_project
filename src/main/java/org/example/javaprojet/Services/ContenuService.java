package org.example.javaprojet.Services;

import lombok.RequiredArgsConstructor;
import org.example.javaprojet.Entity.*;
import org.example.javaprojet.Repository.*;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class ContenuService {

    private final ContenuRepository contenuRepository;
    private final SaisonRepository saisonRepository;
    private final EpisodeRepository episodeRepository;
    private final PersonneRepository personneRepository;
    private final ParticipationRepository participationRepository;
    private final GenreRepository genreRepository;
    private final CommentaireRepository commentaireRepository;
    private final EvaluationRepository evaluationRepository;
    private final UtilisateurContenuFavoriRepository favoriRepository;
    private final HistoriqueInteractionRepository interactionRepository;

    public List<Contenu> getAllContenus() {
        return contenuRepository.findAll();
    }

    public Contenu getContenuById(String id) {
        return contenuRepository.findById(id).orElseThrow(() -> new RuntimeException("Contenu introuvable"));
    }

    public List<Contenu> searchContenus(String query) {
        Set<Contenu> results = new HashSet<>();
        results.addAll(contenuRepository.findByTitreContainingIgnoreCase(query));
        results.addAll(contenuRepository.findByPaysContainingIgnoreCase(query));

        List<Genre> genres = genreRepository.findAll().stream()
                .filter(g -> g.getNom() != null && g.getNom().toLowerCase().contains(query.toLowerCase()))
                .collect(Collectors.toList());
        for (Genre g : genres) {
            results.addAll(contenuRepository.findByGenreIdsContains(g.getId()));
        }

        List<Personne> personnes = personneRepository.findByNomContainingIgnoreCase(query);
        for (Personne p : personnes) {
            participationRepository.findAll().stream()
                    .filter(part -> part.getPersonneId() != null && part.getPersonneId().equals(p.getId()))
                    .forEach(part -> contenuRepository.findById(part.getContenuId()).ifPresent(results::add));
        }

        return new ArrayList<>(results);
    }

    public List<String> getGenreNames(List<String> genreIds) {
        if (genreIds == null)
            return new ArrayList<>();
        return genreIds.stream()
                .map(id -> genreRepository.findById(id).map(Genre::getNom).orElse("Inconnu"))
                .collect(Collectors.toList());
    }

    public List<Contenu> getContenusByType(String type) {
        return contenuRepository.findByTypeContenuIgnoreCase(type);
    }

    public List<Contenu> getTopRatedContent() {
        return contenuRepository.findTop8ByOrderByNoteMoyenneDesc();
    }

    public List<Contenu> getTrendingContent() {
        return contenuRepository.findTop10ByOrderByNbVotesDesc();
    }

    public List<Contenu> getContenusByGenre(String genreId) {
        return contenuRepository.findByGenreIdsContains(genreId);
    }

    public Contenu saveContenu(Contenu contenu) {
        return contenuRepository.save(contenu);
    }

    public void deleteContenu(String id) {
        // Cascade delete
        saisonRepository.findByContenuId(id).forEach(s -> {
            episodeRepository.findBySaisonId(s.getId()).forEach(ep -> episodeRepository.delete(ep));
            saisonRepository.delete(s);
        });
        participationRepository.findByContenuId(id).forEach(p -> participationRepository.delete(p));
        commentaireRepository.findByContenuId(id).forEach(c -> commentaireRepository.delete(c));
        evaluationRepository.findByContenuId(id).forEach(e -> evaluationRepository.delete(e));
        favoriRepository.findByContenuId(id).forEach(f -> favoriRepository.delete(f));
        interactionRepository.findByContenuId(id).forEach(i -> interactionRepository.delete(i));

        contenuRepository.deleteById(id);
    }

    // Relations Saisons / Episodes
    public List<Saison> getSaisonsByContenuId(String contenuId) {
        return saisonRepository.findByContenuId(contenuId);
    }

    public List<Episode> getEpisodesBySaisonId(String saisonId) {
        return episodeRepository.findBySaisonId(saisonId);
    }

    public Saison saveSaison(Saison saison) {
        return saisonRepository.save(saison);
    }

    public Episode saveEpisode(Episode episode) {
        return episodeRepository.save(episode);
    }

    public List<Contenu> getContenusByIds(List<String> ids) {
        return contenuRepository.findAllById(ids);
    }
}
