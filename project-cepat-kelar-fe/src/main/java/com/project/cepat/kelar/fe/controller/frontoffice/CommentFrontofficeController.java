package com.project.cepat.kelar.fe.controller.frontoffice;

import java.util.Date;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.project.cepat.kelar.jpa.model.Article;
import com.project.cepat.kelar.jpa.model.Comment;
import com.project.cepat.kelar.service.backoffice.ArticleService;
import com.project.cepat.kelar.service.backoffice.CommentService;

@Controller
@RequestMapping("/comment")
public class CommentFrontofficeController {

    private static final Logger logger = LoggerFactory.getLogger(CommentFrontofficeController.class);

    @Autowired(required = false)
    private CommentService commentService;

    @Autowired(required = false)
    private ArticleService articleService;

    @PostMapping("/submit")
    public String submitComment(
            @RequestParam(value = "name", required = true) String name,
            @RequestParam(value = "email", required = false) String email,
            @RequestParam(value = "comment", required = true) String commentText,
            @RequestParam(value = "articleId", required = false) Long articleId,
            @RequestParam(value = "source", required = false) String source,
            @RequestParam(value = "redirectUrl", required = false) String redirectUrl,
            RedirectAttributes redirectAttributes) {
        
        String targetUrl = redirectUrl != null && !redirectUrl.isEmpty() ? redirectUrl : "/articles";

        try {
            if (commentService != null) {
                Comment comment = new Comment();
                comment.setSender(name);
                comment.setUserEmail(email);
                comment.setContent(commentText);
                comment.setSource(source != null ? source : "Article");
                comment.setStatus("Hidden"); // Default to hidden for moderation
                comment.setCommentDate(new Date());

                // Set article relationship if articleId is provided
                if (articleId != null && articleService != null) {
                    try {
                        Article article = articleService.getById(articleId);
                        if (article != null) {
                            comment.setArticle(article);
                            logger.info("Article relationship set for comment on article ID: {}", articleId);
                        }
                    } catch (Exception e) {
                        logger.warn("Could not load article with ID {}: {}", articleId, e.getMessage());
                    }
                }

                commentService.save(comment);
                logger.info("Comment submitted by: {}", name);
                redirectAttributes.addFlashAttribute("commentSuccess", "Komentar Anda berhasil dikirim dan menunggu moderasi!");
            } else {
                redirectAttributes.addFlashAttribute("commentError", "Layanan komentar tidak tersedia!");
            }
        } catch (Exception e) {
            logger.error("Error submitting comment: {}", e.getMessage(), e);
            redirectAttributes.addFlashAttribute("commentError", "Gagal mengirim komentar: " + e.getMessage());
        }

        return "redirect:" + targetUrl;
    }
}
