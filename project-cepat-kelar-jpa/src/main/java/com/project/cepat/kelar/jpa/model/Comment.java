package com.project.cepat.kelar.jpa.model;

import java.util.Date;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;

import com.project.cepat.kelar.common.model.ReferenceBase;

import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.ToString;

@Entity(name = "CommentEntity")
@Table(name = "comment")
@Data
@EqualsAndHashCode(callSuper = false)
public class Comment extends ReferenceBase {

    private static final long serialVersionUID = -5335082092622780453L;

    @Column(name = "SENDER")
    private String sender;

    @Column(name = "COMMENT_DATE")
    private Date commentDate;

    @Column(name = "CONTENT", columnDefinition = "text")
    private String content;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "ARTICLE_ID")
    @ToString.Exclude
    @EqualsAndHashCode.Exclude
    private Article article;

    @Column(name = "SOURCE")
    private String source;

    @Column(name = "STATUS")
    private String status;

    @Column(name = "USER_EMAIL")
    private String userEmail;
}
