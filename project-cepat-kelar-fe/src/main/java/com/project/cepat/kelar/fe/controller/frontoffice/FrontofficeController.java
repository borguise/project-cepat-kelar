package com.project.cepat.kelar.fe.controller.frontoffice;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class FrontofficeController {

    @GetMapping("/")
    public String landingPage() {
        return "frontoffice/landing-page";
    }

    @GetMapping("/landing-page")
    public String landingPageAlias() {
        return "frontoffice/landing-page";
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
    public String highlights() {
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
}
