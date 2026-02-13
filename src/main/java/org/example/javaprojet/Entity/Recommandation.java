package org.example.javaprojet.Entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

import java.util.Date;

@Document
@AllArgsConstructor
@NoArgsConstructor
@Data
public class Recommandation {
    @Id
    private String id;
    private Float score;
    private Date dateCreation;
    private String utilisateurId;
    private String contenuId;
    private String modeleId; // Link to ModeleRecommandation
}
