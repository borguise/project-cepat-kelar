package com.project.cepat.kelar.service.backoffice.impl;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.project.cepat.kelar.jpa.model.Highlight;
import com.project.cepat.kelar.jpa.repository.HighlightRepository;
import com.project.cepat.kelar.service.backoffice.HighlightService;

@Service
@Transactional
public class HighlightServiceImpl implements HighlightService {

    @Autowired
    private HighlightRepository highlightRepository;

    @Override
    public Long getNum() {
        return highlightRepository.count();
    }

    @Override
    public Highlight save(Highlight entity) throws Exception {
        return highlightRepository.saveAndFlush(entity);
    }

    @Override
    public Highlight getById(Long pk) throws Exception {
        Optional<Highlight> highlight = highlightRepository.findById(pk);
        if (highlight.isPresent()) {
            return highlight.get();
        }
        throw new Exception("Sorotan tidak ditemukan dengan ID: " + pk);
    }

    @Override
    public Boolean delete(Long pk) throws Exception {
        Highlight highlight = getById(pk);
        highlight.setDeleted(1);
        save(highlight);
        return true;
    }

    @Override
    public List<Highlight> getAll() throws Exception {
        return highlightRepository.findAll();
    }

    @Override
    public Page<Highlight> getPageable(String text, Pageable pageable) throws Exception {
        return highlightRepository.getPageable(text, pageable);
    }

    @Override
    public Page<Highlight> getPageableActive(Pageable pageable) throws Exception {
        return highlightRepository.getPageableActive(pageable);
    }

    @Override
    public List<Highlight> getPublishedList() throws Exception {
        return highlightRepository.getActivePublishedList();
    }

    @Override
    public Highlight saveFromForm(Long id, String question, String answer, Integer displayOrder, String status)
            throws Exception {
        Highlight highlight;
        if (id != null) {
            highlight = getById(id);
        } else {
            highlight = new Highlight();
            highlight.setDeleted(0);
        }

        highlight.setQuestion(question);
        highlight.setAnswer(answer);
        highlight.setDisplayOrder(displayOrder != null ? displayOrder : 999);
        highlight.setStatus((status == null || status.isBlank()) ? "PUBLISHED" : status);

        return save(highlight);
    }
}
