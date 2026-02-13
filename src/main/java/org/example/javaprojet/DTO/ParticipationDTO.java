package org.example.javaprojet.DTO;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class ParticipationDTO {
    private String nom;
    private String role; // Role in the movie (e.g. Actor, Director)
    private String personnage; // Character name
}
