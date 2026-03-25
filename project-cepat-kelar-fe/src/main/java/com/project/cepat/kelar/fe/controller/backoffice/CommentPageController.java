package com.project.cepat.kelar.fe.controller.backoffice;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.project.cepat.kelar.jpa.model.Comment;
import com.project.cepat.kelar.service.backoffice.CommentService;

@Controller
@RequestMapping("/admin/comments")
public class CommentPageController {

    @Autowired(required = false)
    private com.project.cepat.kelar.service.backoffice.AdminService adminService;

    @Autowired(required = false)
    private CommentService commentService;

    private static final SimpleDateFormat DATE_FORMAT = new SimpleDateFormat("dd MMM yyyy");

    @GetMapping("")
    public String comments(@RequestParam(value = "page", defaultValue = "0") int page,
            @RequestParam(value = "size", defaultValue = "10") int size,
            @RequestParam(value = "search", required = false) String search,
            ModelMap model) {
        if (adminService != null) {
            Authentication auth = SecurityContextHolder.getContext().getAuthentication();
            model.addAttribute("adminName", adminService.resolveAdminName(auth));
        }

        if (commentService != null) {
            try {
                Pageable pageable = PageRequest.of(page, size);
                Page<Comment> commentPage;
                
                if (search != null && !search.trim().isEmpty()) {
                    commentPage = commentService.getPageable(search, pageable);
                    model.addAttribute("searchKeyword", search);
                } else {
                    commentPage = commentService.getPageableActive(pageable);
                }

                // Convert to Map with formatted date for template display
                List<Map<String, Object>> commentMaps = new ArrayList<>();
                for (Comment comment : commentPage.getContent()) {
                    Map<String, Object> map = new HashMap<>();
                    map.put("id", comment.getId());
                    map.put("sender", comment.getSender() != null ? comment.getSender() : "Unknown");
                    map.put("commentDate", comment.getCommentDate() != null ? DATE_FORMAT.format(comment.getCommentDate()) : "-");
                    map.put("content", comment.getContent() != null ? comment.getContent() : "");
                    map.put("source", comment.getSource() != null ? comment.getSource() : "-");
                    map.put("status", comment.getStatus() != null ? comment.getStatus() : "Hidden");
                    commentMaps.add(map);
                }

                model.addAttribute("comments", commentMaps);
                model.addAttribute("currentPage", page);
                model.addAttribute("totalPages", commentPage.getTotalPages());
                model.addAttribute("totalItems", commentPage.getTotalElements());
            } catch (Exception e) {
                model.addAttribute("errorMessage", "Gagal memuat daftar komentar: " + e.getMessage());
            }
        }

        return "backoffice/admin-comments";
    }
}
