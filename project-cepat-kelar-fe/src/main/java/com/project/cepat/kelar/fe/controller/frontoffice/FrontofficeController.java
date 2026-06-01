package com.project.cepat.kelar.fe.controller.frontoffice;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

@Controller
public class FrontofficeController {

    @org.springframework.beans.factory.annotation.Autowired(required = false)
    private com.project.cepat.kelar.service.backoffice.HighlightService highlightService;

    @GetMapping("/")
    public String landingPage() {
        return "frontoffice/landing-page";
    }

    @GetMapping("/landing-page")
    public String landingPageAlias() {
        return "frontoffice/landing-page";
    }

    // --- TAMBAHAN KITA: Rute alias untuk /loading agar sesuai dengan tombol JavaScript ---
    @GetMapping("/loading")
    public String loadingAlias() {
        return "frontoffice/loading-page";
    }

    @GetMapping("/home")
    public String home() {
        return "frontoffice/home";
    }

    @GetMapping("/home-alt")
    public String homeAlt() {
        return "frontoffice/home-alt";
    }

    @GetMapping("/home-page")
    public String homePage() {
        return "frontoffice/home-page";
    }

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

    @GetMapping("/activities")
    public String activities() {
        return "frontoffice/activities";
    }

    @GetMapping("/facilities")
    public String facilities() {
        return "frontoffice/facilities";
    }

    @GetMapping("/programs")
    public String programs() {
        return "frontoffice/programs";
    }

    @GetMapping("/profile")
    public String profile() {
        return "frontoffice/profile";
    }

    @GetMapping("/loading-page")
    public String loadingPage() {
        return "frontoffice/loading-page";
    }

    @GetMapping("/search")
    public String search() {
        return "frontoffice/search-results-collections";
    }

    @GetMapping("/filter")
    public String filter() {
        return "frontoffice/filter";
    }

    // --- TAMBAHAN KITA: Rute Sementara untuk UI Detail Artikel ---
    @GetMapping("/articles-details/{id}")
    public String articleDetail(@PathVariable("id") String id) {
        return "frontoffice/article-detail";
    }
}