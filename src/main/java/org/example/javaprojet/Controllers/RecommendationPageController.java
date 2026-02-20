package org.example.javaprojet.Controllers;

import lombok.RequiredArgsConstructor;
import org.example.javaprojet.Entity.Contenu;
import org.example.javaprojet.Entity.Utilisateur;
import org.example.javaprojet.Services.ContenuService;
import org.example.javaprojet.Services.RecommandationService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import jakarta.servlet.http.HttpSession;
import java.util.List;
import java.util.stream.Collectors;

@Controller
@RequestMapping("/recommendations")
@RequiredArgsConstructor
public class RecommendationPageController {

    private final ContenuService contenuService;
    private final RecommandationService recommandationService;

    @GetMapping
    public String recommendations(HttpSession session, Model model) {
        Utilisateur user = (Utilisateur) session.getAttribute("user");

        // Check login
        if (user == null) {
            return "redirect:/login";
        }

        // Get recommended Contenu objects for this user from MongoDB
        List<Contenu> recs = recommandationService.getRecommendedContentForUser(user.getUtilisateurId());

        // If no recommendations yet → fallback to trending
        if (recs.isEmpty()) {
            recs = contenuService.getTrendingContent();
        }

        // Split by type for the JSP sections
        // Matches your Contenu.typeContenu field values
        model.addAttribute("films", recs.stream()
                .filter(c -> "FILM".equalsIgnoreCase(c.getTypeContenu()))
                .collect(Collectors.toList()));

        model.addAttribute("series", recs.stream()
                .filter(c -> "SERIE".equalsIgnoreCase(c.getTypeContenu()))
                .collect(Collectors.toList()));

        model.addAttribute("documentaires", recs.stream()
                .filter(c -> "DOCUMENTAIRE".equalsIgnoreCase(c.getTypeContenu()))
                .collect(Collectors.toList()));

        model.addAttribute("allRecommendations", recs);

        return "recommendations";
    }
}