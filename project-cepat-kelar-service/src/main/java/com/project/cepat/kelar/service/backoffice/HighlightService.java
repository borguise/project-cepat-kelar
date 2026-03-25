package com.project.cepat.kelar.service.backoffice;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import com.project.cepat.kelar.common.service.CommonService;
import com.project.cepat.kelar.jpa.model.Highlight;

public interface HighlightService extends CommonService<Highlight, Long> {

    Page<Highlight> getPageable(String text, Pageable pageable) throws Exception;

    Page<Highlight> getPageableActive(Pageable pageable) throws Exception;

    List<Highlight> getPublishedList() throws Exception;

    Highlight saveFromForm(Long id, String question, String answer, Integer displayOrder, String status) throws Exception;
}
