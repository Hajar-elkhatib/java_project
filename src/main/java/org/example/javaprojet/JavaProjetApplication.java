package org.example.javaprojet;

import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Bean;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.data.mongodb.core.mapping.MongoMappingContext;

import org.springframework.boot.web.servlet.support.SpringBootServletInitializer;
import org.springframework.boot.builder.SpringApplicationBuilder;

@SpringBootApplication
public class JavaProjetApplication extends SpringBootServletInitializer {

    public static void main(String[] args) {
        SpringApplication.run(JavaProjetApplication.class, args);
    }

    @Override
    protected SpringApplicationBuilder configure(SpringApplicationBuilder application) {
        return application.sources(JavaProjetApplication.class);
    }

    @Bean
    CommandLineRunner createAllCollections(MongoTemplate mongoTemplate, MongoMappingContext mappingContext) {
        return args -> {
            System.out.println("DEBUG: Spring se connecte à la base : " + mongoTemplate.getDb().getName());
            // 1. Get every entity class that Spring knows about (all your @Document
            // classes)
            mappingContext.getPersistentEntities().forEach(entity -> {
                Class<?> entityType = entity.getType();

                if (entityType.getSimpleName().equals("Contenu")) {
                    long count = mongoTemplate.count(new org.springframework.data.mongodb.core.query.Query(),
                            entityType);
                    System.out.println("DEBUG: [STARTUP] Nombre de documents dans 'contenu' : " + count);
                }

                // 2. Check if the collection exists, if not -> create it
                if (!mongoTemplate.collectionExists(entityType)) {
                    mongoTemplate.createCollection(entityType);
                    System.out.println("✅ Auto-created collection for: " + entityType.getSimpleName());
                }
            });
        };
    }
}
