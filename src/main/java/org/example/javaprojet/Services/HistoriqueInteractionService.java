package org.example.javaprojet.Services;

import lombok.RequiredArgsConstructor;
import org.example.javaprojet.Entity.HistoriqueInteraction;
import org.example.javaprojet.Repository.HistoriqueInteractionRepository;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;

@Service
@RequiredArgsConstructor
public class HistoriqueInteractionService {
    private final HistoriqueInteractionRepository repository;

    // ➕ Ajouter interaction avec déduplication (1 VUE par jour par contenu)
    public HistoriqueInteraction ajouterInteraction(HistoriqueInteraction interaction) {
        if ("VUE".equalsIgnoreCase(interaction.getTypeInteraction())) {
            java.util.Calendar cal = java.util.Calendar.getInstance();
            cal.set(java.util.Calendar.HOUR_OF_DAY, 0);
            cal.set(java.util.Calendar.MINUTE, 0);
            cal.set(java.util.Calendar.SECOND, 0);
            cal.set(java.util.Calendar.MILLISECOND, 0);
            java.util.Date todayStart = cal.getTime();

            boolean exists = repository.existsByUtilisateurIdAndContenuIdAndTypeInteractionAndDateHeureGreaterThan(
                    interaction.getUtilisateurId(), interaction.getContenuId(), "VUE", todayStart);

            if (exists) {
                return null; // Déjà vu aujourd'hui, on n'enregistre pas de doublon
            }
        }

        interaction.setDateHeure(new Date());
        return repository.save(interaction);
    }

    // 📋 Toutes les interactions
    public List<HistoriqueInteraction> getAllInteractions() {
        return repository.findAll();
    }

    // 🔍 Interaction par ID
    public HistoriqueInteraction getInteractionById(String id) {
        return repository.findById(id)
                .orElseThrow(() -> new RuntimeException("Interaction non trouvée"));
    }

    // 🔍 Par type
    public List<HistoriqueInteraction> getByType(String type) {
        return repository.findByTypeInteraction(type);
    }

    public List<HistoriqueInteraction> getByUtilisateur(String utilisateurId) {
        return repository.findByUtilisateurId(utilisateurId);
    }

    public List<HistoriqueInteraction> getByContenu(String contenuId) {
        return repository.findByContenuId(contenuId);
    }

    // ❌ Supprimer interaction
    public void supprimerInteraction(String id) {
        repository.deleteById(id);
    }

    public long countByUtilisateur(String utilisateurId, String type) {
        return repository.countByUtilisateurIdAndTypeInteraction(utilisateurId, type);
    }
}
