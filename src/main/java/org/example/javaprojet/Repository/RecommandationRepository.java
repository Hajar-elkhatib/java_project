package org.example.javaprojet.Repository;

import org.example.javaprojet.Entity.Recommandation;
import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface RecommandationRepository extends MongoRepository<Recommandation, String> {
    List<Recommandation> findByUtilisateurId(String utilisateurId);
}
