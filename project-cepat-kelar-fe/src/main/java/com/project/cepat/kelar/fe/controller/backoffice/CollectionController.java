package com.project.cepat.kelar.fe.controller.backoffice;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.project.cepat.kelar.common.controller.BaseController;
import com.project.cepat.kelar.jpa.model.Collection;
import com.project.cepat.kelar.service.backoffice.CollectionService;

import jakarta.servlet.http.HttpServletRequest;

@Controller
@RequestMapping("/admin/collections")
public class CollectionController extends BaseController {

    private static final Logger logger = LoggerFactory.getLogger(CollectionController.class);

    @Autowired(required = false)
    private CollectionService collectionService;

    @Override
    public String pageTitle() {
        return "Collection Management";
    }

    @PostMapping("/save")
    public String saveCollection(
            @RequestParam(value = "id", required = false) String idRaw,
            @RequestParam(value = "subject", required = false) String subject,
            @RequestParam(value = "title", required = false) String title,
            @RequestParam(value = "author", required = false) String author,
            @RequestParam(value = "publisher", required = false) String publisher,
            @RequestParam(value = "publishCity", required = false) String publishCity,
            @RequestParam(value = "publishYear", required = false) String publishYear,
            @RequestParam(value = "physicalDescription", required = false) String physicalDescription,
            @RequestParam(value = "isbn", required = false) String isbn,
            @RequestParam(value = "stock", required = false) String stockRaw,
            @RequestParam(value = "callNumber", required = false) String callNumber,
            @RequestParam(value = "status", required = false) String status,
            HttpServletRequest request,
            RedirectAttributes redirectAttributes) {
        Long parsedId = null;
        try {
            parsedId = parseLongOrNull(idRaw, "id");
            Integer stock = parseIntegerOrNull(stockRaw, "stock");
            MultipartFile coverFile = resolveCoverFile(request);

            if (title == null || title.isBlank()) {
                redirectAttributes.addFlashAttribute("errorMessage", "Judul buku wajib diisi.");
                if (parsedId != null) {
                    return "redirect:/admin/collections/edit/" + parsedId;
                }
                return "redirect:/admin/collections/new";
            }

            if (collectionService == null) {
                redirectAttributes.addFlashAttribute("errorMessage", "Service koleksi tidak tersedia");
                return "redirect:/admin/collections";
            }

            Collection saved = collectionService.saveFromForm(parsedId, subject, title, author, publisher, publishCity,
                    publishYear, physicalDescription, isbn, stock, callNumber, status, coverFile);
            logger.info("Collection saved with ID: {}", saved.getId());
            redirectAttributes.addFlashAttribute("successMessage", "Koleksi buku berhasil disimpan!");
            return "redirect:/admin/collections";
        } catch (Exception e) {
            logger.error("Error saving collection: {}", e.getMessage(), e);
            redirectAttributes.addFlashAttribute("errorMessage", "Gagal menyimpan koleksi buku: " + e.getMessage());
            if (parsedId != null) {
                return "redirect:/admin/collections/edit/" + parsedId;
            }
            return "redirect:/admin/collections/new";
        } catch (Throwable t) {
            logger.error("Unexpected error saving collection", t);
            redirectAttributes.addFlashAttribute("errorMessage", "Terjadi kesalahan saat menyimpan koleksi buku.");
            if (parsedId != null) {
                return "redirect:/admin/collections/edit/" + parsedId;
            }
            return "redirect:/admin/collections/new";
        }
    }

    private Long parseLongOrNull(String rawValue, String fieldName) {
        if (rawValue == null || rawValue.isBlank()) {
            return null;
        }
        try {
            return Long.valueOf(rawValue.trim());
        } catch (NumberFormatException e) {
            throw new IllegalArgumentException("Nilai " + fieldName + " tidak valid");
        }
    }

    private Integer parseIntegerOrNull(String rawValue, String fieldName) {
        if (rawValue == null || rawValue.isBlank()) {
            return null;
        }
        try {
            return Integer.valueOf(rawValue.trim());
        } catch (NumberFormatException e) {
            throw new IllegalArgumentException("Nilai " + fieldName + " harus berupa angka");
        }
    }

    private MultipartFile resolveCoverFile(HttpServletRequest request) {
        if (request instanceof MultipartHttpServletRequest multipartRequest) {
            return multipartRequest.getFile("coverFile");
        }
        return null;
    }

    @GetMapping("/delete/{id}")
    public String deleteCollection(@PathVariable Long id, RedirectAttributes redirectAttributes) {
        try {
            if (collectionService != null) {
                collectionService.delete(id);
                redirectAttributes.addFlashAttribute("successMessage", "Koleksi buku berhasil dihapus!");
            } else {
                redirectAttributes.addFlashAttribute("errorMessage", "Service koleksi tidak tersedia");
            }
        } catch (Exception e) {
            logger.error("Error deleting collection: {}", e.getMessage(), e);
            redirectAttributes.addFlashAttribute("errorMessage", "Gagal menghapus koleksi buku: " + e.getMessage());
        }
        return "redirect:/admin/collections";
    }

    @GetMapping("/image/{id}")
    public ResponseEntity<byte[]> getCollectionImage(@PathVariable Long id) {
        try {
            if (collectionService != null) {
                Collection book = collectionService.getById(id);
                if (book != null && book.getCoverImageData() != null) {
                    HttpHeaders headers = new HttpHeaders();
                    headers.setContentType(MediaType.IMAGE_JPEG);
                    headers.setContentLength(book.getCoverImageData().length);
                    return new ResponseEntity<>(book.getCoverImageData(), headers, HttpStatus.OK);
                }
            }
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        } catch (Exception e) {
            logger.error("Error loading collection cover image: {}", e.getMessage(), e);
            return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }
}
