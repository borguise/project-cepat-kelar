package com.project.cepat.kelar.jpa.model.common;

import java.sql.Time;
import java.util.Date;

import com.project.cepat.kelar.common.model.AuditableBase;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Table;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Entity
@Table(name = "scheduler")
@Data
@EqualsAndHashCode(callSuper = false)
public class Scheduler extends AuditableBase {

	private static final long serialVersionUID = -3867889402455664310L;

	/**
	 * 1. routine or 2.on_demand if type==ROUTINE, SCHEDULE_TIME CANNOT BE NULL
	 */
	@Column(name = "SCHEDULE_TYPE", length = 2, nullable = false)
	private Integer scheduleType;

	@Column(name = "SCHEDULER_NAME", length = 100, nullable = false)
	private String schedulerName;

	@Column(name = "SCHEDULE_DATE")
	private Date scheduleDate;

	@Column(name = "SCHEDULE_TIME")
	private Time scheduleTime;

	@Column(name = "IS_ACTIVE", nullable = false)
	private Boolean active;

	@Column(name = "CLASS_NAME", length = 500)
	private String className;

}
