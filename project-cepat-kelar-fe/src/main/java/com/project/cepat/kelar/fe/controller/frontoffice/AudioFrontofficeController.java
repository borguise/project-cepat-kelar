package com.project.cepat.kelar.fe.controller.frontoffice;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/audio")
public class AudioFrontofficeController {

    @GetMapping("")
    public String audio() {
        return "frontoffice/audio";
    }

    @GetMapping("/detail")
    public String audioDetail() {
        return "frontoffice/audio-detail";
    }
    
    @GetMapping("/search-results")
    public String searchResultsAudio() {
        return "frontoffice/search-results-audio";
    }
}
