package com.project.cepat.kelar.fe.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import com.project.cepat.kelar.common.constant.AppConstant;
import com.project.cepat.kelar.common.controller.BaseController;
import com.project.cepat.kelar.common.web.UserContext;
import com.project.cepat.kelar.common.wrapper.AdminWrapper;
import com.project.cepat.kelar.service.backoffice.AdminService;


@Controller
public class MainPageController extends BaseController {
	private static final Logger logger = LoggerFactory.getLogger(MainPageController.class);
	
	@Autowired(required = false)
	private AdminService adminService;

	@Override
    public String pageTitle() {
    	return "Main Page";
    }
	
	@RequestMapping(value = { "/mainPage" })
	public String mainPage(UserContext user, ModelMap map) throws Exception {
		map.put(AppConstant.TokenInfo.MENU_CLUSTER, AppConstant.ClusterCode.getCode(user.getRole()));
		return "backoffice/mainPageAdmin";
	}

	@RequestMapping(value = { "/mainPageUser" })
	public String mainPageUser(UserContext user, ModelMap map) throws Exception {
		map.put(AppConstant.TokenInfo.MENU_CLUSTER, AppConstant.ClusterCode.getCode(user.getRole()));
		return "backoffice/mainPageUser";
	}

	@RequestMapping(value = { "/mainPageAdmin" })
	public String mainPageAdministrator(UserContext user, ModelMap map) throws Exception {
		if (adminService != null) {
			AdminWrapper oAdmin = adminService.getAdminByUserNo(user.getUserNo());
			logger.info("path:/mainPageAdmin " + " " + oAdmin.toString());
			map.put("model", oAdmin);
		}
		return "frontoffice/mainPageAdmin";
	}
}
