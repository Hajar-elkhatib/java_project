package org.example.javaprojet.Entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;
import org.springframework.data.mongodb.core.mapping.Document;

import java.util.Date;
import java.util.ArrayList;
import java.util.List;

@Document(collection = "utilisateur")
@AllArgsConstructor
@NoArgsConstructor
@Data
@EqualsAndHashCode(callSuper = true)
public class Utilisateur extends Personne {
    private String prenom;
    private Date daeInscription;
    private int niveauBadge;
    private String statu;
    private boolean profilPublic;
    private boolean firstLogin = true;
    private List<String> preferredGenreIds = new ArrayList<>();
    private List<String> likedContentIds = new ArrayList<>();
    private List<String> seenContentIds = new ArrayList<>();

    // Getter for utilisateurId to maintain compatibility if needed,
    // though 'id' from Personne should be used.
    public String getUtilisateurId() {
        return getId();
    }

    public void setUtilisateurId(String id) {
        setId(id);
    }
}
