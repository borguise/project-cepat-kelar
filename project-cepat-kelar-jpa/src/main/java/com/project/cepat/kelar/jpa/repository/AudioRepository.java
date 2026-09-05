package com.project.cepat.kelar.jpa.repository;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.project.cepat.kelar.jpa.model.Audio;

public interface AudioRepository extends JpaRepository<Audio, Long> {

    @Query("select a from AudioEntity a where a.deleted = 0 order by a.id desc")
    Page<Audio> getPageableActive(Pageable pageable);

    @Query("select a from AudioEntity a where a.deleted = 0 and (lower(coalesce(a.title,'')) like lower(concat('%', :text, '%')) or lower(coalesce(a.responsibility,'')) like lower(concat('%', :text, '%')) or lower(coalesce(a.callNumber,'')) like lower(concat('%', :text, '%')) or lower(coalesce(a.subject,'')) like lower(concat('%', :text, '%')) or lower(coalesce(a.publisher,'')) like lower(concat('%', :text, '%'))) order by a.id desc")
    Page<Audio> getPageable(@Param("text") String text, Pageable pageable);

    @Query("select a from AudioEntity a where a.deleted = 0 and upper(coalesce(a.status,'')) = 'PUBLISHED' order by a.id desc")
    Page<Audio> getPageablePublished(Pageable pageable);

    @Query("select a from AudioEntity a where a.deleted = 0 and upper(coalesce(a.status,'')) = 'PUBLISHED' and (lower(coalesce(a.title,'')) like lower(concat('%', :text, '%')) or lower(coalesce(a.responsibility,'')) like lower(concat('%', :text, '%')) or lower(coalesce(a.publisher,'')) like lower(concat('%', :text, '%'))) order by a.id desc")
    Page<Audio> searchPublished(@Param("text") String text, Pageable pageable);
}