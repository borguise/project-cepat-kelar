package com.project.cepat.kelar.service.backoffice.impl;

import java.io.IOException;
import java.util.Date;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.project.cepat.kelar.common.constant.ArticleStatus;
import com.project.cepat.kelar.jpa.model.Article;
import com.project.cepat.kelar.jpa.repository.ArticleRepository;
import com.project.cepat.kelar.service.backoffice.ArticleService;
import com.project.cepat.kelar.service.backoffice.util.ArticleConvertUtil;
import com.project.cepat.kelar.wrapper.backoffice.ArticleWrapper;

import lombok.extern.log4j.Log4j2;

@Service
@Transactional
@Log4j2
public class ArticleServiceImpl implements ArticleService {
	
	@Autowired
	private ArticleRepository articleRepository;
	
	@Override
	public Long getNum() {
		return articleRepository.count();
	}
	
	@Override
	public Article save(Article entity) throws Exception {
		try {
			log.debug("=== SAVE ENTITY START ===");
			log.debug("Saving Article entity: id={}, title={}", entity.getId(), entity.getTitle());
			Article result = articleRepository.saveAndFlush(entity);
			log.debug("Entity saved and flushed: id={}", result.getId());
			log.debug("=== SAVE ENTITY END (SUCCESS) ===");
			return result;
		} catch (Exception e) {
			log.error("=== SAVE ENTITY END (ERROR) ===");
			log.error("Error saving Article entity - Exception type: {}", e.getClass().getName());
			log.error("Error message: {}", e.getMessage());
			log.error("Full stack trace: ", e);
			throw new Exception("Failed to save Article: " + e.getMessage(), e);
		}
	}
	
	@Override
	public Article getById(Long pk) throws Exception {
		try {
			log.info("Getting Article by ID: {}", pk);
			Optional<Article> article = articleRepository.findById(pk);
			if (article.isPresent()) {
				return article.get();
			}
			throw new Exception("Article not found with ID: " + pk);
		} catch (Exception e) {
			log.error("Error getting Article by ID: {}", e.getMessage(), e);
			throw new Exception("Failed to get Article: " + e.getMessage(), e);
		}
	}
	
	@Override
	public Boolean delete(Long pk) throws Exception {
		try {
			log.info("Deleting Article with ID: {}", pk);
			Optional<Article> article = articleRepository.findById(pk);
			if (article.isPresent()) {
				articleRepository.deleteById(pk);
				return true;
			}
			throw new Exception("Article not found with ID: " + pk);
		} catch (Exception e) {
			log.error("Error deleting Article: {}", e.getMessage(), e);
			throw new Exception("Failed to delete Article: " + e.getMessage(), e);
		}
	}
	
	@Override
	public List<Article> getAll() throws Exception {
		try {
			log.info("Getting all Articles");
			return articleRepository.findAll();
		} catch (Exception e) {
			log.error("Error getting all Articles: {}", e.getMessage(), e);
			throw new Exception("Failed to get all Articles: " + e.getMessage(), e);
		}
	}
	
	@Override
	public Article getByNo(Long no) throws Exception {
		try {
			log.info("Getting Article by No: {}", no);
			return getById(no);
		} catch (Exception e) {
			log.error("Error getting Article by No: {}", e.getMessage(), e);
			throw new Exception("Failed to get Article: " + e.getMessage(), e);
		}
	}
	
	@Override
	public Page<Article> getPageable(String text, Pageable pageable) throws Exception {
		try {
			log.info("Getting Article pageable with text: {}", text);
			return articleRepository.getPageable(text, pageable);
		} catch (Exception e) {
			log.error("Error getting Article pageable: {}", e.getMessage(), e);
			throw new Exception("Failed to get Article pageable: " + e.getMessage(), e);
		}
	}
	
