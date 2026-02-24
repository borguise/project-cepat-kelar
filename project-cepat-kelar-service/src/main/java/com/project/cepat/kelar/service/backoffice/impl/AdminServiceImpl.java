package com.project.cepat.kelar.service.backoffice.impl;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.project.cepat.kelar.common.wrapper.AdminWrapper;
import com.project.cepat.kelar.jpa.model.Admin;
import com.project.cepat.kelar.jpa.model.User;
import com.project.cepat.kelar.jpa.repository.AdminRepository;
import com.project.cepat.kelar.jpa.repository.UserRepository;
import com.project.cepat.kelar.service.backoffice.AdminService;
import com.project.cepat.kelar.service.backoffice.util.AdminConvertUtil;

import lombok.extern.log4j.Log4j2;

@Service
@Transactional
@Log4j2
public class AdminServiceImpl implements AdminService {
	
	@Autowired
	private AdminRepository adminRepository;
	
	@Autowired
	private UserRepository userRepository;
	
	@Override
	public Long getNum() {
		return adminRepository.count();
	}
	
	@Override
	public Admin save(Admin entity) throws Exception {
		try {
			log.info("Saving Admin with User: {}", entity.getUserNo().getUsername());
			return adminRepository.save(entity);
		} catch (Exception e) {
			log.error("Error saving Admin: {}", e.getMessage(), e);
			throw new Exception("Failed to save Admin: " + e.getMessage(), e);
		}
	}
	
	@Override
	public Admin getById(Long pk) throws Exception {
		try {
			log.info("Getting Admin by ID: {}", pk);
			Optional<Admin> admin = adminRepository.findById(pk);
			if (admin.isPresent()) {
				return admin.get();
			}
			throw new Exception("Admin not found with ID: " + pk);
		} catch (Exception e) {
			log.error("Error getting Admin by ID: {}", e.getMessage(), e);
			throw new Exception("Failed to get Admin: " + e.getMessage(), e);
		}
	}
	
	@Override
	public Boolean delete(Long pk) throws Exception {
		try {
			log.info("Deleting Admin with ID: {}", pk);
			Optional<Admin> admin = adminRepository.findById(pk);
			if (admin.isPresent()) {
				Admin adminEntity = admin.get();
				adminEntity.setDeleted(1);
				adminRepository.save(adminEntity);
				return true;
			}
			throw new Exception("Admin not found with ID: " + pk);
		} catch (Exception e) {
			log.error("Error deleting Admin: {}", e.getMessage(), e);
			throw new Exception("Failed to delete Admin: " + e.getMessage(), e);
		}
	}
	
	@Override
	public List<Admin> getAll() throws Exception {
		try {
			log.info("Getting all Admin");
			return adminRepository.findAll();
		} catch (Exception e) {
			log.error("Error getting all Admin: {}", e.getMessage(), e);
			throw new Exception("Failed to get all Admin: " + e.getMessage(), e);
		}
	}
	
	@Override
	public Admin getByNo(Long no) throws Exception {
		try {
			log.info("Getting Admin by No: {}", no);
			Optional<Admin> admin = adminRepository.findById(no);
			if (admin.isPresent()) {
				return admin.get();
			}
			throw new Exception("Admin not found with No: " + no);
		} catch (Exception e) {
			log.error("Error getting Admin by No: {}", e.getMessage(), e);
			throw new Exception("Failed to get Admin: " + e.getMessage(), e);
		}
	}
	
	@Override
	public Admin getByUser(User userNo) throws Exception {
		try {
			log.info("Getting Admin by User: {}", userNo.getUsername());
			Optional<Admin> admin = adminRepository.findByUserNo(userNo);
			if (admin.isPresent()) {
				return admin.get();
			}
			throw new Exception("Admin not found for User: " + userNo.getUsername());
		} catch (Exception e) {
			log.error("Error getting Admin by User: {}", e.getMessage(), e);
			throw new Exception("Failed to get Admin: " + e.getMessage(), e);
		}
	}
	
	@Override
	public Page<Admin> getPageable(String text, Pageable pageable) throws Exception {
		try {
			log.info("Getting Admin pageable with text: {}", text);
			return adminRepository.getPageable(text, pageable);
		} catch (Exception e) {
			log.error("Error getting Admin pageable: {}", e.getMessage(), e);
			throw new Exception("Failed to get Admin pageable: " + e.getMessage(), e);
		}
	}
	
	@Override
	public Page<Admin> getPageableActive(Pageable pageable) throws Exception {
		try {
			log.info("Getting active Admin pageable");
			return adminRepository.getPageableActive(pageable);
		} catch (Exception e) {
			log.error("Error getting active Admin pageable: {}", e.getMessage(), e);
			throw new Exception("Failed to get active Admin pageable: " + e.getMessage(), e);
		}
	}
	
   @Override
	public AdminWrapper getAdminByUserNo(Long userNo) throws Exception {
		try {
			log.info("Getting Admin Wrapper by User No: {}", userNo);
			Optional<User> user = userRepository.findByNo(userNo);
			if (user.isPresent()) {
				Optional<Admin> admin = adminRepository.findByUserNo(user.get());
				if (admin.isPresent()) {
					return AdminConvertUtil.toAdminWrapper(admin.get());
				}
				throw new Exception("Admin not found for User No: " + userNo);
			}
			throw new Exception("User not found with No: " + userNo);
		} catch (Exception e) {
			log.error("Error getting Admin Wrapper by User No: {}", e.getMessage(), e);
			throw new Exception("Failed to get Admin Wrapper: " + e.getMessage(), e);
		}
	}
}
