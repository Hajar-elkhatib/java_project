package org.example.javaprojet.Repository;

import org.example.javaprojet.Entity.Utilisateur_Badge;
import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface UtilisateurBadgeRepository extends MongoRepository<Utilisateur_Badge, String> {

    List<Utilisateur_Badge> findByUtilisateurId(String utilisateurId);

    List<Utilisateur_Badge> findByBadgeId(String badgeId);

    long countByUtilisateurId(String utilisateurId);
}
