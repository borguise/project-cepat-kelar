package com.project.cepat.kelar.fe.controller.frontoffice;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/voting")
public class VotingFrontofficeController {

    @GetMapping("")
    public String voting() {
        return "frontoffice/voting";
    }
}
