package com.project.cepat.kelar.fe.controller.backoffice;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
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
    public String collections(
            @RequestParam(value = "query", required = false) String query, 
            @RequestParam(value = "page", defaultValue = "1") int page,
            ModelMap model) {
        
        if (adminService != null) {
            Authentication auth = SecurityContextHolder.getContext().getAuthentication();
            model.addAttribute("adminName", adminService.resolveAdminName(auth));
        }

        try {
            if (collectionService != null) {
                int pageIndex = Math.max(0, page - 1);
                var pageRequest = PageRequest.of(pageIndex, 10); // Batasi 10 data per halaman
                
                Page<Collection> bookPage;
                if (query != null && !query.trim().isEmpty()) {
                    bookPage = collectionService.getPageable(query.trim(), pageRequest);
                    model.addAttribute("query", query);
                } else {
                    bookPage = collectionService.getPageableActive(pageRequest);
                }
                
                // Kirim variabel paginasi ke FTL
                model.addAttribute("daftarBuku", bookPage.getContent());
                model.addAttribute("currentPage", page);
                model.addAttribute("totalPages", bookPage.getTotalPages());
                model.addAttribute("totalItems", bookPage.getTotalElements());
            }
        } catch (Exception ignored) {
            model.addAttribute("daftarBuku", new java.util.ArrayList<Collection>());
            model.addAttribute("currentPage", 1);
            model.addAttribute("totalPages", 0);
            model.addAttribute("totalItems", 0);
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
            }
        }

        model.addAttribute("collectionId", id);
        return "backoffice/admin-collection-editor";
    }
}