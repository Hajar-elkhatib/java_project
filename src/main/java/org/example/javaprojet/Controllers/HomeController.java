package org.example.javaprojet.Controllers;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.ui.Model;
import jakarta.servlet.http.HttpSession;
import org.example.javaprojet.Services.UtilisateurService;
import org.example.javaprojet.Services.ContenuService;
import org.example.javaprojet.Entity.Utilisateur;
import org.example.javaprojet.Entity.Contenu;

import java.util.List;

@Controller
@lombok.RequiredArgsConstructor
public class HomeController {

    private final UtilisateurService utilisateurService;
    private final ContenuService contenuService;

    @GetMapping("/")
    public String home(HttpSession session, Model model) {
        Utilisateur user = (Utilisateur) session.getAttribute("user");
        if (user != null && user.isFirstLogin()) {
            return "redirect:/onboarding";
        }
        List<Contenu> featured = contenuService.getTopRatedContent();
        List<Contenu> trending = contenuService.getTrendingContent();
        model.addAttribute("featuredContents", featured);
        model.addAttribute("trendingContents", trending);
        return "index";
    }

    @GetMapping("/login")
    public String login() {
        return "login";
    }

    @GetMapping("/series")
    public String series(Model model) {
        model.addAttribute("contents", contenuService.getContenusByType("Serie"));
        model.addAttribute("pageTitle", "Séries");
        return "movies";
    }

    @GetMapping("/documentaries")
    public String documentaries(Model model) {
        model.addAttribute("contents", contenuService.getContenusByType("Documentaire"));
        model.addAttribute("pageTitle", "Documentaires");
        return "movies";
    }

    @PostMapping("/login")
    public String processLogin(@RequestParam String email,
            @RequestParam String motDePasse,
            HttpSession session,
            Model model) {

        // Admin Login Check
        if ("admin@admin".equals(email) && "admin".equals(motDePasse)) {
            session.removeAttribute("user"); // Clear any previous user session
            session.setAttribute("role", "ADMIN");
            session.setAttribute("adminEmail", email);
            return "redirect:/admin/dashboard";
        }

        // User Login Check
        List<Utilisateur> users = utilisateurService.getAllUtilisateurs();
        for (Utilisateur u : users) {
            if (u.getEmail() != null && u.getEmail().equals(email) && u.getMotDePasse() != null
                    && u.getMotDePasse().equals(motDePasse)) {
                session.setAttribute("user", u);
                if (u.isFirstLogin()) {
                    return "redirect:/onboarding";
                }
                return "redirect:/";
            }
        }
        model.addAttribute("error", "Email ou mot de passe incorrect");
        return "login";
    }

    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/";
    }

    @GetMapping("/register")
    public String register() {
        return "register";
    }

    @PostMapping("/register")
    public String processRegister(
            @ModelAttribute Utilisateur utilisateur,
            @RequestParam String confirmPassword,
            Model model) {
        if (!utilisateur.getMotDePasse().equals(confirmPassword)) {
            model.addAttribute("error", "Les mots de passe ne correspondent pas");
            return "register";
        }
        try {
            utilisateur.setRole("USER");
            utilisateur.setDaeInscription(new java.sql.Date(System.currentTimeMillis()));
            utilisateurService.inscrire(utilisateur);
            return "redirect:/login?success";
        } catch (Exception e) {
            model.addAttribute("error", "Erreur: " + e.getMessage());
            return "register";
        }
    }
}
