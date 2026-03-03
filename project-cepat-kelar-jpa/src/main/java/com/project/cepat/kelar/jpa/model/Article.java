package com.project.cepat.kelar.jpa.model;

import java.util.Date;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import jakarta.persistence.Table;

import com.project.cepat.kelar.common.constant.ArticleStatus;
import com.project.cepat.kelar.common.model.ReferenceBase;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Entity
@Table(name = "article")
@Data
@EqualsAndHashCode(callSuper = false)
public class Article extends ReferenceBase {

	private static final long serialVersionUID = 7068429436948637109L;

	@Column(name = "TITLE")
	private String title;

	@Column(name = "CATEGORY")
	private String category;

	@Column(name = "COVER_IMAGE")
	private String coverImage;

	@Column(name = "COVER_IMAGE_DATA", columnDefinition = "bytea")
	private byte[] coverImageData;

	@Column(name = "CONTENT", columnDefinition = "text")
	private String content;

	@Column(name = "STATUS")
	@Enumerated(EnumType.STRING)
	private ArticleStatus status;

	@Column(name = "PUBLISH_DATE")
	private Date publishDate;
	
	@Column(name = "START_DATE")
	private Date startDate;
	
	@Column(name = "END_DATE")
	private Date endDate;
}
