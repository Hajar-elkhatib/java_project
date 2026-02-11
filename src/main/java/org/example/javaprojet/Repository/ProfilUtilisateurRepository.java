package org.example.javaprojet.Repository;


import org.example.javaprojet.Entity.ProfileUtilisateur;
import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface ProfilUtilisateurRepository extends MongoRepository<ProfileUtilisateur, String> {

}
