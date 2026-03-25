package com.project.cepat.kelar.service.backoffice.impl;

import java.io.IOException;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.project.cepat.kelar.jpa.model.Collection;
import com.project.cepat.kelar.jpa.repository.CollectionRepository;
import com.project.cepat.kelar.service.backoffice.CollectionService;

import lombok.extern.log4j.Log4j2;

@Service
@Transactional
@Log4j2
public class CollectionServiceImpl implements CollectionService {

    @Autowired
    private CollectionRepository collectionRepository;

    @Override
    public Long getNum() {
        return collectionRepository.count();
    }

    @Override
    public Collection save(Collection entity) throws Exception {
        return collectionRepository.saveAndFlush(entity);
    }

    @Override
    public Collection getById(Long pk) throws Exception {
        Optional<Collection> model = collectionRepository.findById(pk);
        if (model.isPresent()) {
            return model.get();
        }
        throw new Exception("Koleksi buku tidak ditemukan dengan ID: " + pk);
    }

    @Override
    public Boolean delete(Long pk) throws Exception {
        Collection model = getById(pk);
        model.setDeleted(1);
        save(model);
        return true;
    }

    @Override
    public List<Collection> getAll() throws Exception {
        return collectionRepository.findAll();
    }

    @Override
    public Page<Collection> getPageable(String text, Pageable pageable) throws Exception {
        return collectionRepository.getPageable(text, pageable);
    }

    @Override
    public Page<Collection> getPageableActive(Pageable pageable) throws Exception {
        return collectionRepository.getPageableActive(pageable);
    }

    @Override
    public Page<Collection> getPageablePublished(Pageable pageable) throws Exception {
        return collectionRepository.getPageablePublished(pageable);
    }

    @Override
    public Page<Collection> searchPublished(String text, Pageable pageable) throws Exception {
        return collectionRepository.searchPublished(text, pageable);
    }

    @Override
    public Collection saveFromForm(Long id, String subject, String title, String author, String publisher,
            String publishCity, String publishYear, String physicalDescription, String isbn, Integer stock,
            String callNumber, String status, MultipartFile coverFile) throws Exception {
        Collection model;
        if (id != null) {
            model = getById(id);
        } else {
            model = new Collection();
            model.setDeleted(0);
        }

        model.setSubject(subject);
        model.setTitle(title);
        model.setAuthor(author);
        model.setPublisher(publisher);
        model.setPublishCity(publishCity);
        model.setPublishYear(publishYear);
        model.setPhysicalDescription(physicalDescription);
        model.setIsbn(isbn);
        model.setStock(stock == null ? 0 : stock);
        model.setCallNumber(callNumber);
        model.setStatus((status == null || status.isBlank()) ? "PUBLISHED" : status);

        if (coverFile != null && !coverFile.isEmpty()) {
            model.setCoverImage(coverFile.getOriginalFilename());
            try {
                model.setCoverImageData(coverFile.getBytes());
            } catch (IOException e) {
                log.warn("Failed to process collection cover file: {}", e.getMessage());
            }
        }

        return save(model);
    }
}
