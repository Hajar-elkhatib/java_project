package org.example.javaprojet.Entity;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.data.mongodb.core.mapping.Document;

import java.util.Date;


@Document
@AllArgsConstructor
@NoArgsConstructor
@Data

public class Utilisateur_Contenu_Favori {
    @Id
    private String id;
    private String utilisateurId; // ID utilisateur
    private String contenuId;     // ID contenu
    private Date dateAjouter;
}
