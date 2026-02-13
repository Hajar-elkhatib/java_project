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

        // CHECK LOGIN
        if (user == null) {
            return "redirect:/login";
        }

        List<Contenu> recs = recommandationService.getRecommendedContentForUser(user.getUtilisateurId());

        // If no personalized recommendations, use trending content as fallback
        if (recs.isEmpty()) {
            recs = contenuService.getTrendingContent();
        }

        // Categorize recommendations
        model.addAttribute("films", recs.stream()
                .filter(c -> "Film".equalsIgnoreCase(c.getTypeContenu()))
                .collect(Collectors.toList()));

        model.addAttribute("series", recs.stream()
                .filter(c -> "Serie".equalsIgnoreCase(c.getTypeContenu()))
                .collect(Collectors.toList()));

        model.addAttribute("documentaires", recs.stream()
                .filter(c -> "Documentaire".equalsIgnoreCase(c.getTypeContenu()))
                .collect(Collectors.toList()));

        model.addAttribute("allRecommendations", recs);

        return "recommendations";
    }
}
