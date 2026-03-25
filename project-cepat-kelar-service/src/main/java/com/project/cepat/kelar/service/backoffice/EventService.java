package com.project.cepat.kelar.service.backoffice;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.web.multipart.MultipartFile;

import com.project.cepat.kelar.common.service.CommonService;
import com.project.cepat.kelar.jpa.model.Event;

public interface EventService extends CommonService<Event, Long> {

	Page<Event> getPageable(String text, Pageable pageable) throws Exception;

	Page<Event> getPageableActive(Pageable pageable) throws Exception;

	Event saveFromForm(Long id, String name, java.util.Date eventDate, String location, String status, String description, MultipartFile posterFile) throws Exception;
}
