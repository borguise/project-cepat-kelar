package com.project.cepat.kelar.service.backoffice.impl;

import java.util.Date;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.project.cepat.kelar.jpa.model.Comment;
import com.project.cepat.kelar.jpa.repository.CommentRepository;
import com.project.cepat.kelar.service.backoffice.CommentService;

import lombok.extern.log4j.Log4j2;

@Service
@Transactional
@Log4j2
public class CommentServiceImpl implements CommentService {

    @Autowired
    private CommentRepository commentRepository;

    @Override
    public Long getNum() {
        return commentRepository.count();
    }

    @Override
    public Comment save(Comment entity) throws Exception {
        if (entity.getCommentDate() == null) {
            entity.setCommentDate(new Date());
        }
        if (entity.getStatus() == null || entity.getStatus().isEmpty()) {
            entity.setStatus("Hidden");
        }
        return commentRepository.save(entity);
    }

    @Override
    public Comment getById(Long pk) throws Exception {
        Optional<Comment> optional = commentRepository.findById(pk);
        if (optional.isPresent()) {
            return optional.get();
        }
        return null;
    }

    @Override
    public Boolean delete(Long pk) throws Exception {
        Optional<Comment> optional = commentRepository.findById(pk);
        if (optional.isPresent()) {
            Comment comment = optional.get();
            comment.setDeleted(1);
            commentRepository.save(comment);
            return true;
        }
        return false;
    }

    @Override
    public List<Comment> getAll() throws Exception {
        return commentRepository.findAll();
    }

    @Override
    public Page<Comment> getPageable(String text, Pageable pageable) throws Exception {
        if (text == null || text.trim().isEmpty()) {
            return getPageableActive(pageable);
        }
        return commentRepository.getPageable(text, pageable);
    }

    @Override
    public Page<Comment> getPageableActive(Pageable pageable) throws Exception {
        return commentRepository.getPageableActive(pageable);
    }

    @Override
    public Page<Comment> getPageablePublished(Pageable pageable) throws Exception {
        return commentRepository.getPageablePublished(pageable);
    }

    @Override
    public Page<Comment> getCommentsBySource(String source, Pageable pageable) throws Exception {
        return commentRepository.getCommentsBySource(source, pageable);
    }

    @Override
    public Page<Comment> getCommentsByArticleId(Long articleId, Pageable pageable) throws Exception {
        return commentRepository.getCommentsByArticleId(articleId, pageable);
    }

    @Override
    public Comment toggleStatus(Long id) throws Exception {
        Optional<Comment> optional = commentRepository.findById(id);
        if (optional.isPresent()) {
            Comment comment = optional.get();
            if ("Published".equals(comment.getStatus())) {
                comment.setStatus("Hidden");
            } else {
                comment.setStatus("Published");
            }
            return commentRepository.save(comment);
        }
        throw new Exception("Comment not found with id: " + id);
    }
}
