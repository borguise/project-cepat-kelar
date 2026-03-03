package com.project.cepat.kelar.service.backoffice;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.web.multipart.MultipartFile;

import com.project.cepat.kelar.common.constant.ArticleStatus;
import com.project.cepat.kelar.common.service.CommonService;
import com.project.cepat.kelar.jpa.model.Article;
import com.project.cepat.kelar.wrapper.backoffice.ArticleWrapper;

public interface ArticleService extends CommonService<Article, Long> {
	
	/**
	 * Get Article by No
	 * @param no
	 * @return
	 * @throws Exception
	 */
	Article getByNo(Long no) throws Exception;
	
	/**
	 * Get Article pagination with text search
	 * @param text
	 * @param pageable
	 * @return
	 * @throws Exception
	 */
	Page<Article> getPageable(String text, Pageable pageable) throws Exception;
	
	/**
	 * Get Article pagination by title search
	 * @param text
	 * @param pageable
	 * @return
	 * @throws Exception
	 */
	Page<Article> getPageableByTitle(String text, Pageable pageable) throws Exception;
	
	/**
	 * Get Article pagination by category search
	 * @param text
	 * @param pageable
	 * @return
	 * @throws Exception
	 */
	Page<Article> getPageableByCategory(String text, Pageable pageable) throws Exception;
	
	/**
	 * Get Active Article pagination
	 * @param pageable
	 * @return
	 * @throws Exception
	 */
	Page<Article> getPageableActive(Pageable pageable) throws Exception;
	
	/**
	 * Get Article by Status
	 * @param status
	 * @return
	 * @throws Exception
	 */
	List<Article> getByStatus(ArticleStatus status) throws Exception;
	
	/**
	 * Get Article Wrapper by No
	 * @param no
	 * @return
	 * @throws Exception
	 */
	ArticleWrapper getArticleWrapperByNo(Long no) throws Exception;
	
	/**
	 * Save Article from Wrapper
	 * @param wrapper
	 * @param coverImageFile
	 * @return
	 * @throws Exception
	 */
	Article saveFromWrapper(ArticleWrapper wrapper, MultipartFile coverImageFile) throws Exception;
	
	/**
	 * Save Article as Draft (auto-save)
	 * @param id
	 * @param title
	 * @param category
	 * @param content
	 * @return
	 * @throws Exception
	 */
	Article saveAsDraft(Long id, String title, String category, String content) throws Exception;
	
	/**
	 * Get all Articles
	 * @return
	 * @throws Exception
	 */
	@Override
	List<Article> getAll() throws Exception;
	
	/**
	 * Get Draft Articles
	 * @return
	 * @throws Exception
	 */
	List<Article> getDraftArticles() throws Exception;
	
	/**
	 * Count Draft Articles
	 * @return
	 * @throws Exception
	 */
	long countDraftArticles() throws Exception;
	
}
