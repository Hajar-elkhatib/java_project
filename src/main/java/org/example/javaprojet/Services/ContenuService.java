package org.example.javaprojet.Services;

import lombok.RequiredArgsConstructor;
import org.example.javaprojet.Entity.Contenu;
import org.example.javaprojet.Repository.ContenuRepository;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class ContenuService {

    private final ContenuRepository contenuRepository;

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

    public Contenu saveContenu(Contenu contenu) {
        return contenuRepository.save(contenu);
    }

    public void deleteContenu(String id) {
        contenuRepository.deleteById(id);
    }
}
