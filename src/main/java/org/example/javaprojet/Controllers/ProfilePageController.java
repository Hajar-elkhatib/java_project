package org.example.javaprojet.Controllers;

import lombok.RequiredArgsConstructor;
import org.example.javaprojet.Entity.Utilisateur;
import org.example.javaprojet.Services.UtilisateurService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/profile")
@RequiredArgsConstructor
public class ProfilePageController {

    private final UtilisateurService utilisateurService;

    @GetMapping
    public String profile(HttpSession session, Model model) {
        Utilisateur user = (Utilisateur) session.getAttribute("user");
        if (user == null) {
            return "redirect:/login";
        }
        // Refresh user data from DB
        user = utilisateurService.getUtilisateurById(user.getUtilisateurId());
        session.setAttribute("user", user);
        return "profile";
    }

    @PostMapping("/update")
    public String updateProfile(@RequestParam String nom,
            @RequestParam String prenom,
            HttpSession session,
            Model model) {
        Utilisateur user = (Utilisateur) session.getAttribute("user");
        if (user == null) {
            return "redirect:/login";
        }

        user.setNom(nom);
        user.setPrenom(prenom);

        try {
            utilisateurService.updateUtilisateur(user.getUtilisateurId(), user);
            session.setAttribute("user", user); // Update session
            return "redirect:/profile?success=true";
        } catch (Exception e) {
            model.addAttribute("error", "Erreur lors de la mise à jour");
            return "profile";
        }
    }
}
