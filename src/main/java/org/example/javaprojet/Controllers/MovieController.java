package org.example.javaprojet.Controllers;

import lombok.RequiredArgsConstructor;
import org.example.javaprojet.Entity.Contenu;
import org.example.javaprojet.Entity.Utilisateur;
import org.example.javaprojet.Services.ContenuService;
import org.example.javaprojet.Services.FeedbackService;
import org.example.javaprojet.Services.ParticipationService;

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
    public String movieDetails(@PathVariable String id, Model model) {
        Contenu movie = contenuService.getContenuById(id);
        model.addAttribute("movie", movie);
        model.addAttribute("comments", feedbackService.getCommentsForContent(id));
        model.addAttribute("actors", participationService.getCastByContenu(id));

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
    public String addComment(@PathVariable String id, @RequestParam String texte, HttpSession session) {
        Utilisateur user = (Utilisateur) session.getAttribute("user");
        if (user != null) {
            feedbackService.addComment(texte, user.getUtilisateurId(), user.getNom() + " " + user.getPrenom(), id);
        }
        return "redirect:/movies/" + id;
    }

    @PostMapping("/{id}/rate")
    public String rateMovie(@PathVariable String id, @RequestParam int note, HttpSession session) {
        Utilisateur user = (Utilisateur) session.getAttribute("user");
        if (user != null) {
            feedbackService.addOrUpdateRating(user.getUtilisateurId(), id, note);
        }
        return "redirect:/movies/" + id;
    }
}
