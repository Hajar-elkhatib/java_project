package org.example.javaprojet.Controllers;
import lombok.RequiredArgsConstructor;
import org.example.javaprojet.Entity.Badge;
import org.example.javaprojet.Services.BadgeService;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/badges")
@RequiredArgsConstructor
public class BadgeController {
    private final BadgeService badgeService;

    //  Ajouter un badge
    @PostMapping
    public Badge ajouterBadge(@RequestBody Badge badge) {
        return badgeService.ajouterBadge(badge);
    }

    //  Liste des badges
    @GetMapping
    public List<Badge> getAllBadges() {
        return badgeService.getAllBadges();
    }

    // recherche Badge par ID
    @GetMapping("/{id}")
    public Badge getBadgeById(@PathVariable String id) {
        return badgeService.getBadgeById(id);
    }

    // recherche Badge par nom
    @GetMapping("/nom/{nom}")
    public Badge getBadgeByNom(@PathVariable String nom) {
        return badgeService.getBadgeByNom(nom);
    }

    // ✏ Modifier un badge
    @PutMapping("/{id}")
    public Badge modifierBadge(
            @PathVariable String id,
            @RequestBody Badge badge) {
        return badgeService.modifierBadge(id, badge);
    }

    //  Supprimer un badge
    @DeleteMapping("/{id}")
    public void supprimerBadge(@PathVariable String id) {
        badgeService.supprimerBadge(id);
    }
}
