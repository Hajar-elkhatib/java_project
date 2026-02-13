package org.example.javaprojet.Controllers;

import lombok.RequiredArgsConstructor;
import org.example.javaprojet.Entity.Contenu;
import org.example.javaprojet.Entity.HistoriqueInteraction;
import org.example.javaprojet.Entity.Utilisateur;
import org.example.javaprojet.Entity.Utilisateur_Contenu_Favori;
import org.example.javaprojet.Services.*;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import jakarta.servlet.http.HttpSession;
import java.util.List;
import java.util.stream.Collectors;

@Controller
@RequestMapping("/profile")
@RequiredArgsConstructor
public class ProfilePageController {

    private final UtilisateurService utilisateurService;
    private final UtilisateurContenuFavoriService favoriService;
    private final UtilisateurBadgeService badgeService;
    private final HistoriqueInteractionService historiqueService;
    private final ContenuService contenuService;

    @GetMapping
    public String profile(HttpSession session, Model model) {
        Utilisateur user = (Utilisateur) session.getAttribute("user");
        if (user == null) {
            return "redirect:/login";
        }
        // Refresh user data
        user = utilisateurService.getUtilisateurById(user.getUtilisateurId());
        session.setAttribute("user", user);

        // Fetch Stats
        long favCount = favoriService.countByUtilisateur(user.getUtilisateurId());
        long badgeCount = badgeService.countByUtilisateur(user.getUtilisateurId());
        long watchedCount = historiqueService.countByUtilisateur(user.getUtilisateurId(), "VUE");

        model.addAttribute("favCount", favCount);
        model.addAttribute("badgeCount", badgeCount);
        model.addAttribute("watchedCount", watchedCount);

        // Fetch Favorites List
        List<Utilisateur_Contenu_Favori> favoris = favoriService.getFavorisByUtilisateur(user.getUtilisateurId());
        List<String> favIds = favoris.stream().map(Utilisateur_Contenu_Favori::getContenuId)
                .collect(Collectors.toList());
        List<Contenu> favoriteMovies = contenuService.getContenusByIds(favIds);
        model.addAttribute("favoriteMovies", favoriteMovies);

        // Fetch History List (VUE only for simplicity in display, or all)
        List<HistoriqueInteraction> history = historiqueService.getByUtilisateur(user.getUtilisateurId());
        // We need to map history to content manually in JSP or prepare a DTO.
        // Simpler approach: pass all history and let JSP loop, but we need content
        // details.
        // Let's passed contents related to history
        List<String> historyContentIds = history.stream().map(HistoriqueInteraction::getContenuId)
                .collect(Collectors.toList());
        List<Contenu> historyMovies = contenuService.getContenusByIds(historyContentIds);
        model.addAttribute("historyMovies", historyMovies);
        // Note: Linking history items to movies might require a Map or DTO if we want
        // to show "Date - Movie".
        // For now, let's just show the list of movies found in history.

        return "profile";
    }

    @PostMapping("/update")
    public String updateProfile(@RequestParam String nom,
            @RequestParam String prenom,
            HttpSession session,
            Model model) {
        Utilisateur user = (Utilisateur) session.getAttribute("user");
        if (user == null) {
            return "redirect:/login";
        }

        user.setNom(nom);
        user.setPrenom(prenom);

        try {
            utilisateurService.updateUtilisateur(user.getUtilisateurId(), user);
            session.setAttribute("user", user); // Update session
            return "redirect:/profile?success=true";
        } catch (Exception e) {
            model.addAttribute("error", "Erreur lors de la mise à jour");
            return "profile";
        }
    }
}
