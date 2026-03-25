package com.project.cepat.kelar.fe.controller.backoffice;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;

import com.project.cepat.kelar.common.controller.BaseController;
import com.project.cepat.kelar.common.constant.ArticleStatus;
import com.project.cepat.kelar.service.backoffice.AdminService;

@Controller
@RequestMapping("/admin")
public class BackofficeController extends BaseController {
	
	private static final Logger logger = LoggerFactory.getLogger(BackofficeController.class);
	
	@Autowired(required = false)
	private AdminService adminService;
	
	@Autowired(required = false)
	private com.project.cepat.kelar.service.backoffice.ArticleService articleService;
	
	@Autowired(required = false)
	private com.project.cepat.kelar.service.backoffice.EventService eventService;

	@Autowired(required = false)
	private com.project.cepat.kelar.service.backoffice.CollectionService collectionService;
	
	@Override
	public String pageTitle() {
		return "Backoffice";
	}
	
	/**
	 * Backoffice dashboard page
	 */
	@GetMapping({"", "/dashboard"})
	public String dashboard(ModelMap model) throws Exception {
		try {
			logger.info("Loading backoffice dashboard page");
			
			// Resolve admin name using service
			if (adminService != null) {
				Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
				String adminName = adminService.resolveAdminName(authentication);
				model.addAttribute("adminName", adminName);
				
				long totalAdmins = adminService.getNum();
				model.addAttribute("totalAdmins", totalAdmins);
			}
			
			// Load statistics for dashboard
			if (articleService != null) {
				try {
					long totalPublished = articleService.getByStatus(ArticleStatus.PUBLISHED).size();
					model.addAttribute("totalArticles", totalPublished);
					long totalCollections = (collectionService != null)
							? collectionService.getPageableActive(org.springframework.data.domain.PageRequest.of(0, 1)).getTotalElements()
							: 0;
					model.addAttribute("totalCollections", totalCollections);
					long totalEvents = (eventService != null) ? eventService.getNum() : 0;
					model.addAttribute("totalEvents", totalEvents);
					
					// Load draft articles for dashboard display
					var draftArticles = articleService.getDraftArticles();
					model.addAttribute("draftArticles", draftArticles);
					logger.info("Loaded dashboard statistics and {} draft articles", draftArticles.size());
				} catch (Exception e) {
					logger.error("Error loading dashboard statistics: {}", e.getMessage());
					// Continue even if statistics loading fails
					model.addAttribute("totalArticles", 0);
					model.addAttribute("totalCollections", 0);
					model.addAttribute("totalEvents", 0);
					model.addAttribute("draftArticles", new java.util.ArrayList<>());
				}
			}
			
			return "backoffice/admin-dashboard";
		} catch (Exception e) {
			logger.error("Error loading backoffice dashboard page: {}", e.getMessage(), e);
			throw e;
		}
	}
	
}
