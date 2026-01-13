package org.example.javaprojet.Controllers;

import lombok.RequiredArgsConstructor;
import org.example.javaprojet.Entity.Genre;
import org.example.javaprojet.Services.GenreService;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/genres")
@RequiredArgsConstructor
public class GenreController {

    private final GenreService genreService;

    //  Ajouter
    @PostMapping
    public Genre ajouter(@RequestBody Genre genre) {
        return genreService.ajouterGenre(genre);
    }

    //  Tous
    @GetMapping
    public List<Genre> getAll() {
        return genreService.getAllGenres();
    }

    // recherche Par ID
    @GetMapping("/{id}")
    public Genre getById(@PathVariable String id) {
        return genreService.getGenreById(id);
    }

    // recherche Par nom
    @GetMapping("/nom/{nom}")
    public Genre getByNom(@PathVariable String nom) {
        return genreService.getGenreByNom(nom);
    }

    //  Modifier
    @PutMapping("/{id}")
    public Genre modifier(
            @PathVariable String id,
            @RequestBody Genre genre) {
        return genreService.modifierGenre(id, genre);
    }

    //  Supprimer
    @DeleteMapping("/{id}")
    public void supprimer(@PathVariable String id) {
        genreService.supprimerGenre(id);
    }
}
