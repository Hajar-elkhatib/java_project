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
public class ModeleRecommandation {
    @Id
    private String id;
    private String nom;
    private String version;
    private String typeModele;
    private Date dateDernierEntrainement;
}
