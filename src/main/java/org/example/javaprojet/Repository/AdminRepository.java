package org.example.javaprojet.Repository;

import org.example.javaprojet.Entity.Admin;
import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface AdminRepository extends MongoRepository<Admin, String> {
    // Recherche par email
    Optional<Admin> findByEmail(String email);
}
