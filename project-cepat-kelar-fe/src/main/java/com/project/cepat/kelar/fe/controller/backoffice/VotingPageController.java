package com.project.cepat.kelar.fe.controller.backoffice;

import java.util.ArrayList;
import java.util.Base64;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.project.cepat.kelar.jpa.model.Voting;
import com.project.cepat.kelar.service.backoffice.VotingService;

@Controller
@RequestMapping("/admin/voting")
public class VotingPageController {

    @Autowired(required = false)
    private com.project.cepat.kelar.service.backoffice.AdminService adminService;

    @Autowired(required = false)
    private VotingService votingService;

    @GetMapping("")
    public String voting(@RequestParam(value = "page", defaultValue = "0") int page,
            @RequestParam(value = "size", defaultValue = "10") int size,
            ModelMap model) {
        if (adminService != null) {
            Authentication auth = SecurityContextHolder.getContext().getAuthentication();
            model.addAttribute("adminName", adminService.resolveAdminName(auth));
        }

        if (votingService != null) {
            try {
                Page<Voting> votingPage = votingService.getPageableActive(PageRequest.of(page, size));
                List<Map<String, Object>> votingList = new ArrayList<>();
                for (Voting vote : votingPage.getContent()) {
                    Map<String, Object> view = new HashMap<>();
                    view.put("id", vote.getId());
                    view.put("name", vote.getName());
                    view.put("periodStart", vote.getStartDate());
                    view.put("periodEnd", vote.getEndDate());
                    view.put("participantCount", 0);
                    view.put("status", vote.getStatus() == null ? "Aktif" : vote.getStatus());
                    votingList.add(view);
                }
                model.addAttribute("votingList", votingList);
            } catch (Exception e) {
                model.addAttribute("errorMessage", "Gagal memuat data voting: " + e.getMessage());
            }
        }
        return "backoffice/admin-voting";
    }

    @GetMapping("/search")
    public String searchVoting(@RequestParam(value = "query", required = false) String query,
            @RequestParam(value = "page", defaultValue = "0") int page,
            @RequestParam(value = "size", defaultValue = "10") int size,
            ModelMap model) {
        if (adminService != null) {
            Authentication auth = SecurityContextHolder.getContext().getAuthentication();
            model.addAttribute("adminName", adminService.resolveAdminName(auth));
        }

        if (votingService != null) {
            try {
                String text = query == null ? "" : query.trim();
                Page<Voting> votingPage = text.isEmpty()
                        ? votingService.getPageableActive(PageRequest.of(page, size))
                        : votingService.getPageable(text, PageRequest.of(page, size));

                List<Map<String, Object>> votingList = new ArrayList<>();
                for (Voting vote : votingPage.getContent()) {
                    Map<String, Object> view = new HashMap<>();
                    view.put("id", vote.getId());
                    view.put("name", vote.getName());
                    view.put("periodStart", vote.getStartDate());
                    view.put("periodEnd", vote.getEndDate());
                    view.put("participantCount", 0);
                    view.put("status", vote.getStatus() == null ? "Aktif" : vote.getStatus());
                    votingList.add(view);
                }
                model.addAttribute("votingList", votingList);
            } catch (Exception e) {
                model.addAttribute("errorMessage", "Gagal mencari data voting: " + e.getMessage());
            }
        }
        return "backoffice/admin-voting";
    }

    @GetMapping({"/new", "/edit/{id}"})
    public String votingEditor(@PathVariable(required = false) Long id, ModelMap model) {
        if (adminService != null) {
            Authentication auth = SecurityContextHolder.getContext().getAuthentication();
            model.addAttribute("adminName", adminService.resolveAdminName(auth));
        }

        if (id != null && votingService != null) {
            try {
                Voting voting = votingService.getById(id);
                model.addAttribute("voting", voting);
                if (voting.getPosterImageData() != null && voting.getPosterImageData().length > 0) {
                    model.addAttribute("posterUrl", "/admin/voting/image/" + id);
                }
            } catch (Exception e) {
                model.addAttribute("errorMessage", "Gagal memuat data voting: " + e.getMessage());
            }
        }

        model.addAttribute("votingId", id);
        return "backoffice/admin-voting-editor";
    }

    @GetMapping("/result/{id}")
    public String votingResult(@PathVariable Long id, RedirectAttributes redirectAttributes) {
        redirectAttributes.addFlashAttribute("successMessage", "Halaman hasil belum tersedia, diarahkan ke halaman edit voting.");
        return "redirect:/admin/voting/edit/" + id;
    }

    @PostMapping("/save")
    public String saveVoting(
            @RequestParam(value = "id", required = false) Long id,
            @RequestParam(value = "name", required = false) String name,
            @RequestParam(value = "startDate", required = false) String startDate,
            @RequestParam(value = "endDate", required = false) String endDate,
            @RequestParam(value = "title", required = false) String title,
            @RequestParam(value = "description", required = false) String description,
            @RequestParam(value = "status", required = false) String status,
            @RequestParam(value = "posterImageBase64", required = false) String posterImageBase64,
            @RequestParam(value = "posterFileName", required = false) String posterFileName,
            RedirectAttributes redirectAttributes) {
        if (name == null || name.isBlank()) {
            redirectAttributes.addFlashAttribute("errorMessage", "Nama kegiatan pemilihan wajib diisi.");
            if (id != null) {
                return "redirect:/admin/voting/edit/" + id;
            }
            return "redirect:/admin/voting/new";
        }

        if (votingService == null) {
            redirectAttributes.addFlashAttribute("errorMessage", "Service voting tidak tersedia.");
            return "redirect:/admin/voting";
        }

        try {
            Voting saved = votingService.saveFromForm(id, name, startDate, endDate, title, description, status);

            if (posterImageBase64 != null && !posterImageBase64.isBlank()) {
                byte[] imageBytes = Base64.getDecoder().decode(posterImageBase64);
                if (imageBytes.length > 0) {
                    saved.setPosterImage((posterFileName == null || posterFileName.isBlank()) ? "poster-upload.jpg" : posterFileName);
                    saved.setPosterImageData(imageBytes);
                    votingService.save(saved);
                }
            }

            redirectAttributes.addFlashAttribute("successMessage", "Data voting berhasil disimpan.");
            return "redirect:/admin/voting";
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", "Gagal menyimpan voting: " + e.getMessage());
            if (id != null) {
                return "redirect:/admin/voting/edit/" + id;
            }
            return "redirect:/admin/voting/new";
        }
    }

    @PostMapping("/delete/{id}")
    public String deleteVoting(@PathVariable Long id, RedirectAttributes redirectAttributes) {
        try {
            if (votingService != null) {
                votingService.delete(id);
                redirectAttributes.addFlashAttribute("successMessage", "Voting berhasil dihapus.");
            } else {
                redirectAttributes.addFlashAttribute("errorMessage", "Service voting tidak tersedia.");
            }
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", "Gagal menghapus voting: " + e.getMessage());
        }
        return "redirect:/admin/voting";
    }

    @GetMapping("/image/{id}")
    public ResponseEntity<byte[]> getVotingImage(@PathVariable Long id) {
        try {
            if (votingService != null) {
                Voting voting = votingService.getById(id);
                if (voting != null && voting.getPosterImageData() != null && voting.getPosterImageData().length > 0) {
                    HttpHeaders headers = new HttpHeaders();
                    headers.setContentType(resolveMediaType(voting.getPosterImage()));
                    headers.setContentLength(voting.getPosterImageData().length);
                    return new ResponseEntity<>(voting.getPosterImageData(), headers, HttpStatus.OK);
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
