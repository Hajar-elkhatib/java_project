package org.example.javaprojet.Controllers;

import lombok.RequiredArgsConstructor;
import org.example.javaprojet.Entity.Utilisateur_Badge;
import org.example.javaprojet.Services.UtilisateurBadgeService;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/utilisateur-badges")
@RequiredArgsConstructor
public class UtilisateurBadgeController {

    private final UtilisateurBadgeService service;

    //  Attribuer un badge à un utilisateur
    @PostMapping
    public Utilisateur_Badge attribuerBadge(@RequestBody Utilisateur_Badge ub) {
        return service.attribuerBadge(ub);
    }

    //  Badges d’un utilisateur
    @GetMapping("/utilisateur/{utilisateurId}")
    public List<Utilisateur_Badge> badgesParUtilisateur(
            @PathVariable String utilisateurId) {
        return service.getBadgesByUtilisateur(utilisateurId);
    }

    //  Utilisateurs par badge
    @GetMapping("/badge/{badgeId}")
    public List<Utilisateur_Badge> utilisateursParBadge(
            @PathVariable String badgeId) {
        return service.getUtilisateursByBadge(badgeId);
    }

    // Supprimer attribution
    @DeleteMapping("/{id}")
    public void supprimer(@PathVariable String id) {
        service.supprimerAttribution(id);
    }
}
