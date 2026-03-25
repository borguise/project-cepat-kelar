package com.project.cepat.kelar.fe.controller.frontoffice;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.project.cepat.kelar.jpa.model.Comment;
import com.project.cepat.kelar.service.backoffice.CommentService;

@Controller
@RequestMapping("/articles")
public class ArticleFrontofficeController {

    private static final Logger logger = LoggerFactory.getLogger(ArticleFrontofficeController.class);
    private static final SimpleDateFormat DATE_FORMAT = new SimpleDateFormat("dd MMM yyyy");

	@Autowired(required = false)
	private com.project.cepat.kelar.service.backoffice.ArticleService articleService;

    @Autowired(required = false)
    private CommentService commentService;

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
        model.addAttribute("comments", new ArrayList<>());
        try {
            if (id != null && articleService != null) {
                var article = articleService.getById(id);
                if (article == null) {
                    return "redirect:/articles";
                }
                model.addAttribute("articleTitle", article.getTitle());
                model.addAttribute("articleContent", article.getContent());
                if (article.getCoverImage() != null && !article.getCoverImage().isEmpty()) {
                    model.addAttribute("articleImage", "/admin/articles/image/" + article.getId());
                }
                model.addAttribute("backUrl", "/articles");
                model.addAttribute("commentAction", "/comment/submit");
                model.addAttribute("articleId", id);
                model.addAttribute("commentSource", "Article: " + article.getTitle());
                model.addAttribute("redirectUrl", "/articles/detail?id=" + id);

                // Load published comments for this article
                if (commentService != null) {
                    try {
                        Pageable pageable = PageRequest.of(0, 50);
                        Page<Comment> commentPage = commentService.getCommentsByArticleId(id, pageable);
                        
                        List<Map<String, Object>> commentMaps = new ArrayList<>();
                        for (Comment comment : commentPage.getContent()) {
                            Map<String, Object> map = new HashMap<>();
                            map.put("userName", comment.getSender() != null ? comment.getSender() : "Anonymous");
                            map.put("text", comment.getContent() != null ? comment.getContent() : "");
                            map.put("date", comment.getCommentDate() != null ? DATE_FORMAT.format(comment.getCommentDate()) : "");
                            commentMaps.add(map);
                        }
                        model.addAttribute("comments", commentMaps);
                    } catch (Exception e) {
                        logger.error("Error loading comments: {}", e.getMessage(), e);
                    }
                }
            }
        } catch (Exception e) {
            logger.error("Error loading article detail: {}", e.getMessage(), e);
        }
        return "frontoffice/article-detail";
    }

    @GetMapping("/detail-alt")
    public String articleDetailAlt(@RequestParam(required = false) Long id, ModelMap model) {
        model.addAttribute("comments", new ArrayList<>());
        try {
            if (id != null && articleService != null) {
                var article = articleService.getById(id);
                if (article == null) {
                    return "redirect:/articles";
                }
                model.addAttribute("articleTitle", article.getTitle());
                model.addAttribute("articleContent", article.getContent());
                if (article.getCoverImage() != null && !article.getCoverImage().isEmpty()) {
                    model.addAttribute("articleImage", "/admin/articles/image/" + article.getId());
                }
                model.addAttribute("backUrl", "/articles");
                model.addAttribute("commentAction", "/comment/submit");
                model.addAttribute("articleId", id);
                model.addAttribute("commentSource", "Article: " + article.getTitle());
                model.addAttribute("redirectUrl", "/articles/detail-alt?id=" + id);

                // Load published comments for this article
                if (commentService != null) {
                    try {
                        Pageable pageable2 = PageRequest.of(0, 50);
                        Page<Comment> commentPage2 = commentService.getCommentsByArticleId(id, pageable2);
                        
                        List<Map<String, Object>> commentMaps2 = new ArrayList<>();
                        for (Comment comment : commentPage2.getContent()) {
                            Map<String, Object> map = new HashMap<>();
                            map.put("userName", comment.getSender() != null ? comment.getSender() : "Anonymous");
                            map.put("text", comment.getContent() != null ? comment.getContent() : "");
                            map.put("date", comment.getCommentDate() != null ? DATE_FORMAT.format(comment.getCommentDate()) : "");
                            commentMaps2.add(map);
                        }
                        model.addAttribute("comments", commentMaps2);
                    } catch (Exception e) {
                        logger.error("Error loading comments: {}", e.getMessage(), e);
                    }
                }
            }
        } catch (Exception e) {
            logger.error("Error loading article detail: {}", e.getMessage(), e);
        }
        return "frontoffice/article-detail-alt";
    }
}
