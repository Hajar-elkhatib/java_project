package org.example.javaprojet.Repository;

import org.example.javaprojet.Entity.Saison;
import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface SaisonRepository extends MongoRepository<Saison, String> {
    List<Saison> findByContenuId(String contenuId);
}
