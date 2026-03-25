package com.project.cepat.kelar.service.backoffice;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import com.project.cepat.kelar.common.service.CommonService;
import com.project.cepat.kelar.jpa.model.Comment;

public interface CommentService extends CommonService<Comment, Long> {

    Page<Comment> getPageable(String text, Pageable pageable) throws Exception;

    Page<Comment> getPageableActive(Pageable pageable) throws Exception;

    Page<Comment> getPageablePublished(Pageable pageable) throws Exception;

    Page<Comment> getCommentsBySource(String source, Pageable pageable) throws Exception;

    Page<Comment> getCommentsByArticleId(Long articleId, Pageable pageable) throws Exception;

    Comment toggleStatus(Long id) throws Exception;
}
