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

@Controller
@RequestMapping("/admin")
@RequiredArgsConstructor
public class AdminController {

    private final AdminService adminService;
    private final UtilisateurService utilisateurService;
    private final ContenuService contenuService;
    private final FeedbackService feedbackService;

    @GetMapping
    public String dashboard(Model model) {
        model.addAttribute("users", utilisateurService.getAllUtilisateurs());
        model.addAttribute("contents", contenuService.getAllContenus());
        return "admin";
    }

    // --- Gestion du Catalogue ---

    @GetMapping("/contents/add")
    public String addContentForm(Model model) {
        model.addAttribute("content", new Contenu());
        return "admin-content-form";
    }

    @GetMapping("/contents/edit/{id}")
    public String editContentForm(@PathVariable String id, Model model) {
        model.addAttribute("content", contenuService.getContenuById(id));
        return "admin-content-form";
    }

    @PostMapping("/contents/save")
    public String saveContent(@ModelAttribute Contenu contenu) {
        contenuService.saveContenu(contenu);
        return "redirect:/admin";
    }

    @PostMapping("/contents/delete/{id}")
    public String deleteContent(@PathVariable String id) {
        contenuService.deleteContenu(id);
        return "redirect:/admin";
    }

    // --- Gestion des Utilisateurs ---

    @PostMapping("/users/delete/{id}")
    public String deleteUser(@PathVariable String id) {
        utilisateurService.deleteUtilisateur(id);
        return "redirect:/admin";
    }

    @PostMapping("/users/status/{id}")
    public String changeUserStatus(@PathVariable String id, @RequestParam String status) {
        utilisateurService.changerStatut(id, status);
        return "redirect:/admin";
    }

    @PostMapping("/comments/block/{id}")
    public String blockComment(@PathVariable String id, @RequestParam String movieId) {
        feedbackService.blockComment(id);
        return "redirect:/movies/" + movieId;
    }
}
