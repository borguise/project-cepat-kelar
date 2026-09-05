package com.project.cepat.kelar.fe.controller.frontoffice;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.project.cepat.kelar.jpa.model.Event;
import com.project.cepat.kelar.service.backoffice.EventService;

@Controller
@RequestMapping("/events")
public class EventFrontofficeController {

    private static final Logger logger = LoggerFactory.getLogger(EventFrontofficeController.class);

    @Autowired(required = false)
    private EventService eventService;

    @GetMapping("")
    public String events(ModelMap model) {
        Map<String, Object> primaryEvent = new HashMap<>();
        List<Map<String, Object>> upcomingEventList = new ArrayList<>();

        try {
            if (eventService != null) {
                // Ambil data aktif dari service
                var rawEvents = eventService.getPageableActive(PageRequest.of(0, 20)).getContent();
                
                // Filter ketat: HANYA ambil yang statusnya Disetujui atau PUBLISHED
                List<Event> events = new ArrayList<>();
                for (Event ev : rawEvents) {
                    if (ev.getStatus() != null) {
                        String status = ev.getStatus().trim();
                        if ("Disetujui".equalsIgnoreCase(status) || "PUBLISHED".equalsIgnoreCase(status)) {
                            events.add(ev);
                        }
                    }
                }

                SimpleDateFormat formatter = new SimpleDateFormat("dd MMMM yyyy", new Locale("id", "ID"));

                if (!events.isEmpty()) {
                    Event primary = events.get(0);
                    primaryEvent.put("id", primary.getId());
                    primaryEvent.put("title", primary.getName() != null ? primary.getName() : "Agenda Literasi");
                    primaryEvent.put("description", primary.getEventDescription() != null ? primary.getEventDescription() : "-");
                    primaryEvent.put("dateLabel", primary.getEventDate() != null ? formatter.format(primary.getEventDate()) : "Tanggal belum tersedia");
                    if (primary.getPosterImageData() != null && primary.getPosterImageData().length > 0) {
                        primaryEvent.put("imageUrl", "/events/image/" + primary.getId());
                    }
                }

                String[] iconClasses = {"fa-book-open", "fa-calendar-days", "fa-users", "fa-lightbulb", "fa-graduation-cap", "fa-chalkboard-user"};
                
                // Batasi maksimal 2 agenda selanjutnya yang tampil di bawah
                int limitCount = Math.min(events.size(), 3);
                for (int index = 1; index < limitCount; index++) {
                    Event event = events.get(index);
                    Map<String, Object> next = new HashMap<>();
                    next.put("id", event.getId());
                    next.put("title", event.getName() != null ? event.getName() : "Agenda");
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

    @GetMapping("/image/{id}")
    public ResponseEntity<byte[]> getEventImage(@PathVariable Long id) {
        try {
            if (eventService != null) {
                Event event = eventService.getById(id);
                if (event != null && event.getPosterImageData() != null && event.getPosterImageData().length > 0) {
                    HttpHeaders headers = new HttpHeaders();
                    headers.setContentType(resolveMediaType(event.getPosterImage()));
                    headers.setContentLength(event.getPosterImageData().length);
                    return new ResponseEntity<>(event.getPosterImageData(), headers, HttpStatus.OK);
                }
            }
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        } catch (Exception e) {
            logger.error("Error loading frontoffice event image: {}", e.getMessage(), e);
            return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    private MediaType resolveMediaType(String fileName) {
        if (fileName == null) {
            return MediaType.APPLICATION_OCTET_STREAM;
        }
        String lower = fileName.toLowerCase();
        if (lower.endsWith(".png")) {
            return MediaType.IMAGE_PNG;
        }
        if (lower.endsWith(".gif")) {
            return MediaType.IMAGE_GIF;
        }
        if (lower.endsWith(".webp")) {
            return MediaType.parseMediaType("image/webp");
        }
        return MediaType.IMAGE_JPEG;
    }
}