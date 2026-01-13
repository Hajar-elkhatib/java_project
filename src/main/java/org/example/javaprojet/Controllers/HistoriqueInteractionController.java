package org.example.javaprojet.Controllers;

import lombok.RequiredArgsConstructor;
import org.example.javaprojet.Entity.HistoriqueInteraction;
import org.example.javaprojet.Services.HistoriqueInteractionService;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/interactions")
@RequiredArgsConstructor
public class HistoriqueInteractionController {

    private final HistoriqueInteractionService service;

    // ➕ Ajouter
    @PostMapping
    public HistoriqueInteraction ajouter(@RequestBody HistoriqueInteraction interaction) {
        return service.ajouterInteraction(interaction);
    }

    //  Toutes
    @GetMapping
    public List<HistoriqueInteraction> getAll() {
        return service.getAllInteractions();
    }

    // recherche Par ID
    @GetMapping("/{id}")
    public HistoriqueInteraction getById(@PathVariable String id) {
        return service.getInteractionById(id);
    }

    // recherche Par type
    @GetMapping("/type/{type}")
    public List<HistoriqueInteraction> getByType(@PathVariable String type) {
        return service.getByType(type);
    }

    //  Supprimer
    @DeleteMapping("/{id}")
    public void supprimer(@PathVariable String id) {
        service.supprimerInteraction(id);
    }
}
