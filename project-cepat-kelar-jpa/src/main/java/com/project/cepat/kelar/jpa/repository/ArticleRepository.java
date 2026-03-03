package com.project.cepat.kelar.jpa.repository;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.querydsl.QuerydslPredicateExecutor;
import org.springframework.data.repository.query.Param;

import com.project.cepat.kelar.common.constant.ArticleStatus;
import com.project.cepat.kelar.jpa.model.Article;

public interface ArticleRepository extends JpaRepository<Article, Long>, QuerydslPredicateExecutor<Article> {
	
	List<Article> findByStatus(ArticleStatus status);
	
	@Query(value = "select a from Article a where (a.title like concat('%', :text, '%') or a.category like concat('%', :text, '%')) and a.deleted = 0")
	Page<Article> getPageable(@Param("text") String text, Pageable pageable);
	
	@Query(value = "select a from Article a where a.title like concat('%', :text, '%') and a.deleted = 0")
	Page<Article> getPageableByTitle(@Param("text") String text, Pageable pageable);
	
	@Query(value = "select a from Article a where a.category like concat('%', :text, '%') and a.deleted = 0")
	Page<Article> getPageableByCategory(@Param("text") String text, Pageable pageable);
	
	@Query(value = "select a from Article a where a.deleted = 0 and a.status = :status")
	Page<Article> getPageableByStatus(@Param("status") ArticleStatus status, Pageable pageable);
	
	@Query(value = "select a from Article a where a.deleted = 0")
	Page<Article> getPageableActive(Pageable pageable);
	
}
