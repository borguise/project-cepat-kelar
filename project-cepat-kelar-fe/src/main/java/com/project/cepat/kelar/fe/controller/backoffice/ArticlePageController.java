package com.project.cepat.kelar.fe.controller.backoffice;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
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
            ModelMap model) {
        if (adminService != null) {
            Authentication auth = SecurityContextHolder.getContext().getAuthentication();
            model.addAttribute("adminName", adminService.resolveAdminName(auth));
        }
        try {
            if (articleService != null) {
                List<Article> articles;
                if (searchText != null && !searchText.trim().isEmpty()) {
                    logger.info("Searching articles with text: {} and type: {}", searchText, searchType);
                    PageRequest pageRequest = PageRequest.of(0, 100);
                    
                    switch (searchType) {
                        case "title":
                            articles = articleService.getPageableByTitle(searchText, pageRequest).getContent();
                            break;
                        case "category":
                            articles = articleService.getPageableByCategory(searchText, pageRequest).getContent();
                            break;
                        default:
                            articles = articleService.getPageable(searchText, pageRequest).getContent();
                            break;
                    }
                    
                    model.addAttribute("searchText", searchText);
                    model.addAttribute("searchType", searchType);
                } else {
                    PageRequest pageRequest = PageRequest.of(0, 100);
                    articles = articleService.getPageableActive(pageRequest).getContent();
                }
                model.addAttribute("articles", articles);
                logger.info("Loaded {} articles", articles.size());
            }
        } catch (Exception e) {
            logger.error("Error loading articles: {}", e.getMessage(), e);
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
}
