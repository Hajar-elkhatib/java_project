package org.example.javaprojet.Controllers;

import lombok.RequiredArgsConstructor;
import org.example.javaprojet.Entity.Contenu;
import org.example.javaprojet.Services.ContenuService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;

@Controller
@RequestMapping("/recommendations")
@RequiredArgsConstructor
public class RecommendationPageController {

    private final ContenuService contenuService;

    @GetMapping
    public String recommendations(Model model) {
        // Fetch categorized content
        // We use case-insensitive or standardized types
        List<Contenu> films = contenuService.getContenusByType("Film");
        if (films.isEmpty())
            films = contenuService.getContenusByType("FILM");

        List<Contenu> series = contenuService.getContenusByType("Serie");
        if (series.isEmpty())
            series = contenuService.getContenusByType("SERIE");

        List<Contenu> documentaires = contenuService.getContenusByType("Documentaire");
        if (documentaires.isEmpty())
            documentaires = contenuService.getContenusByType("DOCUMENTAIRE");

        model.addAttribute("films", films);
        model.addAttribute("series", series);
        model.addAttribute("documentaires", documentaires);

        // Also provide all recommendations for compatibility
        model.addAttribute("recommendations", contenuService.getAllContenus());

        return "recommendations";
    }
}
