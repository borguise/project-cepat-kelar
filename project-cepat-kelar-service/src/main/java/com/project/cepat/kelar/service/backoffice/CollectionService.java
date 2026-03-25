package com.project.cepat.kelar.service.backoffice;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.web.multipart.MultipartFile;

import com.project.cepat.kelar.common.service.CommonService;
import com.project.cepat.kelar.jpa.model.Collection;

public interface CollectionService extends CommonService<Collection, Long> {

    Page<Collection> getPageable(String text, Pageable pageable) throws Exception;

    Page<Collection> getPageableActive(Pageable pageable) throws Exception;

    Page<Collection> getPageablePublished(Pageable pageable) throws Exception;

    Page<Collection> searchPublished(String text, Pageable pageable) throws Exception;

    Collection saveFromForm(Long id, String subject, String title, String author, String publisher, String publishCity,
            String publishYear, String physicalDescription, String isbn, Integer stock, String callNumber, String status,
            MultipartFile coverFile) throws Exception;
}
