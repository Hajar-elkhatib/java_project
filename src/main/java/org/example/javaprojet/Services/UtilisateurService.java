package org.example.javaprojet.Services;

import lombok.RequiredArgsConstructor;
import org.example.javaprojet.Entity.Utilisateur;
import org.example.javaprojet.Repository.UtilisateurRepository;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor

public class UtilisateurService {

    private final UtilisateurRepository UtilisateurRepository;

    // 🔹 S'inscrire
    public Utilisateur inscrire(Utilisateur utilisateur) {
        // utilisateur.setdateInscription(new Date());
        utilisateur.setDaeInscription(utilisateur.getDaeInscription());
        // utilisateur.setStatut("ACTIF");
        utilisateur.setStatu("ACTIF");
        // return utilisateurRepository.save(utilisateur);
        return UtilisateurRepository.save(utilisateur);
    }

    // 🔹 Consulter statistiques utilisateur
    public Utilisateur consulterStatistiqueUtilisateur(String idUtilisateur) {
        return UtilisateurRepository.findById(idUtilisateur)
                .orElseThrow(() -> new RuntimeException("Utilisateur introuvable"));
    }

    // 🔹 Changer statut
    public Utilisateur changerStatut(String idUtilisateur, String nouveauStatut) {
        Utilisateur utilisateur = UtilisateurRepository.findById(idUtilisateur)
                .orElseThrow(() -> new RuntimeException("Utilisateur introuvable"));

        // utilisateur.setStatut(nouveauStatut);
        utilisateur.setStatu(nouveauStatut);
        return UtilisateurRepository.save(utilisateur);
    }

    // 🔹 CRUD standards
    public List<Utilisateur> getAllUtilisateurs() {
        // return UtilisateurRepository.findAll();
        return UtilisateurRepository.findAll();
    }

    public Utilisateur getUtilisateurById(String id) {
        return UtilisateurRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Utilisateur introuvable"));
    }

    public Utilisateur updateUtilisateur(String id, Utilisateur updated) {
        Utilisateur u = getUtilisateurById(id);
        u.setNom(updated.getNom());
        u.setPrenom(updated.getPrenom());
        u.setEmail(updated.getEmail());
        if (updated.getMotDePasse() != null && !updated.getMotDePasse().isEmpty()) {
            u.setMotDePasse(updated.getMotDePasse());
        }
        u.setNiveauBadge(updated.getNiveauBadge());
        u.setProfilPublic(updated.isProfilPublic());
        // u.setStatut(updated.getStatut());
        u.setStatu(updated.getStatu());
        return UtilisateurRepository.save(u);
    }

    public void deleteUtilisateur(String id) {
        UtilisateurRepository.deleteById(id);
    }
}