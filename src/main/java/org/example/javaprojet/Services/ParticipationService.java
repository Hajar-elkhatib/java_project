package org.example.javaprojet.Services;

import lombok.RequiredArgsConstructor;
import org.example.javaprojet.DTO.ParticipationDTO;
import org.example.javaprojet.Entity.Participation;
import org.example.javaprojet.Entity.Personne;
import org.example.javaprojet.Repository.ParticipationRepository;
import org.example.javaprojet.Repository.PersonneRepository;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class ParticipationService {

    private final ParticipationRepository participationRepository;
    private final PersonneRepository personneRepository;

    public List<Participation> getParticipationsByContenu(String contenuId) {
        return participationRepository.findByContenuId(contenuId);
    }

    public List<ParticipationDTO> getCastByContenu(String contenuId) {
        List<Participation> participations = participationRepository.findByContenuId(contenuId);
        return participations.stream()
                .map(p -> {
                    Personne person = personneRepository.findById(p.getPersonneId()).orElse(null);
                    if (person == null)
                        return null;
                    return new ParticipationDTO(
                            person.getNom(),
                            p.getRoleEquipe(),
                            p.getNomPersonnage());
                })
                .filter(dto -> dto != null)
                .collect(Collectors.toList());
    }
}
