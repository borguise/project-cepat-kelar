package com.project.cepat.kelar.jpa.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.project.cepat.kelar.jpa.model.VotingEntry;

@Repository
public interface VotingEntryRepository extends JpaRepository<VotingEntry, Long> {
    
    // Mencari daftar kandidat berdasarkan voting_id
    List<VotingEntry> findByVotingId(Long votingId);

    // Menambah jumlah suara (Atomic Increment)
    @Modifying
    @Query("UPDATE VotingEntry e SET e.voteCount = e.voteCount + 1 WHERE e.id = :id")
    void incrementVoteCount(Long id);
}