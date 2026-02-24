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

    @GetMapping("/events")
    public String events() {
        return "frontoffice/events";
    }

    @GetMapping("/articles")
    public String articles() {
        return "frontoffice/articles";
    }

    @GetMapping("/article-detail")
    public String articleDetail() {
        return "frontoffice/article-detail";
    }

    @GetMapping("/article-detail-alt")
    public String articleDetailAlt() {
        return "frontoffice/article-detail-alt";
    }

    @GetMapping("/collections")
    public String collections() {
        return "frontoffice/collections";
    }

    @GetMapping("/collections-found")
    public String collectionsFound() {
        return "frontoffice/collections-found";
    }

    @GetMapping("/collections-not-found")
    public String collectionsNotFound() {
        return "frontoffice/collections-not-found";
    }

    @GetMapping("/collection-detail")
    public String collectionDetail() {
        return "frontoffice/collection-detail";
    }

    @GetMapping("/audio")
    public String audio() {
        return "frontoffice/audio";
    }

    @GetMapping("/audio-detail")
    public String audioDetail() {
        return "frontoffice/audio-detail";
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

    @GetMapping("/voting")
    public String voting() {
        return "frontoffice/voting";
    }

    @GetMapping("/loading-page")
    public String loadingPage() {
        return "frontoffice/loading-page";
    }

    @GetMapping("/search-results-audio")
    public String searchResultsAudio() {
        return "frontoffice/search-results-audio";
    }

    @GetMapping("/search-results-collections")
    public String searchResultsCollections() {
        return "frontoffice/search-results-collections";
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
