package org.example.javaprojet.Services;

import lombok.RequiredArgsConstructor;
import org.example.javaprojet.Entity.Utilisateur_Contenu_Favori;
import org.example.javaprojet.Repository.UtilisateurContenuFavoriRepository;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;

@Service
@RequiredArgsConstructor
public class UtilisateurContenuFavoriService {

    private final UtilisateurContenuFavoriRepository repository;

    // ➕ Ajouter aux favoris
    public Utilisateur_Contenu_Favori ajouterFavori(Utilisateur_Contenu_Favori favori) {

        boolean existe = repository.existsByUtilisateurIdAndContenuId(
                favori.getUtilisateurId(),
                favori.getContenuId());

        if (existe) {
            throw new RuntimeException("Contenu déjà dans les favoris");
        }

        favori.setDateAjouter(new Date());
        return repository.save(favori);
    }

    // 📋 Favoris d’un utilisateur
    public List<Utilisateur_Contenu_Favori> getFavorisByUtilisateur(String utilisateurId) {
        return repository.findByUtilisateurId(utilisateurId);
    }

    // 📋 Utilisateurs ayant un contenu en favori
    public List<Utilisateur_Contenu_Favori> getFavorisByContenu(String contenuId) {
        return repository.findByContenuId(contenuId);
    }

    // ❌ Retirer des favoris
    public void supprimerFavori(String id) {
        repository.deleteById(id);
    }

    public long countByUtilisateur(String utilisateurId) {
        return repository.countByUtilisateurId(utilisateurId);
    }
}
