package org.example.javaprojet.Repository;

import org.example.javaprojet.Entity.Commentaire;
import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface CommentaireRepository extends MongoRepository<Commentaire, String> {
}
