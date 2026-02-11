package org.example.javaprojet.Repository;


import org.example.javaprojet.Entity.Utilisateur;
import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.stereotype.Repository;


@Repository
public interface UtilisateurRepository extends MongoRepository<Utilisateur,String> {


 }



