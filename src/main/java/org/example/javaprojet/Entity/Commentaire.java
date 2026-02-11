package org.example.javaprojet.Entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

import java.util.Date;

@Document(collection = "commentaire")
@AllArgsConstructor
@NoArgsConstructor
@Data
public class Commentaire {
    @Id
    private String id;
    private String texte;
    private Date dateCreation;
    private String statu; // Ex: "ACTIF", "BLOQUE"

    private String utilisateurId;
    private String utilisateurNom; // Pour afficher le nom sans refaire une requête
    private String contenuId;
    private boolean isBlocked = false;
}
