package org.example.javaprojet.Config;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

@Component
public class AuthInterceptor implements HandlerInterceptor {

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
            throws Exception {
        HttpSession session = request.getSession();
        Object userObj = session.getAttribute("user");

        String path = request.getRequestURI();

        // Sécurité Admin
        if (path.startsWith("/admin")) {
            if (userObj == null) {
                response.sendRedirect(request.getContextPath() + "/login?error=AccessDenied");
                return false;
            }

            // On vérifie le rôle de manière dynamique pour éviter les erreurs de Cast si
            // besoin
            try {
                // Utilisation de la réflexion ou simple vérification de propriété si possible
                // Ici on fait le cast proprement
                org.example.javaprojet.Entity.Utilisateur user = (org.example.javaprojet.Entity.Utilisateur) userObj;
                if (!"ADMIN".equals(user.getRole())) {
                    response.sendRedirect(request.getContextPath() + "/login?error=AccessDenied");
                    return false;
                }
            } catch (Exception e) {
                session.removeAttribute("user");
                response.sendRedirect(request.getContextPath() + "/login?error=SessionError");
                return false;
            }
        }

        // Sécurité Actions Utilisateurs (Commentaires/Notes)
        if (path.contains("/comment") || path.contains("/rate")) {
            if (userObj == null) {
                response.sendRedirect(request.getContextPath() + "/login");
                return false;
            }
        }

        return true;
    }
}
