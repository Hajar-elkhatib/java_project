package org.example.javaprojet.Repository;

import org.example.javaprojet.Entity.Personne;
import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface PersonneRepository extends MongoRepository<Personne, String> {

    java.util.List<Personne> findByNomContainingIgnoreCase(String nom);
}
