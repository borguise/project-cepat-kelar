package com.project.cepat.kelar.common.wrapper;

import com.fasterxml.jackson.annotation.JsonInclude;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper = false)
@JsonInclude(JsonInclude.Include.NON_NULL)
public class AdminWrapper extends ReferenceBaseWrapper {
	
	private static final long serialVersionUID = 1L;
	
	private Long no;
	
	private Long userNo;
	
	private String username;
	
	private String email;
	
	private String fullName;
	
}
