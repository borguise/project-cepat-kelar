package com.project.cepat.kelar.fe.controller.backoffice;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.project.cepat.kelar.jpa.model.Highlight;

@Controller
@RequestMapping("/admin/highlights")
public class HighlightPageController {

    @Autowired(required = false)
    private com.project.cepat.kelar.service.backoffice.AdminService adminService;

    @Autowired(required = false)
    private com.project.cepat.kelar.service.backoffice.HighlightService highlightService;

    @GetMapping("")
    public String highlights(@RequestParam(value = "query", required = false) String query, ModelMap model) {
        if (adminService != null) {
            Authentication auth = SecurityContextHolder.getContext().getAuthentication();
            model.addAttribute("adminName", adminService.resolveAdminName(auth));
        }

        try {
            if (highlightService != null) {
                var pageRequest = PageRequest.of(0, 100);
                if (query != null && !query.trim().isEmpty()) {
                    model.addAttribute("sorotanList", highlightService.getPageable(query.trim(), pageRequest).getContent());
                    model.addAttribute("query", query);
                } else {
                    model.addAttribute("sorotanList", highlightService.getPageableActive(pageRequest).getContent());
                }
            }
        } catch (Exception ignored) {
            model.addAttribute("sorotanList", new java.util.ArrayList<Highlight>());
        }
        return "backoffice/admin-highlights";
    }

    @GetMapping({"/new", "/edit/{id}"})
    public String highlightEditor(@PathVariable(required = false) Long id, ModelMap model) {
        if (adminService != null) {
            Authentication auth = SecurityContextHolder.getContext().getAuthentication();
            model.addAttribute("adminName", adminService.resolveAdminName(auth));
        }

        if (id != null) {
            try {
                if (highlightService != null) {
                    model.addAttribute("sorotan", highlightService.getById(id));
                }
            } catch (Exception ignored) {
                // Keep editor accessible even if data lookup fails.
            }
        }

        model.addAttribute("highlightId", id);
        return "backoffice/admin-highlight-editor";
    }
}
