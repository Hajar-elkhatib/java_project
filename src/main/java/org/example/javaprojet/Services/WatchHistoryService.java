package org.example.javaprojet.Services;

import lombok.RequiredArgsConstructor;
import org.example.javaprojet.Entity.Contenu;
import org.example.javaprojet.Entity.WatchHistory;
import org.example.javaprojet.Repository.WatchHistoryRepository;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;
import java.util.Optional;

@Service
@RequiredArgsConstructor
public class WatchHistoryService {

    private final WatchHistoryRepository watchHistoryRepository;

    public void addToHistory(String userId, Contenu content) {
        // Check if already exists to avoid duplicates
        Optional<WatchHistory> existing = watchHistoryRepository.findByUserIdAndContentId(userId, content.getId());

        WatchHistory history;
        if (existing.isPresent()) {
            history = existing.get();
        } else {
            history = WatchHistory.builder()
                    .userId(userId)
                    .contentId(content.getId())
                    .title(content.getTitre())
                    .posterUrl(content.getPosterUrl())
                    .build();
        }

        // Update timestamp anyway
        history.setWatchedAt(new Date());
        watchHistoryRepository.save(history);
    }

    public List<WatchHistory> getHistoryByUserId(String userId) {
        return watchHistoryRepository.findByUserIdOrderByWatchedAtDesc(userId);
    }

    public void clearHistory(String userId) {
        watchHistoryRepository.deleteByUserId(userId);
    }
}
