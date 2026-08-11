package com.project.cepat.kelar.fe.controller.backoffice;

import java.util.ArrayList;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.project.cepat.kelar.jpa.model.Event;

@Controller
@RequestMapping("/admin/events")
public class EventPageController {

    private static final Logger logger = LoggerFactory.getLogger(EventPageController.class);

    @Autowired(required = false)
    private com.project.cepat.kelar.service.backoffice.EventService eventService;
    
    @Autowired(required = false)
    private com.project.cepat.kelar.service.backoffice.AdminService adminService;

    @GetMapping({"", "/search"})
    public String events(
            @RequestParam(value = "query", required = false) String query,
            @RequestParam(value = "page", defaultValue = "1") int page,
            ModelMap model) {
        
        if (adminService != null) {
            Authentication auth = SecurityContextHolder.getContext().getAuthentication();
            model.addAttribute("adminName", adminService.resolveAdminName(auth));
        }
        
        try {
            if (eventService != null) {
                int pageIndex = Math.max(0, page - 1);
                PageRequest pageRequest = PageRequest.of(pageIndex, 10); // 10 Data per halaman
                Page<Event> eventPage;
                
                if (query != null && !query.trim().isEmpty()) {
                    eventPage = eventService.getPageable(query.trim(), pageRequest);
                    model.addAttribute("query", query);
                } else {
                    eventPage = eventService.getPageableActive(pageRequest);
                }
                
                model.addAttribute("eventList", eventPage.getContent());
                model.addAttribute("currentPage", page);
                model.addAttribute("totalPages", eventPage.getTotalPages());
                model.addAttribute("totalItems", eventPage.getTotalElements());
            }
        } catch (Exception e) {
            logger.error("Error loading events: {}", e.getMessage(), e);
            model.addAttribute("eventList", new ArrayList<>());
            model.addAttribute("currentPage", 1);
            model.addAttribute("totalPages", 0);
            model.addAttribute("totalItems", 0);
        }
        
        return "backoffice/admin-events";
    }

    @GetMapping({"/new", "/edit/{id}", "/update"})
    public String eventEditor(@PathVariable(required = false) Long id, ModelMap model) {
        if (adminService != null) {
            Authentication auth = SecurityContextHolder.getContext().getAuthentication();
            model.addAttribute("adminName", adminService.resolveAdminName(auth));
        }
        if (id != null) {
            try {
                if (eventService != null) {
                    Event eventItem = eventService.getById(id);
                    model.addAttribute("eventItem", eventItem);
                }
            } catch (Exception e) {
                logger.error("Error loading event for edit: {}", e.getMessage(), e);
            }
        }
        return "backoffice/admin-event-editor";
    }
}