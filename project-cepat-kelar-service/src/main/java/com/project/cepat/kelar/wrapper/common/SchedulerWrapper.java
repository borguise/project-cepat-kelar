package com.project.cepat.kelar.wrapper.common;

import com.project.cepat.kelar.common.wrapper.AuditableBaseWrapper;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper = false)
public class SchedulerWrapper extends AuditableBaseWrapper {

	private static final long serialVersionUID = 3189760042191280461L;
	
	public final String dateFormat = "dd MMMM yyyy - HH:mm";
    public final String timeFormat = "HH:mm";

    private String scheduleType;
    private String schedulerName;
    private String scheduleDate;
    private String scheduleTime;
    private Boolean active;
    private String className;

}
