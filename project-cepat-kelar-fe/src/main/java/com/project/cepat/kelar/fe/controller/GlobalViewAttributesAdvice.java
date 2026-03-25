package com.project.cepat.kelar.fe.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ModelAttribute;

import com.project.cepat.kelar.service.backoffice.AdminService;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.http.HttpServletRequest;

@ControllerAdvice
public class GlobalViewAttributesAdvice {

    @Autowired(required = false)
    private AdminService adminService;

    @ModelAttribute("adminName")
    public String resolveAdminNameForViews(HttpServletRequest request) {
        if (!isAdminContext(request)) {
            return null;
        }

        try {
            Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
            if (adminService == null || authentication == null) {
                return null;
            }

            return adminService.resolveAdminName(authentication);
        } catch (Exception ignored) {
            return null;
        }
    }

    private boolean isAdminContext(HttpServletRequest request) {
        if (request == null) {
            return false;
        }

        String uri = request.getRequestURI();
        if (uri != null && uri.startsWith("/admin")) {
            return true;
        }

        Object originalUri = request.getAttribute(RequestDispatcher.ERROR_REQUEST_URI);
        return originalUri != null && originalUri.toString().startsWith("/admin");
    }
}
