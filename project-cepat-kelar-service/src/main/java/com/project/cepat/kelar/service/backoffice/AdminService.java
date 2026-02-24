package com.project.cepat.kelar.service.backoffice;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import com.project.cepat.kelar.common.service.CommonService;
import com.project.cepat.kelar.jpa.model.Admin;
import com.project.cepat.kelar.jpa.model.User;

public interface AdminService extends CommonService<Admin, Long> {
	
	/**
	 * Get Admin by No
	 * @param no
	 * @return
	 * @throws Exception
	 */
	Admin getByNo(Long no) throws Exception;
	
	/**
	 * Get Admin by User
	 * @param userNo
	 * @return
	 * @throws Exception
	 */
	Admin getByUser(User userNo) throws Exception;
	
	/**
	 * Get Admin pagination with text search
	 * @param text
	 * @param pageable
	 * @return
	 * @throws Exception
	 */
	Page<Admin> getPageable(String text, Pageable pageable) throws Exception;
	
	/**
	 * Get Active Admin pagination
	 * @param pageable
	 * @return
	 * @throws Exception
	 */
	Page<Admin> getPageableActive(Pageable pageable) throws Exception;
	
	/**
	 * Get all Admin data
	 * @return
	 * @throws Exception
	 */
	@Override
	List<Admin> getAll() throws Exception;
	
	/**
	 * Get Admin Wrapper by User No
	 * @param userNo
	 * @return
	 * @throws Exception
	 */
	com.project.cepat.kelar.common.wrapper.AdminWrapper getAdminByUserNo(Long userNo) throws Exception;
	
}
