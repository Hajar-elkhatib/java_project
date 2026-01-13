package org.example.javaprojet.Entity;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.data.mongodb.core.mapping.Document;

import java.sql.Date;


@Document
@AllArgsConstructor
@NoArgsConstructor
@Data
public class Utilisateur {
    @Id
    private String utilisateurId;
    private Date daeInscription;
    private  int niveauBadge;
    private String statu;
    private boolean profilPublic;
}
