package com.project.cepat.kelar.fe.controller.backoffice;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
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
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.project.cepat.kelar.common.controller.BaseController;
import com.project.cepat.kelar.common.constant.ArticleStatus;
import com.project.cepat.kelar.jpa.model.Article;
import com.project.cepat.kelar.service.backoffice.ArticleService;
import com.project.cepat.kelar.service.backoffice.util.ArticleConvertUtil;
import com.project.cepat.kelar.wrapper.backoffice.ArticleWrapper;

@Controller
@RequestMapping("/admin/articles")
public class ArticleController extends BaseController {
	
	private static final Logger logger = LoggerFactory.getLogger(ArticleController.class);
	
	@Autowired(required = false)
	private ArticleService articleService;
	
	@Override
	public String pageTitle() {
		return "Article Management";
	}
	
	/**
	 * Save article (create or update)
	 */
	@PostMapping("/save")
	public String saveArticle(
			@RequestParam(required = false) Long id,
			@RequestParam("title") String title,
			@RequestParam("category") String category,
			@RequestParam(value = "cover", required = false) MultipartFile cover,
			@RequestParam("content") String content,
			@RequestParam(value = "statusAction", required = false) String statusAction,
			RedirectAttributes redirectAttributes) {
		try {
			String normalizedAction = statusAction == null ? "" : statusAction.trim().toUpperCase();
			if (normalizedAction.isEmpty()) {
				normalizedAction = (id == null) ? "PUBLISHED" : "KEEP";
			}
			logger.info("Saving article: {}, id={}, action={}", title, id, normalizedAction);
			ArticleStatus targetStatus = null;
			if ("HIDDEN".equals(normalizedAction)) {
				targetStatus = ArticleStatus.HIDDEN;
			} else if ("PUBLISHED".equals(normalizedAction)) {
				targetStatus = ArticleStatus.PUBLISHED;
			}
			
			// Create wrapper from form data
			ArticleWrapper wrapper = new ArticleWrapper();
			wrapper.setNo(id);
			wrapper.setTitle(title);
			wrapper.setCategory(category);
			wrapper.setContent(content);
			if (targetStatus != null) {
				wrapper.setStatus(targetStatus);
			}
			
			// Save article
			if (articleService != null) {
				Article savedArticle = articleService.saveFromWrapper(wrapper, cover);
				logger.info("Article saved successfully with ID: {}", savedArticle.getId());
				if (targetStatus == null) {
					redirectAttributes.addFlashAttribute("successMessage", "Artikel berhasil diperbarui!");
				} else {
					String statusLabel = targetStatus == ArticleStatus.HIDDEN ? "disembunyikan" : "dipublikasikan";
					redirectAttributes.addFlashAttribute("successMessage", 
						id != null ? "Artikel berhasil diperbarui dan " + statusLabel + "!" : "Artikel berhasil " + statusLabel + "!");
				}
			} else {
				logger.warn("ArticleService is not available");
				redirectAttributes.addFlashAttribute("errorMessage", "Service tidak tersedia");
				return "redirect:/admin/articles/new";
			}
			
			return "redirect:/admin/articles";
		} catch (Exception e) {
			logger.error("Error saving article: {}", e.getMessage(), e);
			redirectAttributes.addFlashAttribute("errorMessage", 
				"Gagal menyimpan artikel: " + e.getMessage());
			return "redirect:/admin/articles/new";
		}
	}
	
	/**
	 * Delete article
	 */
	@GetMapping("/delete/{id}")
	public String deleteArticle(@PathVariable Long id, RedirectAttributes redirectAttributes) {
		try {
			logger.info("Deleting article with ID: {}", id);
			
			if (articleService != null) {
				articleService.delete(id);
				logger.info("Article deleted successfully with ID: {}", id);
				redirectAttributes.addFlashAttribute("successMessage", "Artikel berhasil dihapus!");
			} else {
				logger.warn("ArticleService is not available");
				redirectAttributes.addFlashAttribute("errorMessage", "Service tidak tersedia");
			}
			
			return "redirect:/admin/articles";
		} catch (Exception e) {
			logger.error("Error deleting article: {}", e.getMessage(), e);
			redirectAttributes.addFlashAttribute("errorMessage", 
				"Gagal menghapus artikel: " + e.getMessage());
			return "redirect:/admin/articles";
		}
	}
	
