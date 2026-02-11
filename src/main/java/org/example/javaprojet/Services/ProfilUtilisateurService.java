package org.example.javaprojet.Services;

import lombok.RequiredArgsConstructor;
import org.example.javaprojet.Entity.ProfileUtilisateur;
import org.example.javaprojet.Repository.ProfilUtilisateurRepository;
import org.springframework.stereotype.Service;


import java.util.Date;
import java.util.List;

@Service
@RequiredArgsConstructor
public class ProfilUtilisateurService {
    private final ProfilUtilisateurRepository profilRepository;

    // ➕ Créer un profil
    public ProfileUtilisateur creerProfil(ProfileUtilisateur profil) {
        profil.setDateMiseAjour(new Date());
        return profilRepository.save(profil);
    }

    // 📋 Tous les profils
    public List<ProfileUtilisateur> getAllProfils() {
        return profilRepository.findAll();
    }

    // 🔍 Profil par ID
    public ProfileUtilisateur getProfilById(String id) {
        return profilRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Profil non trouvé"));
    }

    // ✏️ Mettre à jour un profil
    public ProfileUtilisateur updateProfil(String id, ProfileUtilisateur profil) {
        ProfileUtilisateur p = getProfilById(id);

        p.setLanguesPref(profil.getLanguesPref());
        p.setPaysPref(profil.getPaysPref());
        p.setDateMiseAjour(new Date());

        return profilRepository.save(p);
    }

    // ❌ Supprimer un profil
    public void deleteProfil(String id) {
        profilRepository.deleteById(id);
    }
}
