package org.example.javaprojet.Services;

import lombok.RequiredArgsConstructor;
import org.example.javaprojet.Entity.Contenu;
import org.example.javaprojet.Entity.Saison;
import org.example.javaprojet.Entity.Episode;
import org.example.javaprojet.Repository.ContenuRepository;
import org.example.javaprojet.Repository.SaisonRepository;
import org.example.javaprojet.Repository.EpisodeRepository;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class ContenuService {

    private final ContenuRepository contenuRepository;
    private final SaisonRepository saisonRepository;
    private final EpisodeRepository episodeRepository;

    public List<Contenu> getAllContenus() {
        return contenuRepository.findAll();
    }

    public Contenu getContenuById(String id) {
        return contenuRepository.findById(id).orElseThrow(() -> new RuntimeException("Contenu introuvable"));
    }

    public List<Contenu> searchContenus(String query) {
        return contenuRepository.findByTitreContainingIgnoreCase(query);
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
