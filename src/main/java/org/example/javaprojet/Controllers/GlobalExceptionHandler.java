package org.example.javaprojet.Controllers;

import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;

@ControllerAdvice
public class GlobalExceptionHandler {

    @ExceptionHandler(Exception.class)
    public String handleException(Exception ex, Model model) {
        model.addAttribute("errorTitle", ex.getClass().getSimpleName());
        model.addAttribute("errorMessage", ex.getMessage());

        // Print stack trace to console
        ex.printStackTrace();

        return "error-debug";
    }
}
