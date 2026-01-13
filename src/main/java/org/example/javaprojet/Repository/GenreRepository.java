package org.example.javaprojet.Repository;

import org.example.javaprojet.Entity.Genre;
import org.springframework.data.mongodb.repository.MongoRepository;

import java.util.Optional;

public interface GenreRepository extends MongoRepository<Genre, String> {
    Optional<Genre> findByNom(String nom);
}
