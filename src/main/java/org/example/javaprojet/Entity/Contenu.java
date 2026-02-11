package org.example.javaprojet.Entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;
import org.springframework.data.mongodb.core.mapping.Field;

import java.util.Date;

@Document(collection = "contenu")
@AllArgsConstructor
@NoArgsConstructor
@Data
public class Contenu {
    @Id
    private String id;

    private String titre;
    private String description;

    @Field("lngue")
    private String langue;

    private String pays;
    private Date dateSortie;
    private int dureeMinutes;
    private double noteMoyenne;

    // Ajout du nombre de votes pour le système IMDb
    private int nbVotes = 0;

    @Field("typeContenu")
    private String typeContenu;

    @Field("posteUrl")
    private String posterUrl;

    private String trailerUrl;

    /**
     * Transforme une URL YouTube standard en URL Embed pour <iframe>
     */
    public String getYouTubeEmbedUrl() {
        if (trailerUrl == null || trailerUrl.isEmpty())
            return null;
        if (trailerUrl.contains("embed/"))
            return trailerUrl;

        String videoId = "";
        if (trailerUrl.contains("v=")) {
            videoId = trailerUrl.substring(trailerUrl.indexOf("v=") + 2);
            int ampersandIndex = videoId.indexOf("&");
            if (ampersandIndex != -1) {
                videoId = videoId.substring(0, ampersandIndex);
            }
        } else if (trailerUrl.contains("youtu.be/")) {
            videoId = trailerUrl.substring(trailerUrl.indexOf("youtu.be/") + 9);
        }

        return "https://www.youtube.com/embed/" + videoId;
    }
}
