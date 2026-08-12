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

import com.project.cepat.kelar.jpa.model.Audio;
import com.project.cepat.kelar.jpa.repository.AudioRepository;
import com.project.cepat.kelar.service.backoffice.AudioService;

import lombok.extern.log4j.Log4j2;

@Service
@Transactional
@Log4j2
public class AudioServiceImpl implements AudioService {

    @Autowired
    private AudioRepository audioRepository;

    @Override
    public Long getNum() {
        return audioRepository.count();
    }

    @Override
    public Audio save(Audio entity) throws Exception {
        return audioRepository.saveAndFlush(entity);
    }

    @Override
    public Audio getById(Long pk) throws Exception {
        Optional<Audio> model = audioRepository.findById(pk);
        if (model.isPresent()) {
            return model.get();
        }
        throw new Exception("Rekaman audio tidak ditemukan dengan ID: " + pk);
    }

    @Override
    public Boolean delete(Long pk) throws Exception {
        Audio model = getById(pk);
        model.setDeleted(1);
        save(model);
        return true;
    }

    @Override
    public List<Audio> getAll() throws Exception {
        return audioRepository.findAll();
    }

    @Override
    public Page<Audio> getPageable(String text, Pageable pageable) throws Exception {
        return audioRepository.getPageable(text, pageable);
    }

    @Override
    public Page<Audio> getPageableActive(Pageable pageable) throws Exception {
        return audioRepository.getPageableActive(pageable);
    }

    @Override
    public Page<Audio> getPageablePublished(Pageable pageable) throws Exception {
        return audioRepository.getPageablePublished(pageable);
    }

    @Override
    public Page<Audio> searchPublished(String text, Pageable pageable) throws Exception {
        return audioRepository.searchPublished(text, pageable);
    }

    @Override
    public Audio saveFromForm(Long id, String callNumber, String subject, String title, String responsibility,
            String gmd, String publisher, String originCity, String publishYear, String mediaType, String audioFormat,
            String status, MultipartFile coverFile, MultipartFile audioFile) throws Exception {
        Audio model;
        if (id != null) {
            model = getById(id);
        } else {
            model = new Audio();
            model.setDeleted(0);
        }

        model.setCallNumber(callNumber);
        model.setSubject(subject);
        model.setTitle(title);
        model.setResponsibility(responsibility);
        model.setGmd(gmd);
        model.setPublisher(publisher);
        model.setOriginCity(originCity);
        model.setPublishYear(publishYear);
        model.setMediaType(mediaType);
        model.setAudioFormat(audioFormat);
        model.setStatus((status == null || status.isBlank()) ? "PUBLISHED" : status);

        if (coverFile != null && !coverFile.isEmpty()) {
            model.setCoverImage(coverFile.getOriginalFilename());
            try {
                model.setCoverImageData(coverFile.getBytes());
            } catch (IOException e) {
                log.warn("Failed to process audio cover file: {}", e.getMessage());
            }
        }

        if (audioFile != null && !audioFile.isEmpty()) {
            model.setAudioFileName(audioFile.getOriginalFilename());
            try {
                model.setAudioFileData(audioFile.getBytes());
            } catch (IOException e) {
                log.warn("Failed to process audio data file: {}", e.getMessage());
            }
        }

        return save(model);
    }
}