	@Override
	public Page<Article> getPageableByTitle(String text, Pageable pageable) throws Exception {
		try {
			log.info("Getting Article pageable by title with text: {}", text);
			return articleRepository.getPageableByTitle(text, pageable);
		} catch (Exception e) {
			log.error("Error getting Article pageable by title: {}", e.getMessage(), e);
			throw new Exception("Failed to get Article pageable by title: " + e.getMessage(), e);
		}
	}
	
	@Override
	public Page<Article> getPageableByCategory(String text, Pageable pageable) throws Exception {
		try {
			log.info("Getting Article pageable by category with text: {}", text);
			return articleRepository.getPageableByCategory(text, pageable);
		} catch (Exception e) {
			log.error("Error getting Article pageable by category: {}", e.getMessage(), e);
			throw new Exception("Failed to get Article pageable by category: " + e.getMessage(), e);
		}
	}
	
	@Override
	public Page<Article> getPageableActive(Pageable pageable) throws Exception {
		try {
			log.info("Getting active Article pageable");
			return articleRepository.getPageableActive(pageable);
		} catch (Exception e) {
			log.error("Error getting active Article pageable: {}", e.getMessage(), e);
			throw new Exception("Failed to get active Article pageable: " + e.getMessage(), e);
		}
	}
	
	@Override
	public List<Article> getByStatus(ArticleStatus status) throws Exception {
		try {
			log.info("Getting Articles by status: {}", status);
			return articleRepository.findByStatus(status);
		} catch (Exception e) {
			log.error("Error getting Articles by status: {}", e.getMessage(), e);
			throw new Exception("Failed to get Articles by status: " + e.getMessage(), e);
		}
	}
	
	@Override
	public ArticleWrapper getArticleWrapperByNo(Long no) throws Exception {
		try {
			log.info("Getting Article Wrapper by No: {}", no);
			Article article = getByNo(no);
			return ArticleConvertUtil.convertToWrapper(article);
		} catch (Exception e) {
			log.error("Error getting Article Wrapper by No: {}", e.getMessage(), e);
			throw new Exception("Failed to get Article Wrapper: " + e.getMessage(), e);
		}
	}
	
	@Override
	public Article saveAsDraft(Long id, String title, String category, String content) throws Exception {
		try {
			log.info("=== SAVE AS DRAFT START ===");
			log.info("Auto-saving article as draft: id={}, title={}", id, title);
			
			Article article;
			boolean isNewArticle = false;
			if (id != null) {
				// Update existing draft
				log.info("Updating existing draft with ID: {}", id);
				article = getById(id);
			} else {
				// Create new draft
				log.info("Creating new draft");
				article = new Article();
				isNewArticle = true;
				// Version and deleted will be initialized by JPA
				article.setStatus(com.project.cepat.kelar.common.constant.ArticleStatus.DRAFT);
				article.setPublishDate(new java.util.Date());
			}
			
			// Update fields if not null/empty
			if (title != null && !title.trim().isEmpty()) {
				article.setTitle(title);
			}
			if (category != null && !category.trim().isEmpty()) {
				article.setCategory(category);
			}
			if (content != null && !content.trim().isEmpty()) {
				article.setContent(content);
			}
			
			// Keep existing non-draft status for existing articles to avoid accidental demotion.
			if (isNewArticle || article.getStatus() == null) {
				article.setStatus(com.project.cepat.kelar.common.constant.ArticleStatus.DRAFT);
			}
			
			log.info("Saving draft to database");
			Article savedArticle = save(article);
			log.info("=== SAVE AS DRAFT END (SUCCESS) ===");
			return savedArticle;
			
		} catch (Exception e) {
			log.error("=== SAVE AS DRAFT END (ERROR) ===");
			log.error("Error saving draft: {}", e.getMessage(), e);
			throw new Exception("Failed to save draft: " + e.getMessage(), e);
		}
	}
	
