package org.example.javaprojet.Entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

import java.util.Date;

@Document(collection = "utilisateur")
@AllArgsConstructor
@NoArgsConstructor
@Data
public class Utilisateur {
    @Id
    private String utilisateurId;
    private String nom;
    private String prenom;
    private String email;
    private String motDePasse;
    private String role; // "USER", "ADMIN"
    private Date daeInscription;
    private int niveauBadge;
    private String statu;
    private boolean profilPublic;
}
