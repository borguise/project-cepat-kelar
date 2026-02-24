package com.project.cepat.kelar.fe.controller.backoffice;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.project.cepat.kelar.common.wrapper.AdminWrapper;
import com.project.cepat.kelar.jpa.model.User;
import com.project.cepat.kelar.service.backoffice.AdminService;

@Controller
@RequestMapping("/admin")
public class BackofficePageController {

    private static final Logger logger = LoggerFactory.getLogger(BackofficePageController.class);

    @Autowired(required = false)
    private AdminService adminService;

    @GetMapping("/articles")
    public String articles(ModelMap model) {
        addAdminName(model);
        return "backoffice/admin-articles";
    }

    @GetMapping({"/articles/new", "/articles/edit/{id}"})
    public String articleEditor(@PathVariable(required = false) Long id, ModelMap model) {
        addAdminName(model);
        model.addAttribute("articleId", id);
        return "backoffice/admin-article-editor";
    }

    @GetMapping("/events")
    public String events(ModelMap model) {
        addAdminName(model);
        return "backoffice/admin-events";
    }

    @GetMapping({"/events/new", "/events/edit/{id}", "/events/update"})
    public String eventEditor(@PathVariable(required = false) Long id, ModelMap model) {
        addAdminName(model);
        model.addAttribute("eventId", id);
        return "backoffice/admin-event-editor";
    }

    @GetMapping("/collections")
    public String collections(ModelMap model) {
        addAdminName(model);
        return "backoffice/admin-collections";
    }

    @GetMapping({"/collections/new", "/collections/edit/{id}"})
    public String collectionEditor(@PathVariable(required = false) Long id, ModelMap model) {
        addAdminName(model);
        model.addAttribute("collectionId", id);
        return "backoffice/admin-collection-editor";
    }

    @GetMapping("/collections/overlay")
    public String collectionsOverlay(ModelMap model) {
        addAdminName(model);
        return "backoffice/admin-filter-overlay";
    }

    @GetMapping("/audio")
    public String audio(ModelMap model) {
        addAdminName(model);
        return "backoffice/admin-audio";
    }

    @GetMapping({"/audio/new", "/audio/edit/{id}"})
    public String audioEditor(@PathVariable(required = false) Long id, ModelMap model) {
        addAdminName(model);
        model.addAttribute("audioId", id);
        return "backoffice/admin-audio-editor";
    }

    @GetMapping("/highlights")
    public String highlights(ModelMap model) {
        addAdminName(model);
        return "backoffice/admin-highlights";
    }

    @GetMapping({"/highlights/new", "/highlights/edit/{id}"})
    public String highlightEditor(@PathVariable(required = false) Long id, ModelMap model) {
        addAdminName(model);
        model.addAttribute("highlightId", id);
        return "backoffice/admin-highlight-editor";
    }

    @GetMapping("/voting")
    public String voting(ModelMap model) {
        addAdminName(model);
        return "backoffice/admin-voting";
    }

    @GetMapping({"/voting/new", "/voting/edit/{id}"})
    public String votingEditor(@PathVariable(required = false) Long id, ModelMap model) {
        addAdminName(model);
        model.addAttribute("votingId", id);
        return "backoffice/admin-voting-editor";
    }

    @GetMapping("/comments")
    public String comments(ModelMap model) {
        addAdminName(model);
        return "backoffice/admin-comments";
    }

    @GetMapping("/homepage")
    public String homepage(ModelMap model) {
        addAdminName(model);
        return "backoffice/admin-homepage";
    }

    private void addAdminName(ModelMap model) {
        String adminName = resolveAdminName();
        if (adminName != null) {
            model.addAttribute("adminName", adminName);
        }
    }

    private String resolveAdminName() {
        try {
            Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
            if (authentication == null) {
                return null;
            }
            Object principal = authentication.getPrincipal();
            if (principal instanceof User user) {
                if (adminService != null) {
                    AdminWrapper admin = adminService.getAdminByUserNo(user.getNo());
                    if (admin != null && admin.getUsername() != null) {
                        return admin.getUsername();
                    }
                }
                return user.getUsername();
            }
        } catch (Exception e) {
            logger.warn("Unable to resolve admin name", e);
        }
        return null;
    }
}
