package org.example.javaprojet.Controllers;

import lombok.RequiredArgsConstructor;
import org.example.javaprojet.Entity.Admin;
import org.example.javaprojet.Services.AdminService;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/admins")
@RequiredArgsConstructor
public class AdminController {

    private final AdminService adminService;

    // Ajouter admin
    @PostMapping
    public Admin ajouter(@RequestBody Admin admin) {
        return adminService.ajouterAdmin(admin);
    }

    // Tous les admins
    @GetMapping
    public List<Admin> getAll() {
        return adminService.getAllAdmins();
    }

    // rechirche Admin par ID
    @GetMapping("/{id}")
    public Admin getById(@PathVariable String id) {
        return adminService.getAdminById(id);
    }

    //  Modifier niveau d’accès
    @PutMapping("/{id}/niveau")
    public Admin modifierNiveau(
            @PathVariable String id,
            @RequestParam int niveau) {
        return adminService.modifierNiveauAcces(id, niveau);
    }

    // Supprimer admin
    @DeleteMapping("/{id}")
    public void supprimer(@PathVariable String id) {
        adminService.supprimerAdmin(id);
    }
}
