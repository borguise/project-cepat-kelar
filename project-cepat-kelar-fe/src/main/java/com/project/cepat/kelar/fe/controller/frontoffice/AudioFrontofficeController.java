package com.project.cepat.kelar.fe.controller.frontoffice;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@RequestMapping("/audio")
public class AudioFrontofficeController {

    @Autowired(required = false)
    private com.project.cepat.kelar.service.backoffice.AudioService audioService;

    @GetMapping("")
    public String audio(
            @RequestParam(value = "keyword", required = false) String keyword,
            @RequestParam(value = "page", defaultValue = "1") int page,
            ModelMap model) {
        int safePage = Math.max(page, 1);
        var pageRequest = PageRequest.of(safePage - 1, 9);

        try {
            if (audioService != null) {
                var pageResult = (keyword != null && !keyword.trim().isEmpty())
                        ? audioService.searchPublished(keyword.trim(), pageRequest)
                        : audioService.getPageablePublished(pageRequest);
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
                var audio = audioService.getById(id);
                java.util.Map<String, Object> viewAudio = new java.util.HashMap<>();
                viewAudio.put("id", audio.getId());
                viewAudio.put("title", audio.getTitle() != null ? audio.getTitle() : "Untitled");
                viewAudio.put("coverUrl", audio.getCoverImageData() != null ? "/admin/audio/image/" + audio.getId() : "/images/frontoffice/rekaman.jpeg");
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
                viewAudio.put("filePath", "#"); // Placeholder untuk audio file path
                model.addAttribute("audio", viewAudio);
            }
        } catch (Exception ignored) {
            // Keep fallback values from template when data is unavailable.
        }
        return "frontoffice/audio-detail";
    }
    
    @GetMapping("/search-results")
    public String searchResultsAudio() {
        return "frontoffice/search-results-audio";
    }
}
