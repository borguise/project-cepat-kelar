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

import com.project.cepat.kelar.jpa.model.Collection;

@Controller
@RequestMapping("/admin/collections")
public class CollectionPageController {

    @Autowired(required = false)
    private com.project.cepat.kelar.service.backoffice.AdminService adminService;

    @Autowired(required = false)
    private com.project.cepat.kelar.service.backoffice.CollectionService collectionService;

    @GetMapping("")
    public String collections(@RequestParam(value = "query", required = false) String query, ModelMap model) {
        if (adminService != null) {
            Authentication auth = SecurityContextHolder.getContext().getAuthentication();
            model.addAttribute("adminName", adminService.resolveAdminName(auth));
        }

        try {
            if (collectionService != null) {
                var pageRequest = PageRequest.of(0, 100);
                if (query != null && !query.trim().isEmpty()) {
                    model.addAttribute("daftarBuku", collectionService.getPageable(query.trim(), pageRequest).getContent());
                    model.addAttribute("query", query);
                } else {
                    model.addAttribute("daftarBuku", collectionService.getPageableActive(pageRequest).getContent());
                }
            }
        } catch (Exception ignored) {
            model.addAttribute("daftarBuku", new java.util.ArrayList<Collection>());
        }

        return "backoffice/admin-collections";
    }

    @GetMapping({"/new", "/edit/{id}"})
    public String collectionEditor(@PathVariable(required = false) Long id, ModelMap model) {
        if (adminService != null) {
            Authentication auth = SecurityContextHolder.getContext().getAuthentication();
            model.addAttribute("adminName", adminService.resolveAdminName(auth));
        }

        if (id != null) {
            try {
                if (collectionService != null) {
                    model.addAttribute("buku", collectionService.getById(id));
                }
            } catch (Exception ignored) {
                // Keep editor accessible even if lookup fails.
            }
        }

        model.addAttribute("collectionId", id);
        return "backoffice/admin-collection-editor";
    }
}
