package org.example.javaprojet.Repository;

import org.example.javaprojet.Entity.Evaluation;
import org.springframework.data.mongodb.repository.MongoRepository;
import java.util.List;
import java.util.Optional;

public interface EvaluationRepository extends MongoRepository<Evaluation, String> {
    List<Evaluation> findByContenuId(String contenuId);

    Optional<Evaluation> findByUtilisateurIdAndContenuId(String utilisateurId, String contenuId);

    List<Evaluation> findByUtilisateurId(String utilisateurId);

    long countByUtilisateurId(String utilisateurId);

    long countByUtilisateurIdAndDateEvaluationGreaterThan(String utilisateurId, java.util.Date date);
}