	/**
	 * Auto-save article as draft (AJAX endpoint)
	 */
	@PostMapping("/autosave")
	@ResponseBody
	public ResponseEntity<?> autoSaveArticle(
			@RequestParam(required = false) Long id,
			@RequestParam(value = "title", required = false) String title,
			@RequestParam(value = "category", required = false) String category,
			@RequestParam(value = "content", required = false) String content) {
		try {
			logger.info("Auto-saving article as draft: {}", title);
			
			// Validate minimum data
			if ((title == null || title.trim().isEmpty()) && 
			    (category == null || category.trim().isEmpty()) && 
			    (content == null || content.trim().isEmpty())) {
				return ResponseEntity.ok(new java.util.HashMap<String, Object>() {{
					put("success", false);
					put("message", "Tidak ada data untuk disimpan");
				}});
			}
			
			if (articleService != null) {
				Article savedArticle = articleService.saveAsDraft(id, title, category, content);
				logger.info("Article auto-saved as draft with ID: {}", savedArticle.getId());
				
				return ResponseEntity.ok(new java.util.HashMap<String, Object>() {{
					put("success", true);
					put("articleId", savedArticle.getId());
					put("message", "Draft tersimpan otomatis");
					put("timestamp", new java.util.Date());
				}});
			} else {
				return ResponseEntity.status(HttpStatus.SERVICE_UNAVAILABLE)
					.body(new java.util.HashMap<String, Object>() {{
						put("success", false);
						put("message", "Service tidak tersedia");
					}});
			}
		} catch (Exception e) {
			logger.error("Error auto-saving article: {}", e.getMessage(), e);
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
				.body(new java.util.HashMap<String, Object>() {{
					put("success", false);
					put("message", "Gagal menyimpan: " + e.getMessage());
				}});
		}
	}
	
	/**
	 * Serve article cover image from database
	 */
	@GetMapping("/image/{id}")
	public ResponseEntity<byte[]> getArticleImage(@PathVariable Long id) {
		try {
			logger.info("Loading cover image for article ID: {}", id);
			
			if (articleService != null) {
				Article article = articleService.getById(id);
				
				if (article != null && article.getCoverImageData() != null) {
					HttpHeaders headers = new HttpHeaders();
					headers.setContentType(MediaType.IMAGE_JPEG); // Default to JPEG, you can detect type
					headers.setContentLength(article.getCoverImageData().length);
					
					return new ResponseEntity<>(article.getCoverImageData(), headers, HttpStatus.OK);
				}
			}
			
			return new ResponseEntity<>(HttpStatus.NOT_FOUND);
		} catch (Exception e) {
			logger.error("Error loading article image: {}", e.getMessage(), e);
			return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}
	
	/**
	 * Get all articles with pagination (API endpoint)
	 */
	@GetMapping("/api")
	@ResponseBody
	public ResponseEntity<Map<String, Object>> getAllArticlesApi(
			@RequestParam(defaultValue = "") String search,
			@RequestParam(defaultValue = "0") int page,
			@RequestParam(defaultValue = "10") int size) {
		try {
			logger.info("Getting articles - page: {}, size: {}, search: {}", page, size, search);
			
			Map<String, Object> response = new HashMap<>();
			
			if (articleService != null) {
				Pageable pageable = PageRequest.of(page, size, Sort.by(Sort.Direction.DESC, "createdDate"));
				Page<Article> articlePage = articleService.getPageable(search, pageable);
				
				List<ArticleWrapper> articles = ArticleConvertUtil.convertToWrapperList(articlePage.getContent());
				
				response.put("articles", articles);
				response.put("currentPage", articlePage.getNumber());
				response.put("totalItems", articlePage.getTotalElements());
				response.put("totalPages", articlePage.getTotalPages());
				
				return ResponseEntity.ok(response);
			} else {
				response.put("error", "Service not available");
				return ResponseEntity.status(HttpStatus.SERVICE_UNAVAILABLE).body(response);
			}
		} catch (Exception e) {
			logger.error("Error getting articles: {}", e.getMessage(), e);
			Map<String, Object> errorResponse = new HashMap<>();
			errorResponse.put("error", e.getMessage());
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(errorResponse);
		}
	}
	
	/**
	 * Get article by ID (API endpoint)
	 */
	@GetMapping("/api/{id}")
	@ResponseBody
	public ResponseEntity<ArticleWrapper> getArticleByIdApi(@PathVariable Long id) {
		try {
			logger.info("Getting article by ID: {}", id);
			
			if (articleService != null) {
				ArticleWrapper article = articleService.getArticleWrapperByNo(id);
				return ResponseEntity.ok(article);
			} else {
				return ResponseEntity.status(HttpStatus.SERVICE_UNAVAILABLE).build();
			}
		} catch (Exception e) {
			logger.error("Error getting article by ID: {}", e.getMessage(), e);
			return ResponseEntity.status(HttpStatus.NOT_FOUND).build();
		}
	}
	
	/**
	 * Get all articles without pagination (API endpoint)
	 */
	@GetMapping("/api/all")
	@ResponseBody
	public ResponseEntity<List<ArticleWrapper>> getAllArticlesNoPagination() {
		try {
			logger.info("Getting all articles without pagination");
			
			if (articleService != null) {
				List<Article> articles = articleService.getAll();
				List<ArticleWrapper> wrappers = ArticleConvertUtil.convertToWrapperList(articles);
				return ResponseEntity.ok(wrappers);
			} else {
				return ResponseEntity.status(HttpStatus.SERVICE_UNAVAILABLE).build();
			}
		} catch (Exception e) {
			logger.error("Error getting all articles: {}", e.getMessage(), e);
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
		}
	}
	
}
