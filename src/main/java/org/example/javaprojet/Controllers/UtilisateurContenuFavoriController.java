package org.example.javaprojet.Controllers;

import lombok.RequiredArgsConstructor;
import org.example.javaprojet.Entity.Utilisateur_Contenu_Favori;
import org.example.javaprojet.Services.UtilisateurContenuFavoriService;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/favoris")
@RequiredArgsConstructor
public class UtilisateurContenuFavoriController {

    private final UtilisateurContenuFavoriService service;

    // Ajouter aux favoris
    @PostMapping
    public Utilisateur_Contenu_Favori ajouter(@RequestBody Utilisateur_Contenu_Favori favori) {
        return service.ajouterFavori(favori);
    }

    //  Favoris d’un utilisateur
    @GetMapping("/utilisateur/{utilisateurId}")
    public List<Utilisateur_Contenu_Favori> favorisParUtilisateur(
            @PathVariable String utilisateurId) {
        return service.getFavorisByUtilisateur(utilisateurId);
    }

    //  Favoris par contenu
    @GetMapping("/contenu/{contenuId}")
    public List<Utilisateur_Contenu_Favori> favorisParContenu(
            @PathVariable String contenuId) {
        return service.getFavorisByContenu(contenuId);
    }

    //  Supprimer favori
    @DeleteMapping("/{id}")
    public void supprimer(@PathVariable String id) {
        service.supprimerFavori(id);
    }
}
