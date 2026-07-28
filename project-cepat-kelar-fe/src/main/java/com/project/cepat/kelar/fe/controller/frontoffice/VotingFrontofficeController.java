package com.project.cepat.kelar.fe.controller.frontoffice;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.project.cepat.kelar.jpa.model.Voting;
import com.project.cepat.kelar.service.backoffice.VotingService;

import jakarta.servlet.http.HttpServletRequest;

@Controller
@RequestMapping("/voting")
public class VotingFrontofficeController {

    @Autowired
    private VotingService votingService;

    // Menampilkan halaman utama voting untuk USER
    @GetMapping("")
    public String index(ModelMap model) {
        Voting activeVoting = votingService.getActiveVoting();
        if (activeVoting != null) {
            model.addAttribute("voting", activeVoting);
            model.addAttribute("participants", votingService.getEntriesByVotingId(activeVoting.getId()));
        }
        return "frontoffice/voting";
    }

    // Menerima input vote dari tombol hati via AJAX/Fetch
    @PostMapping("/submit")
    @ResponseBody
    public ResponseEntity<?> submitVote(
            @RequestParam("entryId") Long entryId,
            @RequestParam("votingId") Long votingId,
            HttpServletRequest request) {
        
        String ip = request.getHeader("X-FORWARDED-FOR");
        if (ip == null || ip.isEmpty()) {
            ip = request.getRemoteAddr();
        }

        boolean success = votingService.submitVote(entryId, votingId, ip);

        if (success) {
            return ResponseEntity.ok().body("Suara kamu berhasil tercatat!");
        } else {
            return ResponseEntity.badRequest().body("Maaf, kamu sudah memilih sebelumnya.");
        }
    }
}