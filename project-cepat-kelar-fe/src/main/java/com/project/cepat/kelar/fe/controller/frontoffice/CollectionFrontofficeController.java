package com.project.cepat.kelar.fe.controller.frontoffice;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@RequestMapping("/collections")
public class CollectionFrontofficeController {

    @Autowired(required = false)
    private com.project.cepat.kelar.service.backoffice.CollectionService collectionService;

    @GetMapping("")
    public String collections(
            @RequestParam(value = "keyword", required = false) String keyword,
            @RequestParam(value = "page", defaultValue = "1") int page,
            ModelMap model) {
        int safePage = Math.max(page, 1);
        var pageRequest = PageRequest.of(safePage - 1, 9);

        try {
            if (collectionService != null) {
                var pageResult = (keyword != null && !keyword.trim().isEmpty())
                        ? collectionService.searchPublished(keyword.trim(), pageRequest)
                        : collectionService.getPageablePublished(pageRequest);
                model.addAttribute("bookList", pageResult.getContent());
                model.addAttribute("currentPage", safePage);
                model.addAttribute("totalPages", Math.max(pageResult.getTotalPages(), 1));
                model.addAttribute("keyword", keyword);
            }
        } catch (Exception ignored) {
            model.addAttribute("bookList", new java.util.ArrayList<>());
            model.addAttribute("currentPage", 1);
            model.addAttribute("totalPages", 1);
            model.addAttribute("keyword", keyword);
        }

        model.addAttribute("searchAction", "/collections");
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
    public String collectionDetail(@RequestParam("id") Long id, ModelMap model) {
        try {
            if (collectionService != null) {
                var book = collectionService.getById(id);
                java.util.Map<String, Object> viewBook = new java.util.HashMap<>();
                viewBook.put("id", book.getId());
                viewBook.put("title", book.getTitle());
                viewBook.put("cover", "/admin/collections/image/" + book.getId());
                viewBook.put("callNumber", book.getCallNumber());
                viewBook.put("category", book.getSubject());
                viewBook.put("author", book.getAuthor());
                String publisherInfo = (book.getPublisher() == null ? "" : book.getPublisher())
                        + ((book.getPublishCity() == null || book.getPublishCity().isBlank()) ? "" : " - " + book.getPublishCity())
                        + ((book.getPublishYear() == null || book.getPublishYear().isBlank()) ? "" : ", " + book.getPublishYear());
                viewBook.put("publisher", publisherInfo);
                viewBook.put("physicalData", book.getPhysicalDescription());
                model.addAttribute("book", viewBook);
            }
        } catch (Exception ignored) {
            // Keep fallback values from template when data is unavailable.
        }
        return "frontoffice/collection-detail";
    }
    
    @GetMapping("/search-results")
    public String searchResultsCollections() {
        return "frontoffice/search-results-collections";
    }
}
