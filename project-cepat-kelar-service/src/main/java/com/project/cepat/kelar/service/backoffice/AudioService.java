package com.project.cepat.kelar.service.backoffice;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.web.multipart.MultipartFile;

import com.project.cepat.kelar.common.service.CommonService;
import com.project.cepat.kelar.jpa.model.Audio;

public interface AudioService extends CommonService<Audio, Long> {

    Page<Audio> getPageable(String text, Pageable pageable) throws Exception;

    Page<Audio> getPageableActive(Pageable pageable) throws Exception;

    Page<Audio> getPageablePublished(Pageable pageable) throws Exception;

    Page<Audio> searchPublished(String text, Pageable pageable) throws Exception;

    Audio saveFromForm(Long id, String callNumber, String subject, String title, String responsibility, String gmd,
            String publisher, String originCity, String publishYear, String mediaType, String audioFormat,
            String status, MultipartFile coverFile) throws Exception;
}
