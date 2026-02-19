package org.example.javaprojet.Controllers;

import lombok.RequiredArgsConstructor;
import org.example.javaprojet.Entity.Utilisateur;
import org.example.javaprojet.Services.WatchHistoryService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/history")
@RequiredArgsConstructor
public class WatchHistoryController {

    private final WatchHistoryService watchHistoryService;

    @GetMapping
    public String viewHistory(Model model, HttpSession session) {
        Utilisateur user = (Utilisateur) session.getAttribute("user");
        if (user == null) {
            return "redirect:/login";
        }

        model.addAttribute("history", watchHistoryService.getHistoryByUserId(user.getId()));
        return "history";
    }

    @PostMapping("/clear")
    public String clearHistory(HttpSession session) {
        Utilisateur user = (Utilisateur) session.getAttribute("user");
        if (user != null) {
            watchHistoryService.clearHistory(user.getId());
        }
        return "redirect:/history";
    }
}
