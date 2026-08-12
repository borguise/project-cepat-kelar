package com.project.cepat.kelar.fe.controller.backoffice;

import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.Base64;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.project.cepat.kelar.common.controller.BaseController;
import com.project.cepat.kelar.jpa.model.Audio;
import com.project.cepat.kelar.service.backoffice.AudioService;

@Controller
@RequestMapping("/admin/audio")
public class AudioController extends BaseController {

    private static final Logger logger = LoggerFactory.getLogger(AudioController.class);

    @Autowired(required = false)
    private AudioService audioService;

    @Override
    public String pageTitle() {
        return "Audio Management";
    }

    @PostMapping("/save")
    public String saveAudio(
            @RequestParam(value = "id", required = false) String idRaw,
            @RequestParam(value = "callNumber", required = false) String callNumber,
            @RequestParam(value = "subject", required = false) String subject,
            @RequestParam(value = "title", required = false) String title,
            @RequestParam(value = "responsibility", required = false) String responsibility,
            @RequestParam(value = "gmd", required = false) String gmd,
            @RequestParam(value = "publisher", required = false) String publisher,
            @RequestParam(value = "originCity", required = false) String originCity,
            @RequestParam(value = "publishYear", required = false) String publishYear,
            @RequestParam(value = "mediaType", required = false) String mediaType,
            @RequestParam(value = "audioFormat", required = false) String audioFormat,
            @RequestParam(value = "status", required = false) String status,
            @RequestParam(value = "coverImageBase64", required = false) String coverImageBase64,
            @RequestParam(value = "coverFileName", required = false) String coverFileName,
            @RequestParam(value = "audioFile", required = false) MultipartFile audioFile, // Ditangkap agar tidak Error 500
            RedirectAttributes redirectAttributes) {
        Long parsedId = null;
        try {
            parsedId = parseLongOrNull(idRaw, "id");

            if (title == null || title.isBlank()) {
                redirectAttributes.addFlashAttribute("errorMessage", "Judul rekaman audio wajib diisi.");
                if (parsedId != null) {
                    return "redirect:/admin/audio/edit/" + parsedId;
                }
                return "redirect:/admin/audio/new";
            }

            if (audioService == null) {
                redirectAttributes.addFlashAttribute("errorMessage", "Service audio tidak tersedia");
                return "redirect:/admin/audio";
            }

            logger.info("Saving audio: id={}, title='{}', hasBase64Cover={}, hasAudioFile={}",
                    parsedId,
                    title,
                    coverImageBase64 != null && !coverImageBase64.isBlank(),
                    audioFile != null && !audioFile.isEmpty());

            Audio saved = audioService.saveFromForm(parsedId, callNumber, subject, title, responsibility, gmd,
                    publisher, originCity, publishYear, mediaType, audioFormat, status, null);

            // 1. Proses Cover Gambar
            if (coverImageBase64 != null && !coverImageBase64.isBlank()) {
                try {
                    byte[] imageBytes = Base64.getDecoder().decode(coverImageBase64);
                    if (imageBytes.length > 0) {
                        saved.setCoverImage((coverFileName == null || coverFileName.isBlank()) ? "cover-upload.jpg" : coverFileName);
                        saved.setCoverImageData(imageBytes);
                        saved = audioService.save(saved);
                    }
                } catch (IllegalArgumentException decodeError) {
                    logger.warn("Invalid base64 image payload for audio {}: {}", saved.getId(), decodeError.getMessage());
                }
            }

            // 2. Proses Simpan File Fisik Audio (.mp3 / .wav) ke folder static/audio/
            if (audioFile != null && !audioFile.isEmpty()) {
                try {
                    String fileName = "audio_" + saved.getId() + ".mp3";
                    Path uploadPath = Paths.get("src/main/resources/static/audio/");
                    
                    if (!Files.exists(uploadPath)) {
                        Files.createDirectories(uploadPath);
                    }
                    
                    Path filePath = uploadPath.resolve(fileName);
                    Files.copy(audioFile.getInputStream(), filePath, StandardCopyOption.REPLACE_EXISTING);
                    logger.info("File audio berhasil disimpan ke: {}", filePath.toString());
                } catch (Exception fileEx) {
                    logger.error("Gagal menyimpan file fisik audio: {}", fileEx.getMessage());
                }
            }

            logger.info("Audio saved with ID: {}", saved.getId());
            redirectAttributes.addFlashAttribute("successMessage", "Rekaman audio berhasil disimpan!");
            return "redirect:/admin/audio";
        } catch (Exception e) {
            logger.error("Error saving audio: {}", e.getMessage(), e);
            String detail = (e.getMessage() == null || e.getMessage().isBlank()) ? "Unknown error" : e.getMessage();
            redirectAttributes.addFlashAttribute("errorMessage", "Gagal menyimpan rekaman audio: " + detail);
            if (parsedId != null) {
                return "redirect:/admin/audio/edit/" + parsedId;
            }
            return "redirect:/admin/audio/new";
        } catch (Throwable t) {
            logger.error("Unexpected error saving audio", t);
            String detail = (t.getMessage() == null || t.getMessage().isBlank()) ? "Unexpected error" : t.getMessage();
            redirectAttributes.addFlashAttribute("errorMessage", "Terjadi kesalahan saat menyimpan rekaman audio: " + detail);
            if (parsedId != null) {
                return "redirect:/admin/audio/edit/" + parsedId;
            }
            return "redirect:/admin/audio/new";
        }
    }

