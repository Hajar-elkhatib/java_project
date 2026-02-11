package org.example.javaprojet.Controllers;


import org.example.javaprojet.Entity.Personne;
import org.example.javaprojet.Services.PersonneService;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/personnes")
public class PersonneController {

    private final PersonneService personneService;

    public PersonneController(PersonneService personneService) {
        this.personneService = personneService;
    }

    // 🔹 CREATE
    @PostMapping
    public Personne create(@RequestBody Personne personne) {
        return personneService.save(personne);
    }

    // 🔹 READ ALL
    @GetMapping
    public List<Personne> getAll() {
        return personneService.getAllPersonnes();
    }

    // 🔹 READ BY ID
    @GetMapping("/{id}")
    public Personne getById(@PathVariable String id) {
        return personneService.getPersonneById(id);
    }

    // 🔹 UPDATE
    @PutMapping("/{id}")
    public Personne update(
            @PathVariable String id,
            @RequestBody Personne personne) {
        return personneService.updatePersonne(id, personne);
    }

    // 🔹 DELETE
    @DeleteMapping("/{id}")
    public void delete(@PathVariable String id) {
        personneService.deletePersonne(id);
    }
}
