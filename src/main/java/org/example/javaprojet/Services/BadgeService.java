package org.example.javaprojet.Services;

import lombok.RequiredArgsConstructor;
import org.example.javaprojet.Entity.Badge;
import org.example.javaprojet.Repository.BadgeRepository;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class BadgeService {

    private final BadgeRepository badgeRepository;

    // ➕ Ajouter un badge
    public Badge ajouterBadge(Badge badge) {
        return badgeRepository.save(badge);
    }

    // 📋 Tous les badges
    public List<Badge> getAllBadges() {
        return badgeRepository.findAll();
    }

    // 🔍 Badge par ID
    public Badge getBadgeById(String id) {
        return badgeRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Badge non trouvé"));
    }

    // 🔍 Badge par nom
    public Badge getBadgeByNom(String nom) {
        return badgeRepository.findByNom(nom)
                .orElseThrow(() -> new RuntimeException("Badge non trouvé"));
    }

    // ✏️ Modifier un badge
    public Badge modifierBadge(String id, Badge badge) {
        Badge b = getBadgeById(id);
        b.setNom(badge.getNom());
        b.setDescription(badge.getDescription());
        b.setConditionBadge(badge.getConditionBadge());
        return badgeRepository.save(b);
    }

    // ❌ Supprimer un badge
    public void supprimerBadge(String id) {
        badgeRepository.deleteById(id);
    }
}
