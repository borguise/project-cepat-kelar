package com.project.cepat.kelar.jpa.model;

import java.util.Date;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import jakarta.persistence.Lob;
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

	@Lob
	@Column(name = "CONTENT")
	private String content;

	@Column(name = "STATUS")
	@Enumerated(EnumType.STRING)
	private ArticleStatus status;

	// @OneToOne
	// @JoinColumn(name = "EMPLOYEE_ID", nullable = false)
	// private Employee employee;
	
	@Column(name = "START_DATE")
	private Date startDate;
	
	@Column(name = "END_DATE")
	private Date endDate;
	
	
	
	
	
	// @OneToMany(fetch = FetchType.LAZY, cascade = CascadeType.ALL, orphanRemoval = true, mappedBy = "wFHRequest")
	// private List<WFHRequestDetail> wFHRequestDetailList = new ArrayList<>();
	
	// public void addWFHRequestDetail(WFHRequestDetail wFHRequestDetail) {
	// 	wFHRequestDetail.setWFHRequest(this);
	// 	if (getWFHRequestDetailList() == null)
	// 		setWFHRequestDetailList(new ArrayList<WFHRequestDetail>());
	// 	getWFHRequestDetailList().add(wFHRequestDetail);
	// }
}
