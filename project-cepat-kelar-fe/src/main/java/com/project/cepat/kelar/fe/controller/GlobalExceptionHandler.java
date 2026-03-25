package com.project.cepat.kelar.fe.controller;

import jakarta.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.multipart.MultipartException;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@ControllerAdvice(annotations = Controller.class)
public class GlobalExceptionHandler {

    private static final Logger logger = LoggerFactory.getLogger(GlobalExceptionHandler.class);

    @ExceptionHandler(MultipartException.class)
    public String handleMultipartException(MultipartException ex, HttpServletRequest request,
            RedirectAttributes redirectAttributes) {
        logger.error("Multipart upload failed at {}: {}", request.getRequestURI(), ex.getMessage(), ex);

        redirectAttributes.addFlashAttribute("errorMessage",
                "Upload gambar gagal. Pastikan file valid dan ukuran maksimal 25MB.");

        String uri = request.getRequestURI();
        if (uri != null && uri.startsWith("/admin/events")) {
            return "redirect:/admin/events/new";
        }
        if (uri != null && uri.startsWith("/admin/collections")) {
            return "redirect:/admin/collections/new";
        }
        if (uri != null && uri.startsWith("/admin/audio")) {
            return "redirect:/admin/audio/new";
        }
        if (uri != null && uri.startsWith("/admin/voting")) {
            return "redirect:/admin/voting/new";
        }
        return "redirect:/";
    }
}
