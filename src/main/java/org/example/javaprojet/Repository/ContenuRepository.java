package org.example.javaprojet.Repository;

import org.example.javaprojet.Entity.Contenu;
import org.springframework.data.mongodb.repository.MongoRepository;
import java.util.List;

public interface ContenuRepository extends MongoRepository<Contenu, String> {
    List<Contenu> findByTitreContainingIgnoreCase(String titre);

    List<Contenu> findByTypeContenu(String typeContenu);

    List<Contenu> findByTypeContenuIgnoreCase(String typeContenu);

    List<Contenu> findTop8ByOrderByNoteMoyenneDesc();

    List<Contenu> findTop10ByOrderByNbVotesDesc();

    List<Contenu> findByGenreIdsContains(String genreId);

    List<Contenu> findByPaysContainingIgnoreCase(String pays);
}
