package com.project.cepat.kelar.jpa.model.common;

import com.project.cepat.kelar.common.model.AuditableBase;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Table;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Entity
@Table(name = "application_config")
@Data
@EqualsAndHashCode(callSuper = false)
public class ApplicationConfig extends AuditableBase {

	private static final long serialVersionUID = -1713369529741182727L;

	@Column(name = "CONFIG_ID", length = 100, unique = true)
	private String configId;

	@Column(name = "CONFIG_VALUE", length = 255)
	private String configValue;
}
