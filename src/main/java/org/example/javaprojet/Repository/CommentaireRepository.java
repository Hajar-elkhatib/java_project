package org.example.javaprojet.Repository;

import org.example.javaprojet.Entity.Commentaire;
import org.springframework.data.mongodb.repository.MongoRepository;
import java.util.List;

public interface CommentaireRepository extends MongoRepository<Commentaire, String> {
    List<Commentaire> findByContenuId(String contenuId);

    List<Commentaire> findByContenuIdAndIsBlockedFalse(String contenuId);

    List<Commentaire> findByUtilisateurId(String utilisateurId);
}
