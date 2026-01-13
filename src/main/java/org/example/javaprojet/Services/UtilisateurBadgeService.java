package org.example.javaprojet.Services;
import lombok.RequiredArgsConstructor;
import org.example.javaprojet.Entity.Utilisateur_Badge;
import org.example.javaprojet.Repository.UtilisateurBadgeRepository;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;

@Service
@RequiredArgsConstructor
public class UtilisateurBadgeService {

    private final UtilisateurBadgeRepository repository;

    // ➕ Attribuer un badge
    public Utilisateur_Badge attribuerBadge(Utilisateur_Badge ub) {
        ub.setDateAttribution(new Date());
        return repository.save(ub);
    }

    // 📋 Badges d’un utilisateur
    public List<Utilisateur_Badge> getBadgesByUtilisateur(String utilisateurId) {
        return repository.findByUtilisateurId(utilisateurId);
    }

    // 📋 Utilisateurs ayant un badge
    public List<Utilisateur_Badge> getUtilisateursByBadge(String badgeId) {
        return repository.findByBadgeId(badgeId);
    }

    // ❌ Supprimer attribution
    public void supprimerAttribution(String id) {
        repository.deleteById(id);
    }
}
