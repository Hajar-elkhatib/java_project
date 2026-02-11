package org.example.javaprojet.Services;

import lombok.RequiredArgsConstructor;
import org.example.javaprojet.Entity.Commentaire;
import org.example.javaprojet.Repository.CommentaireRepository;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;

@Service
@RequiredArgsConstructor
public class CommentaireService {


    private final CommentaireRepository commentaireRepository;

    // ➕ Ajouter commentaire
    public Commentaire ajouter(Commentaire commentaire) {
        commentaire.setDateCreation(new Date());
        commentaire.setStatu("ACTIF");
        return commentaireRepository.save(commentaire);
    }

    // 📋 Tous les commentaires
    public List<Commentaire> getAll() {
        return commentaireRepository.findAll();
    }

    // 🔍 Commentaire par ID
    public Commentaire getById(String id) {
        return commentaireRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Commentaire non trouvé"));
    }

    // ✏️ Modifier texte
    public Commentaire modifierTexte(String id, String texte) {
        Commentaire c = getById(id);
        c.setTexte(texte);
        return commentaireRepository.save(c);
    }

    // 🚫 Bloquer
    public Commentaire bloquer(String id) {
        Commentaire c = getById(id);
        c.setStatu("BLOQUE");
        return commentaireRepository.save(c);
    }

    // ✅ Débloquer
    public Commentaire debloquer(String id) {
        Commentaire c = getById(id);
        c.setStatu("ACTIF");
        return commentaireRepository.save(c);
    }

    // ❌ Supprimer
    public void supprimer(String id) {
        commentaireRepository.deleteById(id);
    }
}
