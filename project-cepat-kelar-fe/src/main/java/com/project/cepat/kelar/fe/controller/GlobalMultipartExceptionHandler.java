package com.project.cepat.kelar.fe.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.multipart.MaxUploadSizeExceededException;
import org.springframework.web.multipart.MultipartException;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import jakarta.servlet.http.HttpServletRequest;

@ControllerAdvice(annotations = Controller.class)
public class GlobalMultipartExceptionHandler {

    @ExceptionHandler(MaxUploadSizeExceededException.class)
    public String handleMaxUploadSize(MaxUploadSizeExceededException ex,
            HttpServletRequest request,
            RedirectAttributes redirectAttributes) {
        if (isCollectionSaveRequest(request)) {
            redirectAttributes.addFlashAttribute("errorMessage",
                    "Ukuran file terlalu besar. Maksimal 10MB untuk sampul buku.");
            return "redirect:" + resolveBackUrl(request);
        }
        throw ex;
    }

    @ExceptionHandler(MultipartException.class)
    public String handleMultipartException(MultipartException ex,
            HttpServletRequest request,
            RedirectAttributes redirectAttributes) {
        if (isCollectionSaveRequest(request)) {
            redirectAttributes.addFlashAttribute("errorMessage",
                    "Gagal memproses unggahan file. Coba gambar lain atau kecilkan ukurannya.");
            return "redirect:" + resolveBackUrl(request);
        }
        throw ex;
    }

    private boolean isCollectionSaveRequest(HttpServletRequest request) {
        if (request == null) {
            return false;
        }
        String uri = request.getRequestURI();
        return uri != null && uri.startsWith("/admin/collections/save");
    }

    private String resolveBackUrl(HttpServletRequest request) {
        if (request == null) {
            return "/admin/collections/new";
        }

        String referer = request.getHeader("Referer");
        if (referer == null || referer.isBlank()) {
            return "/admin/collections/new";
        }

        int pathStart = referer.indexOf("/admin/");
        if (pathStart == -1) {
            return "/admin/collections/new";
        }

        String pathOnly = referer.substring(pathStart);
        int queryStart = pathOnly.indexOf('?');
        if (queryStart != -1) {
            pathOnly = pathOnly.substring(0, queryStart);
        }

        return pathOnly;
    }
}
