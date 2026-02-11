package org.example.javaprojet.Services;

import lombok.RequiredArgsConstructor;
import org.example.javaprojet.Entity.Admin;
import org.example.javaprojet.Repository.AdminRepository;
import org.springframework.stereotype.Service;

import java.util.List;
@Service
@RequiredArgsConstructor
public class AdminService {
    private final AdminRepository adminRepository;

    // ➕ Ajouter admin
    public Admin ajouterAdmin(Admin admin) {
        return adminRepository.save(admin);
    }

    // 📋 Tous les admins
    public List<Admin> getAllAdmins() {
        return adminRepository.findAll();
    }

    // 🔍 Admin par ID
    public Admin getAdminById(String id) {
        return adminRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Admin non trouvé"));
    }

    // 🔍 Admin par email
    public Admin getAdminByEmail(String email) {
        return adminRepository.findByEmail(email)
                .orElseThrow(() -> new RuntimeException("Admin non trouvé"));
    }

    // ✏️ Modifier niveau d’accès
    public Admin modifierNiveauAcces(String id, int niveau) {
        Admin admin = getAdminById(id);
        admin.setNiveauAcces(niveau);
        return adminRepository.save(admin);
    }

    // ❌ Supprimer admin
    public void supprimerAdmin(String id) {
        adminRepository.deleteById(id);
    }
}
