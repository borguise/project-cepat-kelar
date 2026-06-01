package com.project.cepat.kelar.service.backoffice.impl;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.project.cepat.kelar.jpa.model.Voting;
import com.project.cepat.kelar.jpa.repository.VotingRepository;
import com.project.cepat.kelar.service.backoffice.VotingService;

@Service
@Transactional
public class VotingServiceImpl implements VotingService {

    @Autowired
    private VotingRepository votingRepository;

    @Override
    public Long getNum() {
        return votingRepository.count();
    }

    @Override
    public Voting save(Voting entity) throws Exception {
        return votingRepository.saveAndFlush(entity);
    }

    @Override
    public Voting getById(Long pk) throws Exception {
        Optional<Voting> model = votingRepository.findById(pk);
        if (model.isPresent()) {
            return model.get();
        }
        throw new Exception("Voting tidak ditemukan dengan ID: " + pk);
    }

    @Override
    public Boolean delete(Long pk) throws Exception {
        Voting model = getById(pk);
        model.setDeleted(1);
        save(model);
        return true;
    }

    @Override
    public List<Voting> getAll() throws Exception {
        return votingRepository.findAll();
    }

    @Override
    public Page<Voting> getPageable(String text, Pageable pageable) throws Exception {
        return votingRepository.getPageable(text, pageable);
    }

    @Override
    public Page<Voting> getPageableActive(Pageable pageable) throws Exception {
        return votingRepository.getPageableActive(pageable);
    }

    @Override
    public Voting saveFromForm(Long id, String name, String startDate, String endDate, String title, String description,
            String status) throws Exception {
        Voting model;
        if (id != null) {
            model = getById(id);
        } else {
            model = new Voting();
            model.setDeleted(0);
        }

        model.setName(name);
        model.setStartDate(startDate);
        model.setEndDate(endDate);
        model.setTitle(title);
        model.setDescription(description);
        model.setStatus((status == null || status.isBlank()) ? "Aktif" : status);

        return save(model);
    }
}
