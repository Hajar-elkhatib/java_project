package org.example.javaprojet.Repository;

import org.example.javaprojet.Entity.Episode;
import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface EpisodeRepository extends MongoRepository<Episode, String> {
    List<Episode> findBySaisonId(String saisonId);
}
