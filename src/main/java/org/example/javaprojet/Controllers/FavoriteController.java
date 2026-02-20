package org.example.javaprojet.Controllers;

import lombok.RequiredArgsConstructor;
import org.example.javaprojet.Entity.Utilisateur;
import org.example.javaprojet.Entity.Utilisateur_Contenu_Favori;
import org.example.javaprojet.Services.UtilisateurContenuFavoriService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/favorites")
@RequiredArgsConstructor
public class FavoriteController {

    private final UtilisateurContenuFavoriService favoriteService;
    private final org.example.javaprojet.Services.HistoriqueInteractionService historiqueService;
    private final org.example.javaprojet.Services.BadgeService badgeService;

    @PostMapping("/add/{contenuId}")
    public String addFavorite(@PathVariable String contenuId, HttpSession session,
            org.springframework.web.servlet.mvc.support.RedirectAttributes redirectAttributes) {
        Utilisateur user = (Utilisateur) session.getAttribute("user");
        if (user == null)
            return "redirect:/login";

        if (!badgeService.canPerformAction(user.getUtilisateurId(), "FAVORI")) {
            redirectAttributes.addFlashAttribute("error",
                    "Limite de favoris atteinte pour aujourd'hui. Augmentez votre badge pour en ajouter plus !");
            return "redirect:/movies/" + contenuId;
        }

        Utilisateur_Contenu_Favori favori = new Utilisateur_Contenu_Favori();
        favori.setUtilisateurId(user.getUtilisateurId());
        favori.setContenuId(contenuId);

        try {
            favoriteService.ajouterFavori(favori);

            // Log Like Interaction
            org.example.javaprojet.Entity.HistoriqueInteraction interaction = new org.example.javaprojet.Entity.HistoriqueInteraction();
            interaction.setUtilisateurId(user.getUtilisateurId());
            interaction.setContenuId(contenuId);
            interaction.setTypeInteraction("LIKE");
            historiqueService.ajouterInteraction(interaction);

            // Check for badge update
            badgeService.updateAndGetBadge(user.getUtilisateurId());
        } catch (Exception e) {
            // Already in favorites, ignore or handle
        }

        return "redirect:/movies/" + contenuId;
    }

    @PostMapping("/remove/{contenuId}")
    public String removeFavorite(@PathVariable String contenuId, HttpSession session) {
        Utilisateur user = (Utilisateur) session.getAttribute("user");
        if (user == null)
            return "redirect:/login";

        favoriteService.getFavorisByUtilisateur(user.getUtilisateurId()).stream()
                .filter(f -> f.getContenuId().equals(contenuId))
                .findFirst()
                .ifPresent(f -> favoriteService.supprimerFavori(f.getId()));

        return "redirect:/movies/" + contenuId;
    }
}
