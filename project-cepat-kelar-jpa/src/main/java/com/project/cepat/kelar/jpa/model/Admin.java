package com.project.cepat.kelar.jpa.model;

import jakarta.persistence.Entity;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.OneToOne;
import jakarta.persistence.Table;

import com.project.cepat.kelar.common.model.ReferenceBase;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Entity
@Table(name = "admin")
@Data
@EqualsAndHashCode(callSuper = false)
public class Admin extends ReferenceBase {

	private static final long serialVersionUID = 7068429436948637109L;

	@OneToOne
	@JoinColumn(name = "USER_NO", nullable = false, unique = true)
	private User userNo;

	
}
