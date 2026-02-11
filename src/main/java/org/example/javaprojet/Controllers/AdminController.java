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

    @GetMapping("/dashboard")
    public String dashboard(@RequestParam(required = false) String search,
            @RequestParam(required = false) String type,
            Model model) {
        // Get users
        model.addAttribute("users", utilisateurService.getAllUtilisateurs());

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
        model.addAttribute("isEdit", false);
        return "admin-content-form";
    }

    @GetMapping("/contents/edit/{id}")
    public String editContentForm(@PathVariable String id, Model model) {
        model.addAttribute("content", contenuService.getContenuById(id));
        model.addAttribute("isEdit", true);
        return "admin-content-form";
    }

    @PostMapping("/contents/save")
    public String saveContent(@ModelAttribute Contenu contenu) {
        contenuService.saveContenu(contenu);
        return "redirect:/admin/dashboard";
    }

    @PostMapping("/contents/delete/{id}")
    public String deleteContent(@PathVariable String id) {
        contenuService.deleteContenu(id);
        return "redirect:/admin/dashboard";
    }

    // --- Gestion des Utilisateurs ---

    @PostMapping("/users/delete/{id}")
    public String deleteUser(@PathVariable String id) {
        utilisateurService.deleteUtilisateur(id);
        return "redirect:/admin/dashboard";
    }

    @PostMapping("/users/status/{id}")
    public String changeUserStatus(@PathVariable String id, @RequestParam String status) {
        utilisateurService.changerStatut(id, status);
        return "redirect:/admin/dashboard";
    }

    @PostMapping("/comments/block/{id}")
    public String blockComment(@PathVariable String id, @RequestParam String movieId) {
        feedbackService.blockComment(id);
        return "redirect:/movies/" + movieId;
    }
}
