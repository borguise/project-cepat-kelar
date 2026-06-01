package com.project.cepat.kelar.service.backoffice;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import com.project.cepat.kelar.common.service.CommonService;
import com.project.cepat.kelar.jpa.model.Voting;

public interface VotingService extends CommonService<Voting, Long> {

    Page<Voting> getPageable(String text, Pageable pageable) throws Exception;

    Page<Voting> getPageableActive(Pageable pageable) throws Exception;

    Voting saveFromForm(Long id, String name, String startDate, String endDate, String title, String description,
            String status) throws Exception;
}
