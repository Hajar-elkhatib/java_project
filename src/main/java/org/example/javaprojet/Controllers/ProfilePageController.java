package org.example.javaprojet.Controllers;

import lombok.RequiredArgsConstructor;
import org.example.javaprojet.Entity.Badge;
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
    private final org.example.javaprojet.Services.BadgeService badgeService;
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

        // Fetch current badge and score
        Badge currentBadge = badgeService.updateAndGetBadge(user.getUtilisateurId());
        double currentScore = badgeService.calculateUserScore(user.getUtilisateurId());

        // Fetch Stats
        long favCount = favoriService.countByUtilisateur(user.getUtilisateurId());
        long badgeCount = 1; // Default to at least 1 badge
        long watchedCount = historiqueService.countByUtilisateur(user.getUtilisateurId(), "VUE");

        // Sync niveauBadge if needed
        if (user.getNiveauBadge() != currentBadge.getNiveau()) {
            user.setNiveauBadge(currentBadge.getNiveau());
            utilisateurService.updateUtilisateur(user.getUtilisateurId(), user);
        }

        model.addAttribute("badge", currentBadge);
        model.addAttribute("score", currentScore);
        model.addAttribute("favCount", favCount);
        model.addAttribute("badgeCount", badgeCount);
        model.addAttribute("watchedCount", watchedCount);

        // Fetch Favorites List
        List<Utilisateur_Contenu_Favori> favoris = favoriService.getFavorisByUtilisateur(user.getUtilisateurId());
        List<String> favIds = favoris.stream().map(Utilisateur_Contenu_Favori::getContenuId)
                .collect(Collectors.toList());
        List<Contenu> favoriteMovies = contenuService.getContenusByIds(favIds);
        model.addAttribute("favoriteMovies", favoriteMovies);

        // Fetch History List
        List<HistoriqueInteraction> history = historiqueService.getByUtilisateur(user.getUtilisateurId());
        List<org.example.javaprojet.DTO.HistoryDTO> historyDTOs = history.stream().map(h -> {
            org.example.javaprojet.DTO.HistoryDTO dto = new org.example.javaprojet.DTO.HistoryDTO();
            dto.setId(h.getId());
            dto.setTypeInteraction(h.getTypeInteraction());
            dto.setDate(h.getDateHeure());
            dto.setMovie(contenuService.getContenuById(h.getContenuId()));
            return dto;
        }).collect(Collectors.toList());

        // Reverse history to show latest first
        java.util.Collections.reverse(historyDTOs);
        model.addAttribute("historyItems", historyDTOs);

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
