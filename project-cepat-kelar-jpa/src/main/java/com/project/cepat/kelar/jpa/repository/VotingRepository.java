package com.project.cepat.kelar.jpa.repository;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.project.cepat.kelar.jpa.model.Voting;

public interface VotingRepository extends JpaRepository<Voting, Long> {

    @Query("select v from VotingEntity v where v.deleted = 0 order by v.id desc")
    Page<Voting> getPageableActive(Pageable pageable);

    @Query("select v from VotingEntity v where v.deleted = 0 and lower(coalesce(v.name,'')) like lower(concat('%', :text, '%')) order by v.id desc")
    Page<Voting> getPageable(@Param("text") String text, Pageable pageable);

    // --- FITUR BARU: Pencarian voting aktif ---
    Voting findFirstByStatus(String status);
}