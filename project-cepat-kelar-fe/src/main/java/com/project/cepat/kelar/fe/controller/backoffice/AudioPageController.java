package com.project.cepat.kelar.fe.controller.backoffice;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.project.cepat.kelar.jpa.model.Audio;
import com.project.cepat.kelar.service.backoffice.AudioService;

@Controller
@RequestMapping("/admin/audio")
public class AudioPageController {

    @Autowired(required = false)
    private com.project.cepat.kelar.service.backoffice.AdminService adminService;

    @Autowired(required = false)
    private AudioService audioService;

    @GetMapping("")
    public String audio(@RequestParam(value = "page", defaultValue = "0") int page,
            @RequestParam(value = "size", defaultValue = "10") int size,
            ModelMap model) {
        if (adminService != null) {
            Authentication auth = SecurityContextHolder.getContext().getAuthentication();
            model.addAttribute("adminName", adminService.resolveAdminName(auth));
        }

        if (audioService != null) {
            try {
                Pageable pageable = PageRequest.of(page, size);
                Page<Audio> audioPage = audioService.getPageableActive(pageable);
                model.addAttribute("audioRecordings", audioPage.getContent());
                model.addAttribute("currentPage", page);
                model.addAttribute("totalPages", audioPage.getTotalPages());
                model.addAttribute("totalItems", audioPage.getTotalElements());
            } catch (Exception e) {
                model.addAttribute("errorMessage", "Gagal memuat daftar audio: " + e.getMessage());
            }
        }

        return "backoffice/admin-audio";
    }

    @GetMapping({"/new", "/edit/{id}"})
    public String audioEditor(@PathVariable(required = false) Long id, ModelMap model) {
        if (adminService != null) {
            Authentication auth = SecurityContextHolder.getContext().getAuthentication();
            model.addAttribute("adminName", adminService.resolveAdminName(auth));
        }

        if (id != null && audioService != null) {
            try {
                Audio audio = audioService.getById(id);
                model.addAttribute("audio", audio);
                if (audio.getCoverImageData() != null && audio.getCoverImageData().length > 0) {
                    model.addAttribute("coverUrl", "/admin/audio/image/" + id);
                }
            } catch (Exception e) {
                model.addAttribute("errorMessage", "Gagal memuat data audio: " + e.getMessage());
            }
        }

        model.addAttribute("audioId", id);
        return "backoffice/admin-audio-editor";
    }
}
