package org.example.javaprojet.Services;

import lombok.RequiredArgsConstructor;
import org.example.javaprojet.Entity.Genre;
import org.example.javaprojet.Repository.GenreRepository;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class GenreService {
    private final GenreRepository genreRepository;
    private final org.example.javaprojet.Repository.ContenuRepository contenuRepository;

    // ➕ Ajouter genre
    public Genre ajouterGenre(Genre genre) {
        if (genreRepository.findByNomIgnoreCase(genre.getNom()).isPresent()) {
            throw new RuntimeException("Un genre avec ce nom existe déjà.");
        }
        return genreRepository.save(genre);
    }

    // 📋 Tous les genres
    public List<Genre> getAllGenres() {
        return genreRepository.findAll();
    }

    // 🔍 Genre par ID
    public Genre getGenreById(String id) {
        return genreRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Genre non trouvé"));
    }

    // 🔍 Genre par nom
    public Genre getGenreByNom(String nom) {
        return genreRepository.findByNom(nom)
                .orElseThrow(() -> new RuntimeException("Genre non trouvé"));
    }

    // ✏️ Modifier genre
    public Genre modifierGenre(String id, Genre genre) {
        Genre g = getGenreById(id);
        g.setNom(genre.getNom());
        return genreRepository.save(g);
    }

    // ❌ Supprimer genre
    public void supprimerGenre(String id) {
        // Remove this genre from all contents that have it
        List<org.example.javaprojet.Entity.Contenu> contents = contenuRepository.findByGenreIdsContains(id);
        for (org.example.javaprojet.Entity.Contenu content : contents) {
            content.getGenreIds().remove(id);
            contenuRepository.save(content);
        }
        // Circular dependency risk if I inject ContenuService. Better to do it in
        // Controller or use Repository directly if possible, or leave it.
        // Let's stick to simple delete for now, or just handle it in the Controller if
        // strictness is needed.
        // Actually, MongoDB documents are independent. If I delete a Genre document,
        // the Contenu documents still hold the String ID.
        // It's better to clean it up.
        genreRepository.deleteById(id);
    }
}
