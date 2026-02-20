package org.example.javaprojet.Controllers;

import lombok.RequiredArgsConstructor;
import org.example.javaprojet.Entity.Contenu;
import org.example.javaprojet.Entity.Utilisateur;
import org.example.javaprojet.Services.ContenuService;
import org.example.javaprojet.Services.FeedbackService;
import org.example.javaprojet.Services.ParticipationService;
import org.example.javaprojet.Services.UtilisateurContenuFavoriService;

import java.util.List;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/movies")
@RequiredArgsConstructor
public class MovieController {

    private final ContenuService contenuService;
    private final FeedbackService feedbackService;
    private final ParticipationService participationService;
    private final UtilisateurContenuFavoriService favoriteService;
    private final org.example.javaprojet.Services.HistoriqueInteractionService historiqueService;
    private final org.example.javaprojet.Services.BadgeService badgeService;

    @GetMapping
    public String listMovies(@RequestParam(required = false) String search, Model model) {
        if (search != null && !search.isEmpty()) {
            model.addAttribute("contents", contenuService.searchContenus(search));
        } else {
            model.addAttribute("contents", contenuService.getAllContenus());
        }
        return "movies";
    }

    @GetMapping("/{id}")
    public String movieDetails(@PathVariable String id, Model model, HttpSession session) {
        Contenu movie = contenuService.getContenuById(id);
        model.addAttribute("movie", movie);
        model.addAttribute("comments", feedbackService.getCommentsForContent(id));
        model.addAttribute("actors", participationService.getCastByContenu(id));
        model.addAttribute("genreNames", contenuService.getGenreNames(movie.getGenreIds()));

        // Check if favorite
        Utilisateur user = (Utilisateur) session.getAttribute("user");
        if (user != null) {
            boolean isFavorite = favoriteService.getFavorisByUtilisateur(user.getUtilisateurId()).stream()
                    .anyMatch(f -> f.getContenuId().equals(id));
            model.addAttribute("isFavorite", isFavorite);

            // Log View Interaction
            org.example.javaprojet.Entity.HistoriqueInteraction interaction = new org.example.javaprojet.Entity.HistoriqueInteraction();
            interaction.setUtilisateurId(user.getUtilisateurId());
            interaction.setContenuId(id);
            interaction.setTypeInteraction("VUE");
            historiqueService.ajouterInteraction(interaction);
        }

        if ("Serie".equalsIgnoreCase(movie.getTypeContenu())) {
            model.addAttribute("saisons", contenuService.getSaisonsByContenuId(id));
        }

        return "movie-details";
    }

    @GetMapping("/saisons/{saisonId}/episodes")
    @ResponseBody
    public List<org.example.javaprojet.Entity.Episode> getEpisodes(@PathVariable String saisonId) {
        return contenuService.getEpisodesBySaisonId(saisonId);
    }

    @PostMapping("/{id}/comment")
    public String addComment(@PathVariable String id, @RequestParam String texte, HttpSession session,
            org.springframework.web.servlet.mvc.support.RedirectAttributes redirectAttributes) {
        Utilisateur user = (Utilisateur) session.getAttribute("user");
        if (user != null) {
            if (!badgeService.canPerformAction(user.getUtilisateurId(), "COMMENTAIRE")) {
                redirectAttributes.addFlashAttribute("error",
                        "Limite de commentaires atteinte pour aujourd'hui. Augmentez votre badge en participant davantage !");
                return "redirect:/movies/" + id;
            }

            feedbackService.addComment(texte, user.getUtilisateurId(), user.getNom() + " " + user.getPrenom(), id);

            // Log Comment Interaction
            org.example.javaprojet.Entity.HistoriqueInteraction interaction = new org.example.javaprojet.Entity.HistoriqueInteraction();
            interaction.setUtilisateurId(user.getUtilisateurId());
            interaction.setContenuId(id);
            interaction.setTypeInteraction("COMMENTAIRE");
            historiqueService.ajouterInteraction(interaction);

            // Check for badge upgrade
            badgeService.updateAndGetBadge(user.getUtilisateurId());
        }
        return "redirect:/movies/" + id;
    }

    @PostMapping("/{id}/rate")
    public String rateMovie(@PathVariable String id, @RequestParam int note, HttpSession session,
            org.springframework.web.servlet.mvc.support.RedirectAttributes redirectAttributes) {
        Utilisateur user = (Utilisateur) session.getAttribute("user");
        if (user != null) {
            if (!badgeService.canPerformAction(user.getUtilisateurId(), "EVALUATION")) {
                redirectAttributes.addFlashAttribute("error",
                        "Limite de notes atteinte pour aujourd'hui. Augmentez votre badge en participant davantage !");
                return "redirect:/movies/" + id;
            }

            feedbackService.addOrUpdateRating(user.getUtilisateurId(), id, note);

            // Log Rating Interaction
            org.example.javaprojet.Entity.HistoriqueInteraction interaction = new org.example.javaprojet.Entity.HistoriqueInteraction();
            interaction.setUtilisateurId(user.getUtilisateurId());
            interaction.setContenuId(id);
            interaction.setTypeInteraction("EVALUATION");
            historiqueService.ajouterInteraction(interaction);

            // Check for badge upgrade
            badgeService.updateAndGetBadge(user.getUtilisateurId());
        }
        return "redirect:/movies/" + id;
    }
}
