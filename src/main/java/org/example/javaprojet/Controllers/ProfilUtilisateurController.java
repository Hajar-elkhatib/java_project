package org.example.javaprojet.Controllers;

import lombok.RequiredArgsConstructor;
import org.example.javaprojet.Entity.ProfileUtilisateur;
import org.example.javaprojet.Services.ProfilUtilisateurService;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/profils")
@RequiredArgsConstructor
public class ProfilUtilisateurController {

    private final ProfilUtilisateurService profilService;

    // Créer un profil
    @PostMapping
    public ProfileUtilisateur creerProfil(@RequestBody ProfileUtilisateur profil) {
        return profilService.creerProfil(profil);
    }

    //  Liste des profils
    @GetMapping
    public List<ProfileUtilisateur> getAllProfils() {
        return profilService.getAllProfils();
    }

    // recherche Profil par ID
    @GetMapping("/{id}")
    public ProfileUtilisateur getProfilById(@PathVariable String id) {
        return profilService.getProfilById(id);
    }

    //  Mettre à jour un profil
    @PutMapping("/{id}")
    public ProfileUtilisateur updateProfil(
            @PathVariable String id,
            @RequestBody ProfileUtilisateur profil) {
        return profilService.updateProfil(id, profil);
    }

    //  Supprimer un profil
    @DeleteMapping("/{id}")
    public void deleteProfil(@PathVariable String id) {
        profilService.deleteProfil(id);
    }
}
