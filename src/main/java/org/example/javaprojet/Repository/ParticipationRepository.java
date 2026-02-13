package org.example.javaprojet.Repository;

import org.example.javaprojet.Entity.Participation;
import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ParticipationRepository extends MongoRepository<Participation, String> {
    List<Participation> findByContenuId(String contenuId);
}
