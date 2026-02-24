package com.project.cepat.kelar.fe.controller.backoffice;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.project.cepat.kelar.common.controller.BaseController;
import com.project.cepat.kelar.service.backoffice.AdminService;

@Controller
@RequestMapping("/admin")
public class AdminController extends BaseController {
	
	private static final Logger logger = LoggerFactory.getLogger(AdminController.class);
	
	@Autowired(required = false)
	private AdminService adminService;
	
	@Override
	public String pageTitle() {
		return "Admin Management";
	}
	
	/**
	 * Admin list page
	 */
	@GetMapping("")
	public String adminList(ModelMap model) throws Exception {
		try {
			logger.info("Loading admin list page");
			if (adminService != null) {
				long totalAdmins = adminService.getNum();
				model.addAttribute("totalAdmins", totalAdmins);
			}
			return "backoffice/admin/list";
		} catch (Exception e) {
			logger.error("Error loading admin list page: {}", e.getMessage(), e);
			throw e;
		}
	}
	
}
