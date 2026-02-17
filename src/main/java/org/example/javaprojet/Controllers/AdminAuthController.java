package org.example.javaprojet.Controllers;

import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;

import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/admin")
public class AdminAuthController {

    // Admin credentials are now handled in HomeController

    @GetMapping("/login")
    public String loginPage() {
        return "redirect:/login";
    }

    // POST login handled in HomeController to use single entry point

    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/login";
    }
}