    private Long parseLongOrNull(String rawValue, String fieldName) {
        if (rawValue == null || rawValue.isBlank()) {
            return null;
        }
        try {
            return Long.valueOf(rawValue.trim());
        } catch (NumberFormatException e) {
            throw new IllegalArgumentException("Nilai " + fieldName + " tidak valid");
        }
    }

    @GetMapping("/delete/{id}")
    public String deleteAudio(@PathVariable Long id, RedirectAttributes redirectAttributes) {
        try {
            if (audioService != null) {
                audioService.delete(id);
                redirectAttributes.addFlashAttribute("successMessage", "Rekaman audio berhasil dihapus!");
            } else {
                redirectAttributes.addFlashAttribute("errorMessage", "Service audio tidak tersedia");
            }
        } catch (Exception e) {
            logger.error("Error deleting audio: {}", e.getMessage(), e);
            redirectAttributes.addFlashAttribute("errorMessage", "Gagal menghapus rekaman audio: " + e.getMessage());
        }
        return "redirect:/admin/audio";
    }

    @GetMapping("/image/{id}")
    public ResponseEntity<byte[]> getAudioImage(@PathVariable Long id) {
        try {
            if (audioService != null) {
                Audio audio = audioService.getById(id);
                if (audio != null && audio.getCoverImageData() != null && audio.getCoverImageData().length > 0) {
                    HttpHeaders headers = new HttpHeaders();
                    headers.setContentType(resolveMediaType(audio.getCoverImage()));
                    headers.setContentLength(audio.getCoverImageData().length);
                    return new ResponseEntity<>(audio.getCoverImageData(), headers, HttpStatus.OK);
                }
            }
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        } catch (Exception e) {
            logger.error("Error retrieving audio image: {}", e.getMessage(), e);
            return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    private MediaType resolveMediaType(String fileName) {
        if (fileName == null) {
            return MediaType.APPLICATION_OCTET_STREAM;
        }
        String lower = fileName.toLowerCase();
        if (lower.endsWith(".png")) {
            return MediaType.IMAGE_PNG;
        }
        if (lower.endsWith(".gif")) {
            return MediaType.IMAGE_GIF;
        }
        if (lower.endsWith(".webp")) {
            return MediaType.parseMediaType("image/webp");
        }
        return MediaType.IMAGE_JPEG;
    }
}