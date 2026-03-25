package com.project.cepat.kelar.fe.controller.backoffice;

import java.util.ArrayList;
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
            ModelMap model) {
        if (adminService != null) {
            Authentication auth = SecurityContextHolder.getContext().getAuthentication();
            model.addAttribute("adminName", adminService.resolveAdminName(auth));
        }
        try {
            if (eventService != null) {
                List<Event> eventList;
                PageRequest pageRequest = PageRequest.of(0, 100);
                if (query != null && !query.trim().isEmpty()) {
                    eventList = eventService.getPageable(query.trim(), pageRequest).getContent();
                    model.addAttribute("query", query);
                } else {
                    eventList = eventService.getPageableActive(pageRequest).getContent();
                }
                model.addAttribute("eventList", eventList);
            }
        } catch (Exception e) {
            logger.error("Error loading events: {}", e.getMessage(), e);
            model.addAttribute("eventList", new ArrayList<>());
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
