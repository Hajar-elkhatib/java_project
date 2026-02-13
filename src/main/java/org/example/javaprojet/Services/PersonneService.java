package org.example.javaprojet.Services;

import lombok.RequiredArgsConstructor;
import org.example.javaprojet.Entity.Personne;
import org.example.javaprojet.Repository.PersonneRepository;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class PersonneService {

    private final PersonneRepository personneRepository;

    // 🔹 CREATE
    public Personne save(Personne personne) {
        return personneRepository.save(personne);
    }

    // 🔹 READ ALL
    public List<Personne> getAllPersonnes() {
        return personneRepository.findAll();
    }

    // 🔹 READ BY ID
    public Personne getPersonneById(String id) {
        return personneRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Personne introuvable"));
    }

    // 🔹 UPDATE
    public Personne updatePersonne(String id, Personne updated) {
        Personne p = getPersonneById(id);
        p.setNom(updated.getNom());
        p.setEmail(updated.getEmail());
        p.setMotDePasse(updated.getMotDePasse());

        p.setPays(updated.getPays());
        p.setRole(updated.getRole());
        return personneRepository.save(p);
    }

    // 🔹 DELETE
    public void deletePersonne(String id) {
        personneRepository.deleteById(id);
    }
}
