package com.project.cepat.kelar.fe.controller.frontoffice;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/collections")
public class CollectionFrontofficeController {

    @GetMapping("")
    public String collections() {
        return "frontoffice/collections";
    }

    @GetMapping("/found")
    public String collectionsFound() {
        return "frontoffice/collections-found";
    }

    @GetMapping("/not-found")
    public String collectionsNotFound() {
        return "frontoffice/collections-not-found";
    }

    @GetMapping("/detail")
    public String collectionDetail() {
        return "frontoffice/collection-detail";
    }
    
    @GetMapping("/search-results")
    public String searchResultsCollections() {
        return "frontoffice/search-results-collections";
    }
}
