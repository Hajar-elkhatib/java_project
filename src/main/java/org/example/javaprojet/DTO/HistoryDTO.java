package org.example.javaprojet.DTO;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.example.javaprojet.Entity.Contenu;
import java.util.Date;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class HistoryDTO {
    private String id;
    private String typeInteraction;
    private Date date;
    private Contenu movie;
}
