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

    // ➕ Ajouter genre
    public Genre ajouterGenre(Genre genre) {
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
        genreRepository.deleteById(id);
    }
}
