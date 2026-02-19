package org.example.javaprojet.Controllers;

import lombok.RequiredArgsConstructor;
import org.example.javaprojet.Entity.Recommandation;
import org.example.javaprojet.Services.RecommandationService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/recommendations")
@RequiredArgsConstructor
@CrossOrigin(origins = "*")
public class RecommandationController {

    private final RecommandationService recommandationService;

    /**
     * Called right after first-login onboarding (genre + film selection).
     * The frontend calls this once the user finishes the selection wizard.
     *
     * POST /api/recommendations/onboarding/{userId}
     */
    @PostMapping("/onboarding/{userId}")
    public ResponseEntity<List<Recommandation>> onboarding(@PathVariable String userId) {
        List<Recommandation> recs = recommandationService.generateOnboardingRecommendations(userId);
        return ResponseEntity.ok(recs);
    }

    /**
     * Get cached recommendations for a user (fast, reads from MongoDB).
     * The recommendation page calls this on load.
     *
     * GET /api/recommendations/{userId}
     */
    @GetMapping("/{userId}")
    public ResponseEntity<List<Recommandation>> getRecommendations(@PathVariable String userId) {
        List<Recommandation> recs = recommandationService.getRecommendationsForUser(userId);
        return ResponseEntity.ok(recs);
    }

    /**
     * Refresh recommendations (re-calls AI model with latest user data).
     * Call this after user rates/comments on new content.
     *
     * POST /api/recommendations/refresh/{userId}
     */
    @PostMapping("/refresh/{userId}")
    public ResponseEntity<List<Recommandation>> refresh(@PathVariable String userId) {
        List<Recommandation> recs = recommandationService.refreshRecommendations(userId);
        return ResponseEntity.ok(recs);
    }

    /**
     * Save user's onboarding preferences (genres + films selected in the wizard).
     * Called by the frontend BEFORE calling /onboarding.
     *
     * POST /api/recommendations/preferences/{userId}
     * Body: { "preferredGenreIds": [...], "likedContentIds": [...] }
     */
    @PostMapping("/preferences/{userId}")
    public ResponseEntity<Map<String, String>> savePreferences(
            @PathVariable String userId,
            @RequestBody Map<String, List<String>> body) {

        List<String> genres = body.get("preferredGenreIds");
        List<String> films  = body.get("likedContentIds");

        // Update user in MongoDB
        var userRepo = recommandationService;  // Use the service to avoid direct repo access here
        // This is handled inside RecommandationService — see savePreferences below
        recommandationService.saveUserPreferences(userId, genres, films);

        return ResponseEntity.ok(Map.of("status", "preferences saved"));
    }
}