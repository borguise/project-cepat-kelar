package com.project.cepat.kelar.jpa.repository;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.project.cepat.kelar.jpa.model.Highlight;

public interface HighlightRepository extends JpaRepository<Highlight, Long> {

    @Query("select h from Highlight h where h.deleted = 0 order by coalesce(h.displayOrder, 999999) asc, h.id desc")
    Page<Highlight> getPageableActive(Pageable pageable);

    @Query("select h from Highlight h where h.deleted = 0 and (lower(coalesce(h.question,'')) like lower(concat('%', :text, '%')) or lower(coalesce(h.answer,'')) like lower(concat('%', :text, '%'))) order by coalesce(h.displayOrder, 999999) asc, h.id desc")
    Page<Highlight> getPageable(@Param("text") String text, Pageable pageable);

    @Query("select h from Highlight h where h.deleted = 0 and upper(coalesce(h.status,'')) = 'PUBLISHED' order by coalesce(h.displayOrder, 999999) asc, h.id asc")
    List<Highlight> getActivePublishedList();
}
