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
public class Participation {
    @Id
    private String id;
    private String roleEquipe;
    private String nomPersonnage;
    private int importance;
    private Date dateAjout;
    private String contenuId;
    private String personneId;
}
