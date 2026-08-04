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
            @RequestParam(value = "name", required = false, defaultValue = "Anonim") String name,
            @RequestParam(value = "email", required = false, defaultValue = "") String email,
            @RequestParam(value = "comment", required = false, defaultValue = "") String commentText,
            @RequestParam(value = "articleId", required = false) String articleIdStr,
            @RequestParam(value = "source", required = false, defaultValue = "Article") String source,
            @RequestParam(value = "redirectUrl", required = false) String redirectUrl,
            RedirectAttributes redirectAttributes) {
        
        // Menggunakan redirectUrl dinamis, default ke /home jika kosong
        String targetUrl = (redirectUrl != null && !redirectUrl.trim().isEmpty()) ? redirectUrl : "/home";

        try {
            if (commentService != null) {
                Comment comment = new Comment();
                comment.setSender(name);
                comment.setUserEmail(email);
                comment.setContent(commentText);
                comment.setSource(source);
                comment.setStatus("Tampil"); 
                comment.setCommentDate(new Date());

                if (articleIdStr != null && !articleIdStr.trim().isEmpty()) {
                    try {
                        Long articleId = Long.valueOf(articleIdStr.trim());
                        if (articleService != null) {
                            Article article = articleService.getById(articleId);
                            if (article != null) {
                                // Menghubungkan relasi objek Article
                                comment.setArticle(article);
                                // Menyimpan judul artikel ke kolom source sebagai teks cadangan
                                comment.setSource(article.getTitle());
                            }
                        }
                    } catch (Exception e) {
                        logger.warn("Could not parse or load article with ID {}: {}", articleIdStr, e.getMessage());
                    }
                }

                commentService.save(comment);
                logger.info("Comment successfully saved by: {}", name);
                redirectAttributes.addFlashAttribute("commentSuccess", "Komentar Anda berhasil dikirim!");
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