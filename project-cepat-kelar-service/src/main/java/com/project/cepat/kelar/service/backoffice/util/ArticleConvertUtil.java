package com.project.cepat.kelar.service.backoffice.util;

import com.project.cepat.kelar.jpa.model.Article;
import com.project.cepat.kelar.wrapper.backoffice.ArticleWrapper;

public class ArticleConvertUtil {
	
	/**
	 * Convert Article entity to ArticleWrapper
	 * @param article
	 * @return
	 */
	public static ArticleWrapper convertToWrapper(Article article) {
		if (article == null) {
			return null;
		}
		
		ArticleWrapper wrapper = new ArticleWrapper();
		wrapper.setNo(article.getId());
		wrapper.setTitle(article.getTitle());
		wrapper.setCategory(article.getCategory());
		wrapper.setCoverImage(article.getCoverImage());
		wrapper.setCoverImageData(article.getCoverImageData());
		wrapper.setContent(article.getContent());
		wrapper.setStatus(article.getStatus());
		wrapper.setPublishDate(article.getPublishDate());
		wrapper.setStartDate(article.getStartDate());
		wrapper.setEndDate(article.getEndDate());
		wrapper.setCreatedDate(article.getCreatedDate());
		wrapper.setUpdatedDate(article.getUpdatedDate());
		wrapper.setCreatedBy(article.getCreatedBy());
		wrapper.setUpdatedBy(article.getUpdatedBy());
		wrapper.setVersion(article.getVersion());
		wrapper.setDeleted(article.getDeleted());
		
		return wrapper;
	}
	
	/**
	 * Convert ArticleWrapper to Article entity
	 * @param wrapper
	 * @return
	 */
	public static Article convertToEntity(ArticleWrapper wrapper) {
		if (wrapper == null) {
			return null;
		}
		
		Article article = new Article();
		article.setId(wrapper.getNo());
		article.setTitle(wrapper.getTitle());
		article.setCategory(wrapper.getCategory());
		article.setCoverImage(wrapper.getCoverImage());
		article.setCoverImageData(wrapper.getCoverImageData());
		article.setContent(wrapper.getContent());
		article.setStatus(wrapper.getStatus());
		article.setPublishDate(wrapper.getPublishDate());
		article.setStartDate(wrapper.getStartDate());
		article.setEndDate(wrapper.getEndDate());
		article.setVersion(wrapper.getVersion());
		article.setDeleted(wrapper.getDeleted());
		
		return article;
	}
	
	/**
	 * Convert Article entity list to ArticleWrapper list
	 * @param articles
	 * @return
	 */
	public static java.util.List<ArticleWrapper> convertToWrapperList(java.util.List<Article> articles) {
		if (articles == null || articles.isEmpty()) {
			return java.util.Collections.emptyList();
		}
		
		return articles.stream()
			.map(ArticleConvertUtil::convertToWrapper)
			.collect(java.util.stream.Collectors.toList());
	}
	
}