	@Override
	public List<Article> getDraftArticles() throws Exception {
		try {
			log.info("Getting draft articles");
			List<Article> drafts = articleRepository.findByStatus(com.project.cepat.kelar.common.constant.ArticleStatus.DRAFT);
			log.info("Found {} draft articles", drafts.size());
			return drafts;
		} catch (Exception e) {
			log.error("Error getting draft articles: {}", e.getMessage(), e);
			throw new Exception("Failed to get draft articles: " + e.getMessage(), e);
		}
	}
	
	@Override
	public long countDraftArticles() throws Exception {
		try {
			log.info("Counting draft articles");
			long count = articleRepository.findByStatus(com.project.cepat.kelar.common.constant.ArticleStatus.DRAFT).size();
			log.info("Found {} draft articles", count);
			return count;
		} catch (Exception e) {
			log.error("Error counting draft articles: {}", e.getMessage(), e);
			throw new Exception("Failed to count draft articles: " + e.getMessage(), e);
		}
	}
	
	@Override
	public Article saveFromWrapper(ArticleWrapper wrapper, MultipartFile coverImageFile) throws Exception {
		try {
			log.info("=== SAVE ARTICLE START ===");
			log.info("Saving Article from wrapper: {}", wrapper.getTitle());
			
			Article article;
			if (wrapper.getNo() != null) {
				// Update existing article
				log.info("Updating existing article with ID: {}", wrapper.getNo());
				article = getById(wrapper.getNo());
			} else {
				// Create new article
				log.info("Creating new article");
				article = new Article();
			}
			
			// Set fields from wrapper
			log.info("Setting article fields: title={}, category={}", wrapper.getTitle(), wrapper.getCategory());
			article.setTitle(wrapper.getTitle());
			article.setCategory(wrapper.getCategory());
			article.setContent(wrapper.getContent());
			if (wrapper.getStatus() != null) {
				article.setStatus(wrapper.getStatus());
				if (wrapper.getStatus() == ArticleStatus.PUBLISHED && article.getPublishDate() == null) {
					article.setPublishDate(new Date());
				}
			} else if (article.getStatus() == null) {
				article.setStatus(ArticleStatus.PUBLISHED);
				if (article.getPublishDate() == null) {
					article.setPublishDate(new Date());
				}
			}
			
			// Handle cover image - save to database only
			if (coverImageFile != null && !coverImageFile.isEmpty()) {
				log.info("Processing cover image: {}", coverImageFile.getOriginalFilename());
				try {
					// Store original filename as reference
					String originalFilename = coverImageFile.getOriginalFilename();
					article.setCoverImage(originalFilename);
					log.info("Cover image filename set: {}", originalFilename);
					
					// Save image bytes to database BLOB
					byte[] imageBytes = coverImageFile.getBytes();
					log.info("Storing image to database: {} bytes", imageBytes.length);
					article.setCoverImageData(imageBytes);
					log.info("Image data set to article entity");
				} catch (IOException e) {
					log.warn("Failed to process image file: {} - proceeding without image", e.getMessage());
					// Don't fail the save if image processing fails
				}
			}
			
			log.info("About to persist article to database");
			log.info("Article state before save: title={}, coverImage={}, coverImageData size={}", 
				article.getTitle(), 
				article.getCoverImage(),
				article.getCoverImageData() != null ? article.getCoverImageData().length : 0);
			
			Article savedArticle = save(article);
			log.info("Article persisted successfully with ID: {}", savedArticle.getId());
			log.info("=== SAVE ARTICLE END (SUCCESS) ===");
			
			return savedArticle;
		} catch (IOException ioEx) {
			log.error("=== SAVE ARTICLE END (IO ERROR) ===");
			log.error("IO Exception during article save: {}", ioEx.getMessage(), ioEx);
			throw new Exception("File processing failed: " + ioEx.getMessage(), ioEx);
		} catch (Exception e) {
			log.error("=== SAVE ARTICLE END (EXCEPTION) ===");
			log.error("Exception during article save: {}", e.getMessage());
			log.error("Exception type: {}", e.getClass().getName());
			log.error("Stack trace: ", e);
			throw e;
		}
	}
	
}
