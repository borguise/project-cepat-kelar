package com.project.cepat.kelar.fe.controller.backoffice;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.project.cepat.kelar.common.controller.BaseController;
import com.project.cepat.kelar.jpa.model.Comment;
import com.project.cepat.kelar.service.backoffice.CommentService;

@Controller
@RequestMapping("/admin/comments")
public class CommentController extends BaseController {

    private static final Logger logger = LoggerFactory.getLogger(CommentController.class);

    @Autowired(required = false)
    private CommentService commentService;

    @Override
    public String pageTitle() {
        return "Comment Management";
    }

    @PostMapping("/toggle/{id}")
    public ResponseEntity<?> toggleStatus(@PathVariable Long id) {
        try {
            if (commentService == null) {
                return ResponseEntity.status(500).body("Service comment tidak tersedia");
            }
            Comment updated = commentService.toggleStatus(id);
            Map<String, Object> response = new HashMap<>();
            response.put("success", true);
            response.put("id", updated.getId());
            response.put("status", updated.getStatus());
            return ResponseEntity.ok().body(response);
        } catch (Exception e) {
            logger.error("Error toggling comment status: {}", e.getMessage(), e);
            return ResponseEntity.status(500).body("Gagal mengubah status komentar");
        }
    }

    @GetMapping("/delete/{id}")
    public String deleteComment(@PathVariable Long id, RedirectAttributes redirectAttributes) {
        try {
            if (commentService != null) {
                commentService.delete(id);
                redirectAttributes.addFlashAttribute("successMessage", "Komentar berhasil dihapus!");
            } else {
                redirectAttributes.addFlashAttribute("errorMessage", "Service comment tidak tersedia");
            }
        } catch (Exception e) {
            logger.error("Error deleting comment: {}", e.getMessage(), e);
            redirectAttributes.addFlashAttribute("errorMessage", "Gagal menghapus komentar: " + e.getMessage());
        }
        return "redirect:/admin/comments";
    }

    @PostMapping("/save")
    public String saveComment(
            @RequestParam(value = "sender", required = true) String sender,
            @RequestParam(value = "userEmail", required = false) String userEmail,
            @RequestParam(value = "content", required = true) String content,
            @RequestParam(value = "source", required = false) String source,
            @RequestParam(value = "status", required = false) String status,
            RedirectAttributes redirectAttributes) {
        try {
            if (commentService == null) {
                redirectAttributes.addFlashAttribute("errorMessage", "Service comment tidak tersedia");
                return "redirect:/admin/comments";
            }

            Comment comment = new Comment();
            comment.setSender(sender);
            comment.setUserEmail(userEmail);
            comment.setContent(content);
            comment.setSource(source != null ? source : "Manual Input");
            comment.setStatus(status != null && !status.isEmpty() ? status : "Hidden");
            comment.setCommentDate(new Date());

            commentService.save(comment);
            logger.info("Comment saved successfully");
            redirectAttributes.addFlashAttribute("successMessage", "Komentar berhasil disimpan!");
            return "redirect:/admin/comments";
        } catch (Exception e) {
            logger.error("Error saving comment: {}", e.getMessage(), e);
            redirectAttributes.addFlashAttribute("errorMessage", "Gagal menyimpan komentar: " + e.getMessage());
            return "redirect:/admin/comments";
        }
    }
}
