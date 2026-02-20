package org.example.javaprojet.Repository;

import lombok.RequiredArgsConstructor;
import org.example.javaprojet.Entity.HistoriqueInteraction;
import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface HistoriqueInteractionRepository extends MongoRepository<HistoriqueInteraction, String> {

    List<HistoriqueInteraction> findByTypeInteraction(String typeInteraction);

    List<HistoriqueInteraction> findByUtilisateurId(String utilisateurId);

    List<HistoriqueInteraction> findByContenuId(String contenuId);

    long countByUtilisateurIdAndTypeInteraction(String utilisateurId, String typeInteraction);

    long countByUtilisateurIdAndTypeInteractionAndDateHeureGreaterThan(String utilisateurId, String typeInteraction,
            java.util.Date date);

    boolean existsByUtilisateurIdAndContenuIdAndTypeInteractionAndDateHeureGreaterThan(String utilisateurId,
            String contenuId, String typeInteraction, java.util.Date date);
}
