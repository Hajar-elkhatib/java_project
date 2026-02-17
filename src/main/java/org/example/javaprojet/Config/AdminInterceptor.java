package org.example.javaprojet.Config;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.springframework.lang.NonNull;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

@Component
public class AdminInterceptor implements HandlerInterceptor {

    @Override
    public boolean preHandle(@NonNull HttpServletRequest request, @NonNull HttpServletResponse response,
            @NonNull Object handler)
            throws Exception {
        String uri = request.getRequestURI();

        // Allow access to login page and login POST
        if (uri.endsWith("/admin/login") || uri.endsWith("/admin/logout")) {
            return true;
        }

        // Check if user is admin
        HttpSession session = request.getSession(false);
        if (session != null && "ADMIN".equals(session.getAttribute("role"))) {
            return true;
        }

        // Redirect to login if not authenticated
        response.sendRedirect(request.getContextPath() + "/login");
        return false;
    }
}
