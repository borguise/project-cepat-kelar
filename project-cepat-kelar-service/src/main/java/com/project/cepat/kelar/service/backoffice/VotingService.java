package com.project.cepat.kelar.service.backoffice;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import com.project.cepat.kelar.jpa.model.Voting;
import com.project.cepat.kelar.jpa.model.VotingEntry;

public interface VotingService {
    Voting getActiveVoting();
    List<VotingEntry> getEntriesByVotingId(Long votingId);
    Voting getById(Long id);
    Voting save(Voting voting);
    Voting saveFromForm(Long id, String name, String startDate, String endDate, String title, String description, String status) throws Exception;
    void saveEntry(Long votingId, String name, String summary, String imageUrl) throws Exception;
    void delete(Long id);
    void deleteEntry(Long id);
    boolean submitVote(Long entryId, Long votingId, String ipAddress);
    Page<Voting> getPageableActive(Pageable pageable);
    Page<Voting> getPageable(String text, Pageable pageable);
}