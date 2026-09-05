package com.project.cepat.kelar.fe.controller.backoffice;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.project.cepat.kelar.jpa.model.Article;

@Controller
@RequestMapping("/admin/articles")
public class ArticlePageController {

    private static final Logger logger = LoggerFactory.getLogger(ArticlePageController.class);

    @Autowired(required = false)
    private com.project.cepat.kelar.service.backoffice.ArticleService articleService;
    
    @Autowired(required = false)
    private com.project.cepat.kelar.service.backoffice.AdminService adminService;

    @GetMapping("")
    public String articles(
            @RequestParam(value = "search", required = false) String searchText,
            @RequestParam(value = "searchType", required = false, defaultValue = "all") String searchType,
            @RequestParam(value = "page", defaultValue = "0") int page,
            @RequestParam(value = "size", defaultValue = "10") int size,
            ModelMap model) {
        
        if (adminService != null) {
            Authentication auth = SecurityContextHolder.getContext().getAuthentication();
            model.addAttribute("adminName", adminService.resolveAdminName(auth));
        }
        
        try {
            if (articleService != null) {
                Pageable pageable = PageRequest.of(page, size);
                Page<Article> articlePage;

                if (searchText != null && !searchText.trim().isEmpty()) {
                    logger.info("Searching articles with text: {}, type: {}, page: {}, size: {}", searchText, searchType, page, size);
                    
                    switch (searchType) {
                        case "title":
                            articlePage = articleService.getPageableByTitle(searchText, pageable);
                            break;
                        case "category":
                            articlePage = articleService.getPageableByCategory(searchText, pageable);
                            break;
                        default:
                            articlePage = articleService.getPageable(searchText, pageable);
                            break;
                    }
                    
                    model.addAttribute("searchText", searchText);
                    model.addAttribute("searchType", searchType);
                } else {
                    articlePage = articleService.getPageableActive(pageable);
                }

                model.addAttribute("articles", articlePage.getContent());
                model.addAttribute("currentPage", articlePage.getNumber());
                model.addAttribute("totalPages", articlePage.getTotalPages());
                model.addAttribute("totalItems", articlePage.getTotalElements());
                model.addAttribute("pageSize", size);

                logger.info("Loaded page {}/{} with {} articles", articlePage.getNumber(), articlePage.getTotalPages(), articlePage.getNumberOfElements());
            } else {
                model.addAttribute("articles", new java.util.ArrayList<>());
                model.addAttribute("currentPage", 0);
                model.addAttribute("totalPages", 0);
                model.addAttribute("totalItems", 0);
            }
        } catch (Exception e) {
            logger.error("Error loading articles with pagination: {}", e.getMessage(), e);
            model.addAttribute("articles", new java.util.ArrayList<>());
            model.addAttribute("currentPage", 0);
            model.addAttribute("totalPages", 0);
            model.addAttribute("totalItems", 0);
        }
        return "backoffice/admin-articles";
    }

    @GetMapping({"/new", "/edit/{id}"})
    public String articleEditor(@PathVariable(required = false) Long id, ModelMap model) {
        if (adminService != null) {
            Authentication auth = SecurityContextHolder.getContext().getAuthentication();
            model.addAttribute("adminName", adminService.resolveAdminName(auth));
        }
        if (id != null) {
            try {
                if (articleService != null) {
                    Article article = articleService.getById(id);
                    model.addAttribute("artikel", article);
                }
            } catch (Exception e) {
                logger.error("Error loading article for edit: {}", e.getMessage(), e);
            }
        }
        return "backoffice/admin-article-editor";
    }

    // --- TAMBAHAN METHOD UNTUK MENANGANI TOGGLE VISIBILITY (MENCEGAH ERROR 404) ---
    @GetMapping("/toggle-visibility/{id}")
    public String toggleVisibility(@PathVariable("id") Long id, RedirectAttributes redirectAttributes) {
        try {
            if (articleService != null) {
                Article article = articleService.getById(id);
                if (article != null) {
                    // Logika biner status artikel: PUBLISHED <-> HIDDEN
                    if (article.getStatus() == com.project.cepat.kelar.common.constant.ArticleStatus.PUBLISHED) {
                        article.setStatus(com.project.cepat.kelar.common.constant.ArticleStatus.HIDDEN);
                    } else {
                        article.setStatus(com.project.cepat.kelar.common.constant.ArticleStatus.PUBLISHED);
                    }
                    articleService.save(article);
                    redirectAttributes.addFlashAttribute("successMessage", "Status tayang artikel berhasil diubah!");
                }
            }
        } catch (Exception e) {
            logger.error("Error toggling article visibility: {}", e.getMessage(), e);
            redirectAttributes.addFlashAttribute("errorMessage", "Gagal mengubah status artikel: " + e.getMessage());
        }
        return "redirect:/admin/articles";
    }
}