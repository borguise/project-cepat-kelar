package com.project.cepat.kelar.fe.controller.backoffice;

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
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.project.cepat.kelar.common.controller.BaseController;
import com.project.cepat.kelar.jpa.model.Audio;
import com.project.cepat.kelar.service.backoffice.AudioService;

import jakarta.servlet.http.HttpServletRequest;

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
            HttpServletRequest request,
            RedirectAttributes redirectAttributes) {
        Long parsedId = null;
        try {
            parsedId = parseLongOrNull(idRaw, "id");
            MultipartFile coverFile = resolveCoverFile(request);

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

            Audio saved = audioService.saveFromForm(parsedId, callNumber, subject, title, responsibility, gmd,
                    publisher, originCity, publishYear, mediaType, audioFormat, status, coverFile);
            logger.info("Audio saved with ID: {}", saved.getId());
            redirectAttributes.addFlashAttribute("successMessage", "Rekaman audio berhasil disimpan!");
            return "redirect:/admin/audio";
        } catch (Exception e) {
            logger.error("Error saving audio: {}", e.getMessage(), e);
            redirectAttributes.addFlashAttribute("errorMessage", "Gagal menyimpan rekaman audio: " + e.getMessage());
            if (parsedId != null) {
                return "redirect:/admin/audio/edit/" + parsedId;
            }
            return "redirect:/admin/audio/new";
        } catch (Throwable t) {
            logger.error("Unexpected error saving audio", t);
            redirectAttributes.addFlashAttribute("errorMessage", "Terjadi kesalahan saat menyimpan rekaman audio.");
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

    private MultipartFile resolveCoverFile(HttpServletRequest request) {
        if (request instanceof MultipartHttpServletRequest multipartRequest) {
            return multipartRequest.getFile("coverFile");
        }
        return null;
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
                if (audio != null && audio.getCoverImageData() != null) {
                    HttpHeaders headers = new HttpHeaders();
                    headers.setContentType(MediaType.IMAGE_JPEG);
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
}
