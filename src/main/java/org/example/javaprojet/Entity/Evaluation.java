package org.example.javaprojet.Entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

@Document(collection = "evaluation")
@AllArgsConstructor
@NoArgsConstructor
@Data
public class Evaluation {
    @Id
    private String id;
    private int note;
    private java.util.Date dateEvaluation;
    private String utilisateurId;
    private String contenuId;
}
