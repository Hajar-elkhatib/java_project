package org.example.javaprojet.Entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.data.annotation.Id;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Personne {
    @Id
    private String id;
    private String nom;
    private String email;
    private String motDePasse;
    private String pays;
    private String role;
}
