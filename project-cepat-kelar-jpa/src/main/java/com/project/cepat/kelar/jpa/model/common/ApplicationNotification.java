package com.project.cepat.kelar.jpa.model.common;

import java.util.Date;

import com.project.cepat.kelar.common.model.AuditableBase;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Table;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Entity
@Table(name = "application_notification")
@Data
@EqualsAndHashCode(callSuper = false)
public class ApplicationNotification extends AuditableBase {

	private static final long serialVersionUID = 8660117068756972365L;

	@Column(name = "NOTIFICATION_NAME", length = 150, nullable = false)
	private String notificationName;

	@Column(name = "NOTIFICATION_TYPE", length = 1, nullable = false)
	private Integer notificationType;

	@Column(name = "NOTIFICATION_START_DATE", nullable = false)
	private Date notificationStartDate;

	@Column(name = "NOTIFICATION_END_DATE", nullable = false)
	private Date notificationEndDate;

	@Column(name = "ACTIVE", nullable = false)
	private Boolean active;

	@Column(name = "RECEIVER", length = 1500)
	private String notificationReceiver;

}
