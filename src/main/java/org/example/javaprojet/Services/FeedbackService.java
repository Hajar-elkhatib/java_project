package org.example.javaprojet.Services;

import lombok.RequiredArgsConstructor;
import org.example.javaprojet.Entity.Commentaire;
import org.example.javaprojet.Entity.Evaluation;
import org.example.javaprojet.Entity.Contenu;
import org.example.javaprojet.Repository.CommentaireRepository;
import org.example.javaprojet.Repository.EvaluationRepository;
import org.example.javaprojet.Repository.ContenuRepository;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;
import java.util.Optional;

@Service
@RequiredArgsConstructor
public class FeedbackService {

    private final CommentaireRepository commentaireRepository;
    private final EvaluationRepository evaluationRepository;
    private final ContenuRepository contenuRepository;

    // --- Commentaires ---

    public List<Commentaire> getCommentsForContent(String contenuId) {
        return commentaireRepository.findByContenuIdAndIsBlockedFalse(contenuId);
    }

    public void addComment(String texte, String userId, String userName, String contenuId) {
        Commentaire comment = new Commentaire();
        comment.setTexte(texte);
        comment.setUtilisateurId(userId);
        comment.setUtilisateurNom(userName);
        comment.setContenuId(contenuId);
        comment.setDateCreation(new Date());
        comment.setStatu("ACTIF");
        commentaireRepository.save(comment);
    }

    public void blockComment(String commentId) {
        commentaireRepository.findById(commentId).ifPresent(c -> {
            c.setBlocked(true);
            c.setStatu("BLOQUE");
            commentaireRepository.save(c);
        });
    }

    // --- Evaluations (Notes) ---

    public void addOrUpdateRating(String userId, String contenuId, int note) {
        Optional<Evaluation> existing = evaluationRepository.findByUtilisateurIdAndContenuId(userId, contenuId);

        Evaluation evaluation;
        if (existing.isPresent()) {
            evaluation = existing.get();
        } else {
            evaluation = new Evaluation();
            evaluation.setUtilisateurId(userId);
            evaluation.setContenuId(contenuId);
        }

        evaluation.setNote(note);
        evaluation.setDateEvaluation(new Date());
        evaluation.setContenuId(contenuId);
        evaluationRepository.save(evaluation);

        // Recalculer la moyenne pour le film
        updateAverageRating(contenuId);
    }

    private void updateAverageRating(String contenuId) {
        List<Evaluation> evals = evaluationRepository.findByContenuId(contenuId);
        if (evals.isEmpty())
            return;

        double sum = 0;
        for (Evaluation e : evals) {
            sum += e.getNote();
        }
        double average = sum / evals.size();

        contenuRepository.findById(contenuId).ifPresent(c -> {
            c.setNoteMoyenne(Math.round(average * 10.0) / 10.0); // Arrondi à 1 décimale
            c.setNbVotes(evals.size());
            contenuRepository.save(c);
        });
    }
}
