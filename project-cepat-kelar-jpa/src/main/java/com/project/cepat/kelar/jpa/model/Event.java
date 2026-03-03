package com.project.cepat.kelar.jpa.model;

import java.util.Date;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Table;

import com.project.cepat.kelar.common.model.ReferenceBase;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Entity
@Table(name = "event")
@Data
@EqualsAndHashCode(callSuper = false)
public class Event extends ReferenceBase {

	private static final long serialVersionUID = 345043635718537124L;

	@Column(name = "NAME")
	private String name;

	@Column(name = "EVENT_DATE")
	private Date eventDate;

	@Column(name = "LOCATION")
	private String location;

	@Column(name = "STATUS")
	private String status;

	@Column(name = "DESCRIPTION", columnDefinition = "text")
	private String description;

	@Column(name = "POSTER_IMAGE")
	private String posterImage;

	@Column(name = "POSTER_IMAGE_DATA", columnDefinition = "bytea")
	private byte[] posterImageData;
}
