package com.project.cepat.kelar.jpa.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.project.cepat.kelar.jpa.model.VoteLog;

@Repository
public interface VoteLogRepository extends JpaRepository<VoteLog, Long> {
    
    // Mengecek apakah sudah ada record dengan votingId dan ipAddress yang sama
    boolean existsByVotingIdAndIpAddress(Long votingId, String ipAddress);
}