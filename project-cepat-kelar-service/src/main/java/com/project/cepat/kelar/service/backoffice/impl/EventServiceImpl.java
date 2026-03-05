package com.project.cepat.kelar.service.backoffice.impl;

import java.io.IOException;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.project.cepat.kelar.jpa.model.Event;
import com.project.cepat.kelar.jpa.repository.EventRepository;
import com.project.cepat.kelar.service.backoffice.EventService;

import lombok.extern.log4j.Log4j2;

@Service
@Transactional
@Log4j2
public class EventServiceImpl implements EventService {

	@Autowired
	private EventRepository eventRepository;

	@Override
	public Long getNum() {
		return eventRepository.count();
	}

	@Override
	public Event save(Event entity) throws Exception {
		return eventRepository.saveAndFlush(entity);
	}

	@Override
	public Event getById(Long pk) throws Exception {
		Optional<Event> event = eventRepository.findById(pk);
		if (event.isPresent()) {
			return event.get();
		}
		throw new Exception("Event not found with ID: " + pk);
	}

	@Override
	public Boolean delete(Long pk) throws Exception {
		Optional<Event> event = eventRepository.findById(pk);
		if (event.isPresent()) {
			eventRepository.deleteById(pk);
			return true;
		}
		throw new Exception("Event not found with ID: " + pk);
	}

	@Override
	public List<Event> getAll() throws Exception {
		return eventRepository.findAll();
	}

	@Override
	public Page<Event> getPageable(String text, Pageable pageable) throws Exception {
		return eventRepository.getPageable(text, pageable);
	}

	@Override
	public Page<Event> getPageableActive(Pageable pageable) throws Exception {
		return eventRepository.getPageableActive(pageable);
	}

	@Override
	public Event saveFromForm(Long id, String name, java.util.Date eventDate, String location, String status, String description,
			MultipartFile posterFile) throws Exception {
		Event event;
		if (id != null) {
			event = getById(id);
		} else {
			event = new Event();
			event.setDeleted(0);
		}

		event.setName(name);
		event.setEventDate(eventDate);
		event.setLocation(location);
		event.setEventDescription(description);
		event.setStatus((status == null || status.isBlank()) ? "Diproses" : status);

		if (posterFile != null && !posterFile.isEmpty()) {
			event.setPosterImage(posterFile.getOriginalFilename());
			try {
				event.setPosterImageData(posterFile.getBytes());
			} catch (IOException e) {
				log.warn("Failed to process event poster file: {}", e.getMessage());
			}
		}

		return save(event);
	}
}
