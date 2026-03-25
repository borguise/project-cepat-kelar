package com.project.cepat.kelar.fe.controller.frontoffice;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/events")
public class EventFrontofficeController {

    private static final Logger logger = LoggerFactory.getLogger(EventFrontofficeController.class);

    @Autowired(required = false)
    private com.project.cepat.kelar.service.backoffice.EventService eventService;

    @GetMapping("")
    public String events(ModelMap model) {
        Map<String, Object> primaryEvent = new java.util.HashMap<>();
        List<Map<String, Object>> upcomingEventList = new ArrayList<>();

        try {
            if (eventService != null) {
                var events = eventService.getPageableActive(PageRequest.of(0, 9)).getContent();
                SimpleDateFormat formatter = new SimpleDateFormat("dd MMMM yyyy", new Locale("id", "ID"));

                if (!events.isEmpty()) {
                    var primary = events.get(0);
                    primaryEvent.put("id", primary.getId());
                    primaryEvent.put("title", primary.getName());
                    primaryEvent.put("description", primary.getEventDescription());
                    primaryEvent.put("dateLabel", primary.getEventDate() != null ? formatter.format(primary.getEventDate()) : "Tanggal belum tersedia");
                    if (primary.getPosterImage() != null && !primary.getPosterImage().isBlank()) {
                        primaryEvent.put("imageUrl", "/admin/events/image/" + primary.getId());
                    }
                }

                String[] iconClasses = {"fa-book-open", "fa-calendar-days", "fa-users", "fa-lightbulb", "fa-graduation-cap", "fa-chalkboard-user"};
                for (int index = 1; index < events.size(); index++) {
                    var event = events.get(index);
                    Map<String, Object> next = new java.util.HashMap<>();
                    next.put("id", event.getId());
                    next.put("title", event.getName());
                    next.put("dateLabel", event.getEventDate() != null ? formatter.format(event.getEventDate()) : "Tanggal belum tersedia");
                    next.put("iconClass", iconClasses[(index - 1) % iconClasses.length]);
                    upcomingEventList.add(next);
                }
            }
        } catch (Exception e) {
            logger.error("Error loading frontoffice events: {}", e.getMessage(), e);
        }

        if (primaryEvent.isEmpty()) {
            primaryEvent.put("title", "Jadwal Kegiatan Literasi");
            primaryEvent.put("description", "Belum ada agenda yang dipublikasikan.");
            primaryEvent.put("dateLabel", "Tanggal belum tersedia");
        }

        model.addAttribute("primaryEvent", primaryEvent);
        model.addAttribute("upcomingEventList", upcomingEventList);
        model.addAttribute("basePath", "");

        return "frontoffice/events";
    }
}
