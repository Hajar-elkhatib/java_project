package org.example.javaprojet.Entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

@Document(collection = "admins")

// @Document
@AllArgsConstructor
@NoArgsConstructor
@Data
public class Admin {
    @Id
    private String id;
    private String nom;
    private String email; // <-- doit exister exactement
    private String motDePasse;
    private String pays;
    private String role;
    private int niveauAcces;

}
