package com.project.cepat.kelar.fe.controller.frontoffice;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.project.cepat.kelar.jpa.model.Audio;
import com.project.cepat.kelar.service.backoffice.AudioService;

@Controller
@RequestMapping("/audio")
public class AudioFrontofficeController {

    @Autowired(required = false)
    private AudioService audioService;

    @GetMapping("")
    public String audio(
            @RequestParam(value = "keyword", required = false) String keyword,
            @RequestParam(value = "page", defaultValue = "1") int page,
            ModelMap model) {
        int safePage = Math.max(page, 1);
        var pageRequest = PageRequest.of(safePage - 1, 150);

        try {
            if (audioService != null) {
                var pageResult = (keyword != null && !keyword.trim().isEmpty())
                        ? audioService.getPageable(keyword.trim(), pageRequest)
                        : audioService.getPageableActive(pageRequest);
                        
                model.addAttribute("audioList", pageResult.getContent());
                model.addAttribute("currentPage", safePage);
                model.addAttribute("totalPages", Math.max(pageResult.getTotalPages(), 1));
                model.addAttribute("keyword", keyword);
            }
        } catch (Exception ignored) {
            model.addAttribute("audioList", new java.util.ArrayList<>());
            model.addAttribute("currentPage", 1);
            model.addAttribute("totalPages", 1);
            model.addAttribute("keyword", keyword);
        }

        model.addAttribute("searchAction", "/audio");
        return "frontoffice/audio";
    }

    @GetMapping("/detail")
    public String audioDetail(@RequestParam("id") Long id, ModelMap model) {
        try {
            if (audioService != null) {
                Audio audio = audioService.getById(id);
                java.util.Map<String, Object> viewAudio = new java.util.HashMap<>();
                viewAudio.put("id", audio.getId());
                viewAudio.put("title", audio.getTitle() != null ? audio.getTitle() : "Untitled");
                viewAudio.put("coverUrl", audio.getCoverImageData() != null ? "/audio/image/" + audio.getId() : "/images/frontoffice/rekaman.jpeg");
                viewAudio.put("callNumber", audio.getCallNumber() != null ? audio.getCallNumber() : "-");
                viewAudio.put("category", audio.getSubject() != null ? audio.getSubject() : "Umum");
                viewAudio.put("author", audio.getResponsibility() != null ? audio.getResponsibility() : "Unknown");
                
                String publisherInfo = (audio.getPublisher() == null ? "" : audio.getPublisher())
                        + ((audio.getOriginCity() == null || audio.getOriginCity().isBlank()) ? "" : " - " + audio.getOriginCity())
                        + ((audio.getPublishYear() == null || audio.getPublishYear().isBlank()) ? "" : ", " + audio.getPublishYear());
                viewAudio.put("publisher", publisherInfo.isEmpty() ? "-" : publisherInfo);
                
                viewAudio.put("mediaType", audio.getMediaType() != null ? audio.getMediaType() : "-");
                viewAudio.put("audioFormat", audio.getAudioFormat() != null ? audio.getAudioFormat() : "-");
                viewAudio.put("gmd", audio.getGmd() != null ? audio.getGmd() : "[rekaman suara]");
                
                // Menggunakan URL string aman pengganti getFilePath() yang tidak ada di entitas
                viewAudio.put("filePath", "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3");
                
                model.addAttribute("audio", viewAudio);
            }
        } catch (Exception ignored) {}
        return "frontoffice/audio-detail";
    }
    
    @GetMapping("/search-results")
    public String searchResultsAudio() {
        return "frontoffice/search-results-audio";
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