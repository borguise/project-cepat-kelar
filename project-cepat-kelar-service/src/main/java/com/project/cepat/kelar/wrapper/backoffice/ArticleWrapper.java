package com.project.cepat.kelar.wrapper.backoffice;

import java.util.Date;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.project.cepat.kelar.common.constant.ArticleStatus;
import com.project.cepat.kelar.common.wrapper.ReferenceBaseWrapper;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper = false)
@JsonInclude(JsonInclude.Include.NON_NULL)
public class ArticleWrapper extends ReferenceBaseWrapper {
	
	private static final long serialVersionUID = 1L;
	
	private Long no;
	
	private String title;
	
	private String category;
	
	private String coverImage;
	
	private byte[] coverImageData;
	
	private String content;
	
	private ArticleStatus status;
	
	private Date publishDate;
	
	private Date startDate;
	
	private Date endDate;
	
}
