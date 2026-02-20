package org.example.javaprojet.Controllers;

import lombok.RequiredArgsConstructor;
import org.example.javaprojet.Entity.Badge;
import org.example.javaprojet.Services.BadgeService;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.Map;

@RestController
@RequestMapping("/api/users")
@RequiredArgsConstructor
public class UserBadgeApiController {

    private final BadgeService badgeService;

    @GetMapping("/{userId}/badge")
    public Map<String, Object> getUserBadge(@PathVariable String userId) {
        Badge badge = badgeService.updateAndGetBadge(userId);
        double score = badgeService.calculateUserScore(userId);

        Map<String, Object> result = new HashMap<>();
        result.put("badge", badge.getNom());
        result.put("niveau", badge.getNiveau());
        result.put("score", score);
        result.put("limiteNotes", badge.getLimiteNotesParJour());
        result.put("limiteCommentaires", badge.getLimiteCommentairesParJour());
        result.put("description", badge.getDescription());

        return result;
    }
}
