package com.project.cepat.kelar.fe.controller.frontoffice;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

import com.project.cepat.kelar.jpa.model.Article;
import com.project.cepat.kelar.jpa.model.Comment;
import com.project.cepat.kelar.jpa.model.Highlight;
import com.project.cepat.kelar.jpa.model.Voting;
import com.project.cepat.kelar.service.backoffice.ArticleService;
import com.project.cepat.kelar.service.backoffice.AudioService;
import com.project.cepat.kelar.service.backoffice.CollectionService;
import com.project.cepat.kelar.service.backoffice.CommentService;
import com.project.cepat.kelar.service.backoffice.HighlightService;
import com.project.cepat.kelar.service.backoffice.VotingService;

@Controller
public class FrontofficeController {

    private static final SimpleDateFormat DATE_FORMAT = new SimpleDateFormat("dd MMM yyyy");

    @Autowired(required = false)
    private HighlightService highlightService;

    @Autowired(required = false)
    private CollectionService collectionService;

    @Autowired(required = false)
    private AudioService audioService;

    @Autowired(required = false)
    private VotingService votingService;

    @Autowired(required = false)
    private ArticleService articleService;

    @Autowired(required = false)
    private CommentService commentService;

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
    public String home(ModelMap model) {
        loadHomeData(model);
        return "frontoffice/home";
    }

    // --- MAIN DATA LOADER (HOME-ALT) ---
    @GetMapping("/home-alt")
    public String homeAlt(ModelMap model) {
        loadHomeData(model);
        return "frontoffice/home-alt";
    }

    // Method terpusat untuk memuat data ke model frontoffice
    private void loadHomeData(ModelMap model) {
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
                }
            }

            // 4. Data Artikel & Komentarnya
            List<Article> rawArticles = new ArrayList<>();
            if (articleService != null) {
                try {
                    rawArticles = articleService.getAll();
                } catch (Exception e) {
                    try {
                        rawArticles = articleService.getByStatus(com.project.cepat.kelar.common.constant.ArticleStatus.PUBLISHED);
                    } catch (Exception ignored) {}
                }
            }

            List<Map<String, Object>> articleListMaps = new ArrayList<>();
            if (rawArticles != null) {
                for (Article a : rawArticles) {
                    Map<String, Object> aMap = new HashMap<>();
                    aMap.put("id", a.getId());
                    aMap.put("title", a.getTitle() != null ? a.getTitle() : "");
                    aMap.put("content", a.getContent() != null ? a.getContent() : "");
                    aMap.put("img", "/admin/articles/image/" + a.getId());

                    List<Map<String, Object>> commentMaps = new ArrayList<>();
                    if (commentService != null) {
                        try {
                            Pageable pageable = PageRequest.of(0, 100);
                            Page<Comment> commentPage = commentService.getCommentsByArticleId(a.getId(), pageable);
                            for (Comment c : commentPage.getContent()) {
                                if ("Tampil".equalsIgnoreCase(c.getStatus()) || "Published".equalsIgnoreCase(c.getStatus())) {
                                    Map<String, Object> cMap = new HashMap<>();
                                    cMap.put("sender", c.getSender() != null ? c.getSender() : "Anonim");
                                    cMap.put("content", c.getContent() != null ? c.getContent() : "");
                                    cMap.put("date", c.getCommentDate() != null ? DATE_FORMAT.format(c.getCommentDate()) : "");
                                    commentMaps.add(cMap);
                                }
                            }
                        } catch (Exception e) {
                            System.out.println("Error loading comments for article " + a.getId() + ": " + e.getMessage());
                        }
                    }
                    aMap.put("comments", commentMaps);
                    articleListMaps.add(aMap);
                }
            }

            model.addAttribute("articlesMap", articleListMaps);
            model.addAttribute("articles", rawArticles != null ? rawArticles : new ArrayList<>());

            // =========================================================================
            // 5. DATA SOROTAN / FAQ (KUNCI UTAMA AGAR MODAL HOME TIDAK LAGI GAGAL MEMUAT)
            // =========================================================================
            if (highlightService != null) {
                List<Map<String, Object>> faqs = new ArrayList<>();
                for (Highlight item : highlightService.getPublishedList()) {
                    Map<String, Object> faq = new HashMap<>();
                    faq.put("question", item.getQuestion());
                    faq.put("answer", item.getAnswer());
                    faqs.add(faq);
                }
                model.addAttribute("faqs", faqs);
            } else {
                model.addAttribute("faqs", new ArrayList<>());
            }
            // =========================================================================

        } catch (Exception e) {
            System.out.println("ERROR memuat data beranda frontoffice: " + e.getMessage());
            model.addAttribute("articles", new ArrayList<>());
            model.addAttribute("articlesMap", new ArrayList<>());
            model.addAttribute("faqs", new ArrayList<>());
        }
    }

    // --- OTHER PAGES ---
    @GetMapping("/highlights")
    public String highlights(ModelMap model) {
        try {
            if (highlightService != null) {
                List<Map<String, Object>> faqs = new ArrayList<>();
                for (var item : highlightService.getPublishedList()) {
                    Map<String, Object> faq = new HashMap<>();
                    faq.put("question", item.getQuestion());
                    faq.put("answer", item.getAnswer());
                    faqs.add(faq);
                }
                model.addAttribute("faqs", faqs);
            }
        } catch (Exception ignored) {
            model.addAttribute("faqs", new ArrayList<>());
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