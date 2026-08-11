package com.project.cepat.kelar.fe.controller.backoffice;

import java.util.ArrayList;

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

import com.project.cepat.kelar.jpa.model.Highlight;
import com.project.cepat.kelar.service.backoffice.AdminService;
import com.project.cepat.kelar.service.backoffice.HighlightService;

@Controller
@RequestMapping("/admin/highlights")
public class HighlightPageController {

    @Autowired(required = false)
    private AdminService adminService;

    @Autowired(required = false)
    private HighlightService highlightService;

    @GetMapping("")
    public String highlights(
            @RequestParam(value = "query", required = false) String query,
            @RequestParam(value = "page", defaultValue = "1") int page, // Mengambil parameter halaman
            ModelMap model) {
            
        if (adminService != null) {
            Authentication auth = SecurityContextHolder.getContext().getAuthentication();
            model.addAttribute("adminName", adminService.resolveAdminName(auth));
        }

        try {
            if (highlightService != null) {
                // Spring Data JPA menghitung indeks halaman dari 0
                int pageIndex = Math.max(0, page - 1); 
                
                // Setel 10 item per halaman
                var pageRequest = PageRequest.of(pageIndex, 10); 
                
                Page<Highlight> highlightPage;

                if (query != null && !query.trim().isEmpty()) {
                    highlightPage = highlightService.getPageable(query.trim(), pageRequest);
                    model.addAttribute("query", query);
                } else {
                    highlightPage = highlightService.getPageableActive(pageRequest);
                }

                // Kirim data ke FTL beserta atribut paginasi
                model.addAttribute("sorotanList", highlightPage.getContent());
                model.addAttribute("currentPage", page);
                model.addAttribute("totalPages", highlightPage.getTotalPages());
                model.addAttribute("totalItems", highlightPage.getTotalElements());
            } else {
                model.addAttribute("sorotanList", new ArrayList<Highlight>());
                model.addAttribute("currentPage", 1);
                model.addAttribute("totalPages", 0);
                model.addAttribute("totalItems", 0);
            }
        } catch (Exception e) {
            model.addAttribute("sorotanList", new ArrayList<Highlight>());
            model.addAttribute("currentPage", 1);
            model.addAttribute("totalPages", 0);
            model.addAttribute("totalItems", 0);
        }

        return "backoffice/admin-highlights";
    }

    @GetMapping({"/new", "/edit/{id}"})
    public String highlightEditor(@PathVariable(value = "id", required = false) Long id, ModelMap model) {
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
                // Tetap izinkan akses ke editor jika pencarian ID gagal
            }
        }

        model.addAttribute("highlightId", id);
        return "backoffice/admin-highlight-editor";
    }
}