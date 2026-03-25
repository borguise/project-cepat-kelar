package com.project.cepat.kelar.jpa.repository;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.project.cepat.kelar.jpa.model.Collection;

public interface CollectionRepository extends JpaRepository<Collection, Long> {

    @Query("select b from CollectionEntity b where b.deleted = 0 order by b.id desc")
    Page<Collection> getPageableActive(Pageable pageable);

    @Query("select b from CollectionEntity b where b.deleted = 0 and (lower(coalesce(b.title,'')) like lower(concat('%', :text, '%')) or lower(coalesce(b.author,'')) like lower(concat('%', :text, '%')) or lower(coalesce(b.callNumber,'')) like lower(concat('%', :text, '%')) or lower(coalesce(b.subject,'')) like lower(concat('%', :text, '%')) or lower(coalesce(b.publisher,'')) like lower(concat('%', :text, '%')) or lower(coalesce(b.isbn,'')) like lower(concat('%', :text, '%'))) order by b.id desc")
    Page<Collection> getPageable(@Param("text") String text, Pageable pageable);

    @Query("select b from CollectionEntity b where b.deleted = 0 and upper(coalesce(b.status,'')) = 'PUBLISHED' order by b.id desc")
    Page<Collection> getPageablePublished(Pageable pageable);

    @Query("select b from CollectionEntity b where b.deleted = 0 and upper(coalesce(b.status,'')) = 'PUBLISHED' and (lower(coalesce(b.title,'')) like lower(concat('%', :text, '%')) or lower(coalesce(b.author,'')) like lower(concat('%', :text, '%')) or lower(coalesce(b.publisher,'')) like lower(concat('%', :text, '%')) or lower(coalesce(b.isbn,'')) like lower(concat('%', :text, '%'))) order by b.id desc")
    Page<Collection> searchPublished(@Param("text") String text, Pageable pageable);
}
