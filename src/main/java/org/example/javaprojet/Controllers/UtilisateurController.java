package org.example.javaprojet.Controllers;


import org.example.javaprojet.Entity.Utilisateur;
import org.example.javaprojet.Services.UtilisateurService;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/utilisateurs")
public class UtilisateurController {

    private final UtilisateurService utilisateurService;

    public UtilisateurController(UtilisateurService utilisateurService) {
        this.utilisateurService = utilisateurService;
    }

    // 🔹 CREATE
    @PostMapping
    public Utilisateur create(@RequestBody Utilisateur utilisateur) {
        return utilisateurService.inscrire(utilisateur);
    }

    // 🔹 READ ALL
    @GetMapping
    public List<Utilisateur> getAll() {
        return utilisateurService.getAllUtilisateurs();
    }

    // 🔹 READ BY ID
    @GetMapping("/{id}")
    public Utilisateur getById(@PathVariable String id) {
        return utilisateurService.getUtilisateurById(id);
    }

    // 🔹 UPDATE
    @PutMapping("/{id}")
    public Utilisateur update(
            @PathVariable String id,
            @RequestBody Utilisateur utilisateur) {
        return utilisateurService.updateUtilisateur(id, utilisateur);
    }

    // 🔹 DELETE
    @DeleteMapping("/{id}")
    public void delete(@PathVariable String id) {
        utilisateurService.deleteUtilisateur(id);
    }
}
