package org.example.javaprojet.Controllers;

import lombok.RequiredArgsConstructor;
import org.example.javaprojet.Entity.Utilisateur;
import org.example.javaprojet.Services.ContenuService;
import org.example.javaprojet.Services.GenreService;
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

        utilisateurService.savePreferences(user.getUtilisateurId(), genres, liked);

        // Update session user object
        user.setFirstLogin(false);
        user.setPreferredGenreIds(genres);
        user.setLikedContentIds(liked);
        session.setAttribute("user", user);

        return "redirect:/?onboarding_complete";
    }
}
