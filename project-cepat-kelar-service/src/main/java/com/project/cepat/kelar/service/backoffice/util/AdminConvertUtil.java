package com.project.cepat.kelar.service.backoffice.util;

import com.project.cepat.kelar.common.wrapper.AdminWrapper;
import com.project.cepat.kelar.jpa.model.Admin;

public class AdminConvertUtil {
	
	/**
	 * Convert Admin entity to AdminWrapper
	 * @param admin
	 * @return
	 */
	public static AdminWrapper toAdminWrapper(Admin admin) {
		if (admin == null) {
			return null;
		}
		
		AdminWrapper wrapper = new AdminWrapper();
		// wrapper.setNo(admin.getNo());
		wrapper.setUserNo(admin.getUserNo() != null ? admin.getUserNo().getNo() : null);
		wrapper.setUsername(admin.getUserNo() != null ? admin.getUserNo().getUsername() : null);
		wrapper.setEmail(admin.getUserNo() != null ? admin.getUserNo().getEmail() : null);
		// wrapper.setFullName(admin.getUserNo() != null ? admin.getUserNo().getFullName() : null);
		wrapper.setCreatedDate(admin.getCreatedDate());
		wrapper.setUpdatedDate(admin.getUpdatedDate());
		wrapper.setVersion(admin.getVersion());
		wrapper.setDeleted(admin.getDeleted());
		
		return wrapper;
	}
	
	/**
	 * Convert Admin entity to AdminWrapper (batch)
	 * @param admins
	 * @return
	 */
	public static java.util.List<AdminWrapper> toAdminWrapperList(java.util.List<Admin> admins) {
		if (admins == null || admins.isEmpty()) {
			return java.util.Collections.emptyList();
		}
		
		return admins.stream()
			.map(AdminConvertUtil::toAdminWrapper)
			.collect(java.util.stream.Collectors.toList());
	}
	
}
