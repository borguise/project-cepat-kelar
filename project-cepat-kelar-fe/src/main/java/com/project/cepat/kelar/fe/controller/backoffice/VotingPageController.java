package com.project.cepat.kelar.fe.controller.backoffice;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
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
import com.project.cepat.kelar.jpa.model.VotingEntry;
import com.project.cepat.kelar.service.backoffice.AdminService;
import com.project.cepat.kelar.service.backoffice.VotingService;

@Controller
@RequestMapping("/admin/voting")
public class VotingPageController {

    @Autowired(required = false)
    private AdminService adminService;

    @Autowired(required = false)
    private VotingService votingService;

    @GetMapping("")
    public String voting(@RequestParam(value = "page", defaultValue = "0") int page,
            @RequestParam(value = "size", defaultValue = "10") int size,
            @RequestParam(value = "query", required = false) String query,
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
                    // Filter pencarian sederhana jika ada parameter query
                    if (query != null && !query.isBlank()) {
                        String voteName = vote.getName() != null ? vote.getName().toLowerCase() : "";
                        if (!voteName.contains(query.trim().toLowerCase())) {
                            continue;
                        }
                    }

                    Map<String, Object> view = new HashMap<>();
                    view.put("id", vote.getId());
                    view.put("name", (vote.getName() == null || vote.getName().isBlank()) ? "Tanpa Nama (Draft)" : vote.getName());
                    view.put("periodStart", vote.getStartDate());
                    view.put("periodEnd", vote.getEndDate());
                    
                    // Logika menghitung total suara dari database
                    long totalVotes = 0;
                    List<VotingEntry> entries = votingService.getEntriesByVotingId(vote.getId());
                    for (VotingEntry entry : entries) {
                        if (entry.getVoteCount() != null) {
                            totalVotes += entry.getVoteCount();
                        }
                    }
                    view.put("participantCount", totalVotes);
                    
                    view.put("status", vote.getStatus() == null ? "Draft" : vote.getStatus());
                    votingList.add(view);
                }
                model.addAttribute("votingList", votingList);
                model.addAttribute("query", query != null ? query : "");
            } catch (Exception e) {
                model.addAttribute("errorMessage", "Gagal memuat data: " + e.getMessage());
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

        if (votingService != null) {
            try {
                Voting voting;
                if (id == null || id == 0) {
                    Voting newDraft = new Voting();
                    newDraft.setName("");
                    newDraft.setStatus("Draft");
                    newDraft.setDeleted(0);
                    voting = votingService.save(newDraft);
                    return "redirect:/admin/voting/edit/" + voting.getId();
                } else {
                    voting = votingService.getById(id);
                }
                model.addAttribute("voting", voting);
                model.addAttribute("entries", votingService.getEntriesByVotingId(voting.getId()));
                model.addAttribute("votingId", voting.getId());
            } catch (Exception e) {
                model.addAttribute("errorMessage", "Gagal memuat data: " + e.getMessage());
            }
        }
        return "backoffice/admin-voting-editor";
    }

    @PostMapping("/save")
    public String saveVoting(@RequestParam(value = "id", required = false) Long id, 
                               @RequestParam(value = "name", required = false) String name,
                               @RequestParam(value = "startDate", required = false) String startDate,
                               @RequestParam(value = "endDate", required = false) String endDate,
                               @RequestParam(value = "status", required = false) String status,
                               RedirectAttributes redirectAttributes) {
        try {
            votingService.saveFromForm(id, name, startDate, endDate, null, null, status);
            redirectAttributes.addFlashAttribute("successMessage", "Data berhasil disimpan.");
            
            // Jika statusnya Draft, tetap di halaman editor
            if (status != null && status.equalsIgnoreCase("Draft")) {
                return "redirect:/admin/voting/edit/" + id;
            }
            
            // Jika dipublikasikan/aktif, kembali ke halaman daftar utama
            return "redirect:/admin/voting";
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", "Gagal menyimpan: " + e.getMessage());
            return "redirect:/admin/voting/edit/" + id;
        }
    }

    @PostMapping("/entry/save")
    public String saveEntry(@RequestParam("votingId") Long votingId, @RequestParam("name") String name, @RequestParam("summary") String summary, RedirectAttributes ra) {
        try {
            votingService.saveEntry(votingId, name, summary, null);
        } catch (Exception e) { ra.addFlashAttribute("errorMessage", "Gagal: " + e.getMessage()); }
        return "redirect:/admin/voting/edit/" + votingId;
    }

    @PostMapping("/entry/delete/{id}")
    public String deleteEntry(@PathVariable Long id, @RequestParam("votingId") Long votingId, RedirectAttributes ra) {
        try { votingService.deleteEntry(id); } catch (Exception e) { ra.addFlashAttribute("errorMessage", "Gagal: " + e.getMessage()); }
        return "redirect:/admin/voting/edit/" + votingId;
    }

    // --- Rute Baru: Melihat Hasil Suara Masuk ---
    @GetMapping("/result/{id}")
    public String viewVotingResult(@PathVariable Long id, ModelMap model, RedirectAttributes ra) {
        if (adminService != null) {
            Authentication auth = SecurityContextHolder.getContext().getAuthentication();
            model.addAttribute("adminName", adminService.resolveAdminName(auth));
        }

        if (votingService != null) {
            try {
                Voting voting = votingService.getById(id);
                if (voting == null) {
                    ra.addFlashAttribute("errorMessage", "Data voting tidak ditemukan.");
                    return "redirect:/admin/voting";
                }
                
                List<VotingEntry> entries = votingService.getEntriesByVotingId(voting.getId());
                long totalVotes = 0;
                for (VotingEntry entry : entries) {
                    if (entry.getVoteCount() != null) {
                        totalVotes += entry.getVoteCount();
                    }
                }
                
                model.addAttribute("voting", voting);
                model.addAttribute("entries", entries);
                model.addAttribute("totalVotes", totalVotes);
            } catch (Exception e) {
                ra.addFlashAttribute("errorMessage", "Gagal memuat hasil voting: " + e.getMessage());
                return "redirect:/admin/voting";
            }
        }
        return "backoffice/admin-voting-result";
    }

    // --- Perbaikan: Hapus data kandidat anak terlebih dahulu sebelum data induk ---
    @PostMapping("/delete/{id}")
    public String deleteVoting(@PathVariable Long id, RedirectAttributes ra) {
        try {
            List<VotingEntry> entries = votingService.getEntriesByVotingId(id);
            if (entries != null) {
                for (VotingEntry entry : entries) {
                    votingService.deleteEntry(entry.getId());
                }
            }
            
            votingService.delete(id);
            ra.addFlashAttribute("successMessage", "Data pemilihan beserta seluruh pilihannya berhasil dihapus.");
        } catch (Exception e) { 
            ra.addFlashAttribute("errorMessage", "Gagal menghapus: " + e.getMessage()); 
        }
        return "redirect:/admin/voting";
    }
}