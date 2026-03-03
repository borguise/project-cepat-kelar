package com.project.cepat.kelar.jpa.repository;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.project.cepat.kelar.jpa.model.Event;

public interface EventRepository extends JpaRepository<Event, Long> {

	@Query("select e from Event e where e.deleted = 0 order by e.eventDate desc")
	Page<Event> getPageableActive(Pageable pageable);

	@Query("select e from Event e where e.deleted = 0 and (lower(e.name) like lower(concat('%', :text, '%')) or lower(coalesce(e.status,'')) like lower(concat('%', :text, '%'))) order by e.eventDate desc")
	Page<Event> getPageable(@Param("text") String text, Pageable pageable);

	@Query("select e from Event e where e.deleted = 0 order by e.eventDate desc")
	List<Event> getActiveList();
}
