package org.example.javaprojet.Repository;

import org.example.javaprojet.Entity.WatchHistory;
import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface WatchHistoryRepository extends MongoRepository<WatchHistory, String> {
    List<WatchHistory> findByUserIdOrderByWatchedAtDesc(String userId);

    Optional<WatchHistory> findByUserIdAndContentId(String userId, String contentId);

    void deleteByUserId(String userId);
}
