package org.example.javaprojet.Repository;

import org.example.javaprojet.Entity.Badge;
import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface BadgeRepository extends MongoRepository<Badge,String> {
    Optional<Badge> findByNom(String nom);

}
