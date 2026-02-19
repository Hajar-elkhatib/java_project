package org.example.javaprojet.Controllers;

import lombok.RequiredArgsConstructor;
import org.example.javaprojet.Entity.Contenu;
import org.example.javaprojet.Services.AdminService;
import org.example.javaprojet.Services.UtilisateurService;
import org.example.javaprojet.Services.ContenuService;
import org.example.javaprojet.Services.FeedbackService;
import org.springframework.web.bind.annotation.*;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;

import java.util.List;

@Controller
@RequestMapping("/admin")
@RequiredArgsConstructor
public class AdminController {

    private final AdminService adminService;
    private final UtilisateurService utilisateurService;
    private final ContenuService contenuService;
    private final FeedbackService feedbackService;
    private final org.example.javaprojet.Services.GenreService genreService;

    @GetMapping("/dashboard")
    public String dashboard(@RequestParam(required = false) String search,
            @RequestParam(required = false) String type,
            Model model) {
        // Get users and genres
        model.addAttribute("users", utilisateurService.getAllUtilisateurs());
        model.addAttribute("genres", genreService.getAllGenres());

        // Get contents with filters
        List<Contenu> contents;
        if (search != null && !search.trim().isEmpty()) {
            contents = contenuService.searchContenus(search);
        } else if (type != null && !type.trim().isEmpty()) {
            contents = contenuService.getContenusByType(type);
        } else {
            contents = contenuService.getAllContenus();
        }
        model.addAttribute("contents", contents);

        // Statistics
        model.addAttribute("totalUsers", utilisateurService.getAllUtilisateurs().size());
        model.addAttribute("totalGenres", genreService.getAllGenres().size());
        model.addAttribute("totalContents", contenuService.getAllContenus().size());
        model.addAttribute("totalMovies", contenuService.getContenusByType("FILM").size());
        model.addAttribute("totalSeries", contenuService.getContenusByType("SERIE").size());

        // Keep filter values
        model.addAttribute("currentSearch", search);
        model.addAttribute("currentType", type);

        return "admin-dashboard";
    }

    // Redirect /admin to /admin/dashboard
    @GetMapping
    public String redirectToDashboard() {
        return "redirect:/admin/dashboard";
    }

    // --- Gestion du Catalogue ---

    @GetMapping("/contents/add")
    public String addContentForm(Model model) {
        model.addAttribute("content", new Contenu());
        model.addAttribute("genres", genreService.getAllGenres());
        model.addAttribute("isEdit", false);
        return "admin-content-form";
    }

    @GetMapping("/contents/edit/{id}")
    public String editContentForm(@PathVariable String id, Model model) {
        Contenu content = contenuService.getContenuById(id);
        model.addAttribute("content", content);
        model.addAttribute("genres", genreService.getAllGenres());
        model.addAttribute("isEdit", true);

        // Load Seasons and Episodes if it's a Series
        if ("SERIE".equals(content.getTypeContenu())) {
            List<org.example.javaprojet.Entity.Saison> saisons = contenuService.getSaisonsByContenuId(id);
            model.addAttribute("saisons", saisons);

            java.util.Map<String, List<org.example.javaprojet.Entity.Episode>> episodesMap = new java.util.HashMap<>();
            for (org.example.javaprojet.Entity.Saison s : saisons) {
                episodesMap.put(s.getId(), contenuService.getEpisodesBySaisonId(s.getId()));
            }
            model.addAttribute("episodesMap", episodesMap);
        }

        return "admin-content-form";
    }

    @PostMapping("/contents/save")
    public String saveContent(@ModelAttribute Contenu contenu,
            @RequestParam(required = false) List<String> genreIds) {
        if (genreIds != null) {
            contenu.setGenreIds(genreIds);
        }
        contenuService.saveContenu(contenu);
        return "redirect:/admin/dashboard#contents";
    }

    @PostMapping("/contents/delete/{id}")
    public String deleteContent(@PathVariable String id) {
        contenuService.deleteContenu(id);
        return "redirect:/admin/dashboard#contents";
    }

    // --- Gestion Saisons & Episodes ---
    // ... existing season/episode methods ...

    // --- Gestion des Utilisateurs ---

    @PostMapping("/users/delete/{id}")
    public String deleteUser(@PathVariable String id) {
        utilisateurService.deleteUtilisateur(id);
        return "redirect:/admin/dashboard#users";
    }

    @PostMapping("/users/status/{id}")
    public String changeUserStatus(@PathVariable String id, @RequestParam String status) {
        utilisateurService.changerStatut(id, status);
        return "redirect:/admin/dashboard#users";
    }

    // ... existing feedback method ...

    // --- Gestion des Genres ---

    @PostMapping("/genres/save")
    public String saveGenre(@ModelAttribute org.example.javaprojet.Entity.Genre genre) {
        if (genre.getId() != null && !genre.getId().isEmpty()) {
            genreService.modifierGenre(genre.getId(), genre);
        } else {
            genreService.ajouterGenre(genre);
        }
        return "redirect:/admin/dashboard#genres";
    }

    @PostMapping("/genres/delete/{id}")
    public String deleteGenre(@PathVariable String id) {
        genreService.supprimerGenre(id);
        return "redirect:/admin/dashboard#genres";
    }
}
