package com.project.cepat.kelar.fe.controller.backoffice;

import java.time.LocalDateTime;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;
import java.util.Date;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.project.cepat.kelar.common.controller.BaseController;
import com.project.cepat.kelar.jpa.model.Event;
import com.project.cepat.kelar.service.backoffice.EventService;

@Controller
@RequestMapping("/admin/events")
public class EventController extends BaseController {

	private static final Logger logger = LoggerFactory.getLogger(EventController.class);

	@Autowired(required = false)
	private EventService eventService;

	@Override
	public String pageTitle() {
		return "Event Management";
	}

	@PostMapping("/save")
	public String saveEvent(
			@RequestParam(required = false) Long id,
			@RequestParam("name") String name,
			@RequestParam("eventDate") String eventDateInput,
			@RequestParam("location") String location,
			@RequestParam(value = "status", required = false) String status,
			@RequestParam("description") String description,
			@RequestParam(value = "poster", required = false) MultipartFile poster,
			RedirectAttributes redirectAttributes) {
		try {
			if (eventService == null) {
				redirectAttributes.addFlashAttribute("errorMessage", "Service agenda tidak tersedia");
				return "redirect:/admin/events";
			}

			LocalDateTime localDateTime = LocalDateTime.parse(eventDateInput, DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm"));
			Date eventDateTime = Date.from(localDateTime.atZone(ZoneId.systemDefault()).toInstant());

			Event saved = eventService.saveFromForm(id, name, eventDateTime, location, status, description, poster);
			logger.info("Event saved with ID: {}", saved.getId());
			redirectAttributes.addFlashAttribute("successMessage", "Agenda berhasil disimpan!");
			return "redirect:/admin/events";
		} catch (Exception e) {
			logger.error("Error saving event: {}", e.getMessage(), e);
			redirectAttributes.addFlashAttribute("errorMessage", "Gagal menyimpan agenda: " + e.getMessage());
			if (id != null) {
				return "redirect:/admin/events/edit/" + id;
			}
			return "redirect:/admin/events/new";
		}
	}

	@GetMapping("/delete/{id}")
	public String deleteEvent(@PathVariable Long id, RedirectAttributes redirectAttributes) {
		try {
			if (eventService != null) {
				eventService.delete(id);
				redirectAttributes.addFlashAttribute("successMessage", "Agenda berhasil dihapus!");
			} else {
				redirectAttributes.addFlashAttribute("errorMessage", "Service agenda tidak tersedia");
			}
		} catch (Exception e) {
			logger.error("Error deleting event: {}", e.getMessage(), e);
			redirectAttributes.addFlashAttribute("errorMessage", "Gagal menghapus agenda: " + e.getMessage());
		}
		return "redirect:/admin/events";
	}

	@GetMapping("/image/{id}")
	public ResponseEntity<byte[]> getEventImage(@PathVariable Long id) {
		try {
			if (eventService != null) {
				Event event = eventService.getById(id);
				if (event != null && event.getPosterImageData() != null) {
					HttpHeaders headers = new HttpHeaders();
					headers.setContentType(MediaType.IMAGE_JPEG);
					headers.setContentLength(event.getPosterImageData().length);
					return new ResponseEntity<>(event.getPosterImageData(), headers, HttpStatus.OK);
				}
			}
			return new ResponseEntity<>(HttpStatus.NOT_FOUND);
		} catch (Exception e) {
			logger.error("Error loading event image: {}", e.getMessage(), e);
			return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}
}
