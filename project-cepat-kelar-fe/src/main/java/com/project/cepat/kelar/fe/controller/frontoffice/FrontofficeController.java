package com.project.cepat.kelar.fe.controller.frontoffice;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

import com.project.cepat.kelar.jpa.model.Voting;
import com.project.cepat.kelar.service.backoffice.AudioService;
import com.project.cepat.kelar.service.backoffice.CollectionService;
import com.project.cepat.kelar.service.backoffice.HighlightService;
import com.project.cepat.kelar.service.backoffice.VotingService;

@Controller
public class FrontofficeController {

    @Autowired(required = false)
    private HighlightService highlightService;

    @Autowired(required = false)
    private CollectionService collectionService;

    @Autowired(required = false)
    private AudioService audioService;

    @Autowired(required = false)
    private VotingService votingService;

    // --- LANDING & NAVIGATION ---
    @GetMapping({"/", "/landing-page"})
    public String landingPage() {
        return "frontoffice/landing-page";
    }

    @GetMapping("/loading")
    public String loadingAlias() {
        return "frontoffice/loading-page";
    }

    @GetMapping("/home")
    public String home() {
        return "frontoffice/home";
    }

    // --- MAIN DATA LOADER (HOME-ALT) ---
    @GetMapping("/home-alt")
    public String homeAlt(ModelMap model) {
        try {
            // 1. Data Koleksi
            if (collectionService != null) {
                model.addAttribute("collections", collectionService.getPageablePublished(PageRequest.of(0, 9)));
            }
            
            // 2. Data Audio
            if (audioService != null) {
                model.addAttribute("audios", audioService.getPageablePublished(PageRequest.of(0, 9)).getContent());
            }
            
            // 3. Data Voting (Kandidat Aktif)
            if (votingService != null) {
                Voting activeVoting = votingService.getActiveVoting();
                if (activeVoting != null) {
                    model.addAttribute("voting", activeVoting);
                    model.addAttribute("participants", votingService.getEntriesByVotingId(activeVoting.getId()));
                } else {
                    System.out.println("DEBUG: Tidak ada voting dengan status 'Aktif' di database.");
                }
            }
        } catch (Exception e) {
            System.out.println("ERROR memuat home-alt: " + e.getMessage());
        }
        return "frontoffice/home-alt";
    }

    // --- OTHER PAGES ---
    @GetMapping("/highlights")
    public String highlights(ModelMap model) {
        try {
            if (highlightService != null) {
                java.util.List<java.util.Map<String, Object>> faqs = new java.util.ArrayList<>();
                for (var item : highlightService.getPublishedList()) {
                    java.util.Map<String, Object> faq = new java.util.HashMap<>();
                    faq.put("question", item.getQuestion());
                    faq.put("answer", item.getAnswer());
                    faqs.add(faq);
                }
                model.addAttribute("faqs", faqs);
            }
        } catch (Exception ignored) {
            model.addAttribute("faqs", new java.util.ArrayList<>());
        }
        return "frontoffice/highlights";
    }

    @GetMapping("/activities") public String activities() { return "frontoffice/activities"; }
    @GetMapping("/facilities") public String facilities() { return "frontoffice/facilities"; }
    @GetMapping("/programs") public String programs() { return "frontoffice/programs"; }
    @GetMapping("/profile") public String profile() { return "frontoffice/profile"; }
    @GetMapping("/loading-page") public String loadingPage() { return "frontoffice/loading-page"; }
    @GetMapping("/search") public String search() { return "frontoffice/search-results-collections"; }
    @GetMapping("/filter") public String filter() { return "frontoffice/filter"; }
    @GetMapping("/articles-details/{id}") public String articleDetail(@PathVariable("id") String id) { return "frontoffice/article-detail"; }
}