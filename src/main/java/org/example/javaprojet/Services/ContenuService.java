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

    public List<Contenu> getAllContenus() {
        return contenuRepository.findAll();
    }

    public Contenu getContenuById(String id) {
        return contenuRepository.findById(id).orElseThrow(() -> new RuntimeException("Contenu introuvable"));
    }

    public List<Contenu> searchContenus(String query) {
        Set<Contenu> results = new HashSet<>();

        // 1. Search by title
        results.addAll(contenuRepository.findByTitreContainingIgnoreCase(query));

        // 2. Search by country
        results.addAll(contenuRepository.findByPaysContainingIgnoreCase(query));

        // 3. Search by Genre name
        List<Genre> genres = genreRepository.findAll().stream()
                .filter(g -> g.getNom() != null && g.getNom().toLowerCase().contains(query.toLowerCase()))
                .collect(Collectors.toList());
        for (Genre g : genres) {
            results.addAll(contenuRepository.findByGenreIdsContains(g.getId()));
        }

        // 4. Search by Actor/Person name
        List<Personne> personnes = personneRepository.findByNomContainingIgnoreCase(query);
        for (Personne p : personnes) {
            List<Participation> participations = participationRepository.findAll().stream()
                    .filter(part -> part.getPersonneId() != null && part.getPersonneId().equals(p.getId()))
                    .collect(Collectors.toList());
            for (Participation part : participations) {
                contenuRepository.findById(part.getContenuId()).ifPresent(results::add);
            }
        }

        return new ArrayList<>(results);
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
}
