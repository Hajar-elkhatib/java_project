package org.example.javaprojet;

import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Bean;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.data.mongodb.core.mapping.MongoMappingContext;

@SpringBootApplication
public class JavaProjetApplication {

    public static void main(String[] args) {
        SpringApplication.run(JavaProjetApplication.class, args);
    }
    @Bean
    CommandLineRunner createAllCollections(MongoTemplate mongoTemplate, MongoMappingContext mappingContext) {
        return args -> {
            // 1. Get every entity class that Spring knows about (all your @Document classes)
            mappingContext.getPersistentEntities().forEach(entity -> {
                Class<?> entityType = entity.getType();

                // 2. Check if the collection exists, if not -> create it
                if (!mongoTemplate.collectionExists(entityType)) {
                    mongoTemplate.createCollection(entityType);
                    System.out.println("✅ Auto-created collection for: " + entityType.getSimpleName());
                }
            });
        };
    }
}
