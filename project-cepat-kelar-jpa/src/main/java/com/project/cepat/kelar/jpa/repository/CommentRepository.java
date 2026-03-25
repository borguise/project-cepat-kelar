package com.project.cepat.kelar.jpa.repository;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.project.cepat.kelar.jpa.model.Comment;

public interface CommentRepository extends JpaRepository<Comment, Long> {

    @Query("SELECT c FROM CommentEntity c WHERE c.deleted = 0")
    Page<Comment> getPageableActive(Pageable pageable);

    @Query("SELECT c FROM CommentEntity c WHERE c.deleted = 0 AND (c.sender LIKE %:text% OR c.source LIKE %:text% OR c.content LIKE %:text%)")
    Page<Comment> getPageable(@Param("text") String text, Pageable pageable);

    @Query("SELECT c FROM CommentEntity c WHERE c.deleted = 0 AND c.status = 'Published'")
    Page<Comment> getPageablePublished(Pageable pageable);

    @Query("SELECT c FROM CommentEntity c WHERE c.deleted = 0 AND c.status = 'Published' AND c.source LIKE %:text%")
    Page<Comment> getCommentsBySource(@Param("text") String text, Pageable pageable);

    @Query("SELECT c FROM CommentEntity c WHERE c.deleted = 0 AND c.status = 'Published' AND c.article.id = :articleId")
    Page<Comment> getCommentsByArticleId(@Param("articleId") Long articleId, Pageable pageable);
}
