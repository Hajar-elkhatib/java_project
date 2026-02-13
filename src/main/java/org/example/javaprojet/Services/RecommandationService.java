package org.example.javaprojet.Services;

import lombok.RequiredArgsConstructor;
import org.example.javaprojet.Entity.Recommandation;
import org.example.javaprojet.Entity.Contenu;
import org.example.javaprojet.Repository.RecommandationRepository;
import org.example.javaprojet.Repository.ContenuRepository;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class RecommandationService {

    private final RecommandationRepository recommandationRepository;
    private final ContenuRepository contenuRepository;

    public List<Contenu> getRecommendedContentForUser(String utilisateurId) {
        List<Recommandation> recs = recommandationRepository.findByUtilisateurId(utilisateurId);

        // Map recommendation entities to actual content entities
        return recs.stream()
                .map(rec -> contenuRepository.findById(rec.getContenuId()).orElse(null))
                .filter(content -> content != null)
                .collect(Collectors.toList());
    }
}
