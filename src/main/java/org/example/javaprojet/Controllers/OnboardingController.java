package org.example.javaprojet.Controllers;

import lombok.RequiredArgsConstructor;
import org.example.javaprojet.Entity.Utilisateur;
import org.example.javaprojet.Services.ContenuService;
import org.example.javaprojet.Services.GenreService;
import org.example.javaprojet.Services.RecommandationService;
import org.example.javaprojet.Services.UtilisateurService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import jakarta.servlet.http.HttpSession;
import java.util.List;

@Controller
@RequestMapping("/onboarding")
@RequiredArgsConstructor
public class OnboardingController {

    private final ContenuService contenuService;
    private final GenreService genreService;
    private final UtilisateurService utilisateurService;
    private final RecommandationService recommandationService; // ← ADDED

    @GetMapping
    public String showOnboarding(HttpSession session, Model model) {
        Utilisateur user = (Utilisateur) session.getAttribute("user");
        if (user == null || !user.isFirstLogin()) {
            return "redirect:/";
        }

        model.addAttribute("genres", genreService.getAllGenres());
        model.addAttribute("contents", contenuService.getAllContenus());
        return "onboarding";
    }

    @PostMapping
    public String saveOnboarding(
            @RequestParam(required = false) List<String> genres,
            @RequestParam(required = false) List<String> liked,
            HttpSession session) {

        Utilisateur user = (Utilisateur) session.getAttribute("user");
        if (user == null)
            return "redirect:/login";

        String userId = user.getUtilisateurId();

        // Step 1 — Save preferences in MongoDB
        utilisateurService.savePreferences(userId, genres, liked);

        // Step 2 — Call Flask AI to generate recommendations
        try {
            recommandationService.generateOnboardingRecommendations(userId);
        } catch (Exception e) {
            // Don't block the user if AI fails — just log it
            System.err.println("⚠️ AI recommendation generation failed: " + e.getMessage());
        }

        // Step 3 — Update session
        user.setFirstLogin(false);
        user.setPreferredGenreIds(genres);
        user.setLikedContentIds(liked);
        session.setAttribute("user", user);

        // Step 4 — Redirect to recommendations page
        return "redirect:/recommendations";
    }
}