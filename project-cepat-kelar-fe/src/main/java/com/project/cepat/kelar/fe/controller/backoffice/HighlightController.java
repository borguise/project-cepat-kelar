package com.project.cepat.kelar.fe.controller.backoffice;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.project.cepat.kelar.common.controller.BaseController;
import com.project.cepat.kelar.jpa.model.Highlight;
import com.project.cepat.kelar.service.backoffice.HighlightService;

@Controller
@RequestMapping("/admin/highlights")
public class HighlightController extends BaseController {

    private static final Logger logger = LoggerFactory.getLogger(HighlightController.class);

    @Autowired(required = false)
    private HighlightService highlightService;

    @Override
    public String pageTitle() {
        return "Highlights Management";
    }

    @PostMapping("/save")
    public String saveHighlight(
            @RequestParam(required = false) Long id,
            @RequestParam("question") String question,
            @RequestParam("answer") String answer,
            @RequestParam(value = "displayOrder", required = false) Integer displayOrder,
            @RequestParam(value = "status", required = false) String status,
            RedirectAttributes redirectAttributes) {
        try {
            if (highlightService == null) {
                redirectAttributes.addFlashAttribute("errorMessage", "Service sorotan tidak tersedia");
                return "redirect:/admin/highlights";
            }

            Highlight saved = highlightService.saveFromForm(id, question, answer, displayOrder, status);
            logger.info("Highlight saved with ID: {}", saved.getId());
            redirectAttributes.addFlashAttribute("successMessage", "Sorotan berhasil disimpan!");
            return "redirect:/admin/highlights";
        } catch (Exception e) {
            logger.error("Error saving highlight: {}", e.getMessage(), e);
            redirectAttributes.addFlashAttribute("errorMessage", "Gagal menyimpan sorotan: " + e.getMessage());
            if (id != null) {
                return "redirect:/admin/highlights/edit/" + id;
            }
            return "redirect:/admin/highlights/new";
        }
    }

    @GetMapping("/delete/{id}")
    public String deleteHighlight(@PathVariable Long id, RedirectAttributes redirectAttributes) {
        try {
            if (highlightService != null) {
                highlightService.delete(id);
                redirectAttributes.addFlashAttribute("successMessage", "Sorotan berhasil dihapus!");
            } else {
                redirectAttributes.addFlashAttribute("errorMessage", "Service sorotan tidak tersedia");
            }
        } catch (Exception e) {
            logger.error("Error deleting highlight: {}", e.getMessage(), e);
            redirectAttributes.addFlashAttribute("errorMessage", "Gagal menghapus sorotan: " + e.getMessage());
        }
        return "redirect:/admin/highlights";
    }
}
