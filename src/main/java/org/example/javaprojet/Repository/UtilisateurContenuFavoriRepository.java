package org.example.javaprojet.Repository;

import org.example.javaprojet.Entity.Utilisateur_Contenu_Favori;
import org.springframework.data.mongodb.repository.MongoRepository;

import java.util.List;

public interface UtilisateurContenuFavoriRepository  extends MongoRepository<Utilisateur_Contenu_Favori, String> {
    List<Utilisateur_Contenu_Favori> findByUtilisateurId(String utilisateurId);

    List<Utilisateur_Contenu_Favori> findByContenuId(String contenuId);

    boolean existsByUtilisateurIdAndContenuId(String utilisateurId, String contenuId);
}
