package com.project.cepat.kelar.fe.controller.frontoffice;
import java.util.Comparator;
import java.util.List;
import java.util.stream.Collectors;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@RequestMapping("/articles")
public class ArticleFrontofficeController {

    private static final Logger logger = LoggerFactory.getLogger(ArticleFrontofficeController.class);

	@Autowired(required = false)
	private com.project.cepat.kelar.service.backoffice.ArticleService articleService;

    @GetMapping("")
    public String articles(ModelMap model) {
        try {
            if (articleService != null) {
            List<com.project.cepat.kelar.jpa.model.Article> articles = articleService
                .getByStatus(com.project.cepat.kelar.common.constant.ArticleStatus.PUBLISHED)
                .stream()
                .sorted(
                    Comparator
                        .comparing(com.project.cepat.kelar.jpa.model.Article::getPublishDate,
                            Comparator.nullsLast(Comparator.naturalOrder()))
                        .thenComparing(com.project.cepat.kelar.jpa.model.Article::getId,
                            Comparator.nullsLast(Comparator.naturalOrder()))
                        .reversed())
                .limit(9)
                .collect(Collectors.toList());

            model.addAttribute("articles", articles);
            } else {
                model.addAttribute("articles", new java.util.ArrayList<>());
            }
        } catch (Exception e) {
            model.addAttribute("articles", new java.util.ArrayList<>());
        }
        return "frontoffice/articles";
    }

    @GetMapping("/detail")
    public String articleDetail(@RequestParam(required = false) Long id, ModelMap model) {
        try {
            if (id != null && articleService != null) {
                var article = articleService.getById(id);
                model.addAttribute("articleTitle", article.getTitle());
                model.addAttribute("articleContent", article.getContent());
                if (article.getCoverImage() != null && !article.getCoverImage().isEmpty()) {
                    model.addAttribute("articleImage", "/admin/articles/image/" + article.getId());
                }
                model.addAttribute("backUrl", "/articles");
            }
        } catch (Exception e) {
            logger.error("Error loading article detail: {}", e.getMessage(), e);
        }
        return "frontoffice/article-detail";
    }

    @GetMapping("/detail-alt")
    public String articleDetailAlt(@RequestParam(required = false) Long id, ModelMap model) {
        try {
            if (id != null && articleService != null) {
                var article = articleService.getById(id);
                model.addAttribute("articleTitle", article.getTitle());
                model.addAttribute("articleContent", article.getContent());
                if (article.getCoverImage() != null && !article.getCoverImage().isEmpty()) {
                    model.addAttribute("articleImage", "/admin/articles/image/" + article.getId());
                }
                model.addAttribute("backUrl", "/articles");
            }
        } catch (Exception e) {
            logger.error("Error loading article detail: {}", e.getMessage(), e);
        }
        return "frontoffice/article-detail-alt";
    }
}
