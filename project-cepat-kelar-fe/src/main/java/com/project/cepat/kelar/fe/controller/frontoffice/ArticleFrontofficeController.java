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

import com.project.cepat.kelar.jpa.model.Article;
import com.project.cepat.kelar.jpa.model.Comment;
import com.project.cepat.kelar.service.backoffice.ArticleService;
import com.project.cepat.kelar.service.backoffice.CommentService;

@Controller
@RequestMapping("/articles")
public class ArticleFrontofficeController {

    private static final Logger logger = LoggerFactory.getLogger(ArticleFrontofficeController.class);
    private static final SimpleDateFormat DATE_FORMAT = new SimpleDateFormat("dd MMM yyyy");

    @Autowired(required = false)
    private ArticleService articleService;

    @Autowired(required = false)
    private CommentService commentService;

    @GetMapping("")
    public String articles(ModelMap model) {
        try {
            List<Article> rawArticles = new ArrayList<>();
            if (articleService != null) {
                try {
                    rawArticles = articleService.getAll();
                } catch (Exception e) {
                    try {
                        rawArticles = articleService.getByStatus(com.project.cepat.kelar.common.constant.ArticleStatus.PUBLISHED);
                    } catch (Exception ignored) {}
                }
            }

            if (rawArticles != null) {
                rawArticles = rawArticles.stream()
                    .sorted(
                        Comparator
                            .comparing(Article::getId, Comparator.nullsLast(Comparator.naturalOrder()))
                            .reversed())
                    .limit(9)
                    .collect(Collectors.toList());
            } else {
                rawArticles = new ArrayList<>();
            }

            List<Map<String, Object>> articleListMaps = new ArrayList<>();
            for (Article a : rawArticles) {
                Map<String, Object> aMap = new HashMap<>();
                aMap.put("id", a.getId());
                aMap.put("title", a.getTitle() != null ? a.getTitle() : "");
                aMap.put("content", a.getContent() != null ? a.getContent() : "");
                aMap.put("img", "/admin/articles/image/" + a.getId());

                List<Map<String, Object>> commentMaps = new ArrayList<>();
                if (commentService != null) {
                    try {
                        Pageable pageable = PageRequest.of(0, 100);
                        Page<Comment> commentPage = commentService.getCommentsByArticleId(a.getId(), pageable);
                        for (Comment c : commentPage.getContent()) {
                            if ("Tampil".equalsIgnoreCase(c.getStatus()) || "Published".equalsIgnoreCase(c.getStatus())) {
                                Map<String, Object> cMap = new HashMap<>();
                                cMap.put("sender", c.getSender() != null ? c.getSender() : "Anonim");
                                cMap.put("content", c.getContent() != null ? c.getContent() : "");
                                cMap.put("date", c.getCommentDate() != null ? DATE_FORMAT.format(c.getCommentDate()) : "");
                                commentMaps.add(cMap);
                            }
                        }
                    } catch (Exception e) {
                        logger.error("Error loading comments for article {}: {}", a.getId(), e.getMessage());
                    }
                }
                aMap.put("comments", commentMaps);
                articleListMaps.add(aMap);
            }

            model.addAttribute("articlesMap", articleListMaps);
            model.addAttribute("articles", rawArticles);
        } catch (Exception e) {
            logger.error("Error in articles frontoffice: {}", e.getMessage(), e);
            model.addAttribute("articlesMap", new ArrayList<>());
            model.addAttribute("articles", new ArrayList<>());
        }
        return "frontoffice/articles";
    }
}