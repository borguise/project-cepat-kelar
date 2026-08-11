package com.project.cepat.kelar.fe.controller.frontoffice;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;

import com.project.cepat.kelar.jpa.model.Highlight;
import com.project.cepat.kelar.service.backoffice.HighlightService;

@Controller
public class HighlightFrontofficeController {

    @Autowired(required = false)
    private HighlightService highlightService;

    // Menangani rute URL khusus untuk highlight / sorotan pengunjung
    @GetMapping({"/highlights", "/sorotan"})
    public String highlights(ModelMap model) {
        try {
            if (highlightService != null) {
                List<Map<String, Object>> faqs = new ArrayList<>();
                
                // Menggunakan getPublishedList() karena sudah tersedia di Service kamu!
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
        } catch (Exception e) {
            System.out.println("Error memuat popup sorotan: " + e.getMessage());
            model.addAttribute("faqs", new ArrayList<>());
        }
        return "frontoffice/highlights"; 
    }
}