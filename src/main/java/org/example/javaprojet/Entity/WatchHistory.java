package org.example.javaprojet.Entity;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

import java.util.Date;

@Document(collection = "watch_history")
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class WatchHistory {
    @Id
    private String id;

    private String userId;
    private String contentId;
    private String title;
    private String posterUrl;
    private Date watchedAt;
}
