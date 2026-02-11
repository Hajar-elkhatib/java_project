package org.example.javaprojet.Controllers;

import lombok.RequiredArgsConstructor;
import org.example.javaprojet.Entity.Commentaire;
import org.example.javaprojet.Services.CommentaireService;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/commentaires")
@RequiredArgsConstructor
public class CommentaireController {

    private final CommentaireService commentaireService;

    //  Ajouter
    @PostMapping
    public Commentaire ajouter(@RequestBody Commentaire commentaire) {
        return commentaireService.ajouter(commentaire);
    }

    //  Tous
    @GetMapping
    public List<Commentaire> getAll() {
        return commentaireService.getAll();
    }

    // recherche Par ID
    @GetMapping("/{id}")
    public Commentaire getById(@PathVariable String id) {
        return commentaireService.getById(id);
    }

    // ✏Modifier texte
    @PutMapping("/{id}")
    public Commentaire modifierTexte(
            @PathVariable String id,
            @RequestBody Commentaire commentaire) {
        return commentaireService.modifierTexte(id, commentaire.getTexte());
    }

    //  Bloquer
    @PutMapping("/{id}/bloquer")
    public Commentaire bloquer(@PathVariable String id) {
        return commentaireService.bloquer(id);
    }

    //  Débloquer
    @PutMapping("/{id}/debloquer")
    public Commentaire debloquer(@PathVariable String id) {
        return commentaireService.debloquer(id);
    }

    //  Supprimer
    @DeleteMapping("/{id}")
    public void supprimer(@PathVariable String id) {
        commentaireService.supprimer(id);
    }
}
