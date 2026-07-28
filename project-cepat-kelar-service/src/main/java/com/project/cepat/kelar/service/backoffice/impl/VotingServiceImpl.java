package com.project.cepat.kelar.service.backoffice.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.project.cepat.kelar.jpa.model.VoteLog;
import com.project.cepat.kelar.jpa.model.Voting;
import com.project.cepat.kelar.jpa.model.VotingEntry;
import com.project.cepat.kelar.jpa.repository.VoteLogRepository;
import com.project.cepat.kelar.jpa.repository.VotingEntryRepository;
import com.project.cepat.kelar.jpa.repository.VotingRepository;
import com.project.cepat.kelar.service.backoffice.VotingService;

@Service
public class VotingServiceImpl implements VotingService {

    @Autowired
    private VotingRepository votingRepository;
    
    @Autowired
    private VotingEntryRepository votingEntryRepository;
    
    @Autowired
    private VoteLogRepository voteLogRepository;

    @Override
    public Voting getActiveVoting() {
        return votingRepository.findFirstByStatus("Aktif");
    }

    @Override
    public List<VotingEntry> getEntriesByVotingId(Long votingId) {
        return votingEntryRepository.findByVotingId(votingId);
    }

    @Override
    public Voting getById(Long id) {
        return votingRepository.findById(id).orElse(null);
    }

    @Override
    public Voting save(Voting voting) {
        return votingRepository.save(voting);
    }

    @Override
    public Voting saveFromForm(Long id, String name, String startDate, String endDate, String title, String description, String status) throws Exception {
        Voting model = (id != null && id > 0) ? getById(id) : new Voting();
        model.setName(name);
        model.setStartDate(startDate);
        model.setEndDate(endDate);
        model.setStatus(status);
        return votingRepository.save(model);
    }

    @Override
    public void saveEntry(Long votingId, String name, String summary, String imageUrl) {
        VotingEntry entry = new VotingEntry();
        
        // FIX 1: Menggunakan objek Voting karena setVotingId tidak ada
        Voting v = new Voting();
        v.setId(votingId);
        entry.setVoting(v); // Pastikan ini sesuai model VotingEntry.java kamu
        
        entry.setName(name);
        entry.setSummary(summary);
        
        // FIX 2: Menggunakan integer (0) karena error bilang "cannot be converted to Integer"
        entry.setVoteCount(0); 
        
        votingEntryRepository.save(entry);
    }

    @Override
    @Transactional
    public boolean submitVote(Long entryId, Long votingId, String ipAddress) {
        if (voteLogRepository.existsByVotingIdAndIpAddress(votingId, ipAddress)) {
            return false;
        }

        VoteLog log = new VoteLog();
        log.setVotingId(votingId);
        log.setEntryId(entryId);
        log.setIpAddress(ipAddress);
        voteLogRepository.save(log);

        VotingEntry entry = votingEntryRepository.findById(entryId).orElse(null);
        if (entry != null) {
            // FIX 3: Casting ke Integer agar tidak error "incompatible types"
            int current = (entry.getVoteCount() == null) ? 0 : entry.getVoteCount();
            entry.setVoteCount(current + 1);
            votingEntryRepository.save(entry);
            return true;
        }
        return false;
    }

    @Override
    public void delete(Long id) { votingRepository.deleteById(id); }
    
    @Override
    public void deleteEntry(Long id) { votingEntryRepository.deleteById(id); }
    
    @Override
    public org.springframework.data.domain.Page<Voting> getPageableActive(org.springframework.data.domain.Pageable pageable) { return votingRepository.findAll(pageable); }
    @Override
    public org.springframework.data.domain.Page<Voting> getPageable(String text, org.springframework.data.domain.Pageable pageable) { return votingRepository.findAll(pageable); }
}