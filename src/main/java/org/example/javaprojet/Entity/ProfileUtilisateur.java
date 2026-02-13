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

public class ProfileUtilisateur {
    @Id
    private String idProfil;
    private String LanguesPref;
    private String paysPref;
    private Date dateMiseAjour;
    private String utilisateurId; // Link to Utilisateur
}
