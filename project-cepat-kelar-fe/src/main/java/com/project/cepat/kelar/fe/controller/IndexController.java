package com.project.cepat.kelar.fe.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.MessageSource;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.project.cepat.kelar.common.controller.BaseController;
import com.project.cepat.kelar.common.util.FileUploadUtil;
import com.project.cepat.kelar.common.web.JsonMessage;
import com.project.cepat.kelar.common.web.UserContext;
import com.project.cepat.kelar.common.wrapper.LoggedUserWrapper;
import com.project.cepat.kelar.service.common.ApplicationConfigService;
import com.project.cepat.kelar.service.common.ApplicationNotificationService;

import jakarta.servlet.http.HttpServletResponse;

@Controller
public class IndexController extends BaseController {

	private static final Logger logger = LoggerFactory.getLogger(IndexController.class);
	
    @Autowired(required = false)
    private ApplicationNotificationService applicationNotificationService;
    @Autowired(required = false)
    private ApplicationConfigService applicationConfigService;
    @Autowired(required = false)
    private FileUploadUtil fileUploadUtil;
    @Autowired(required = false)
    private MessageSource messageSource;
    
    @Value("${google.recaptcha.url}")
    private String googleRecaptchaUrl;
    
    @Value("${google.recaptcha.secretkey}")
    private String googleRecaptchaSecretKey;

    @Value("${domain.root}")
    private String domainRoot;
    
    @Value("${email.address.whiteDomainList}")
    private String whiteDomainList;

    @Value("${spring.app.protocol}")
    private String protocol;
    
    @Value("${server.session.cookie.domain}")
	private String domain;
    
    private Pattern regexPattern;
    private Matcher regMatcher;
    
    
    public IndexController() {
        // Default constructor
    }

	@GetMapping("/forwardSuccessLogin")
	public ModelAndView forwardSuccessLogin(UserContext user){
		
		StringBuilder redirectUrl = new StringBuilder("redirect:");
		redirectUrl.append(protocol);
		redirectUrl.append("://");
		
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		LoggedUserWrapper loggedUser = LoggedUserWrapper.build(authentication);
    	
    	redirectUrl.append(domainRoot);
            
            if(null != loggedUser.getRole()) {
            	
            	switch (loggedUser.getRole()) {
            	
					case SYSTEM:
						redirectUrl.append("/mainPageAdmin");
						break;
					case ADMIN:
						redirectUrl.append("/mainPageAdmin");
						break;
					case ADMIN_HR:
						redirectUrl.append("/mainPageAdmin");
						break;
					case MANAGER_HR:
						redirectUrl.append("/mainPageAdmin");
						break;
					case EMPLOYEE:
						redirectUrl.append("/mainPageUser");
						break;
					default:
						redirectUrl.append("/403");
						break;
				}
            	
            }

//    	}

		logger.debug("/forwardSuccessLogin({})", redirectUrl.toString());
		return new ModelAndView(redirectUrl.toString());
	}

	/**
	 * <h3>Production and development switching</h3> related to
	 * {@link com.pst.whee.pos.frontend.config.WebMvcConfig}
	 * <p>
	 * * Kalo mo deploy production tapi landing page pake tetap versi satu maka
	 * pilih yang ini <br>
	 * <u>@RequestMapping(value = {"/", "/index", "/businessPage"})</u>
	 * </p>
	 * <p>
	 * * Kalo mo deploy production tapi landing page pake versi dua maka pilih yang
	 * ini <br>
	 * <u>@RequestMapping(value = {"/businessPage"})</u>
	 * </p>
	 */
//    @RequestMapping(value = {"/", "/index", "/businessPage"})
	@RequestMapping(value = { "/businessPage" })
	public String getBusinessPage(Map<String, Object> mapObj) {
		// String loggedUser =
		// SecurityContextHolder.getContext().getAuthentication().getName();
		/*
		 * LoggedUserWrapper authentication =
		 * securityContextUtility.getByUsername(loggedUser);
		 * mapObj.put("authentication",authentication);
		 */
		mapObj.put("domainRoot", domainRoot);
		mapObj.put("serverDate", new Date());
		mapObj.put("applicationName", applicationConfigService.getByConfigId("app.name"));
		mapObj.put("applicationDescription", applicationConfigService.getByConfigId("app.description"));
		return "businessPage";
	}

	/**
	 * Landing page v2 using Django Themes with OWL Carousel that need to have
	 * special threat please read my comment on app.js
	 */
    
    @RequestMapping(value = "/forgot_password")
    public String getForgotPassword(Map<String, Object> mapObj){
        mapObj.put("domainRoot",domainRoot);
        mapObj.put("serverDate",new Date());
        mapObj.put("applicationName", applicationConfigService.getByConfigId("app.name"));
        mapObj.put("applicationDescription", applicationConfigService.getByConfigId("app.description"));
        return "forgotPassword";
    }


    
    @RequestMapping(value = "/upload_users_file", method = RequestMethod.POST)
    public @ResponseBody JsonMessage usersInquiry(@RequestParam("uploadedFile") MultipartFile file)throws Exception{
        logger.info("Users Upload File : ");
        try {
            if (file != null) {
                String sReturn = fileUploadUtil.copyFileUploadedToTempFolder(file, "user-files_" + new SimpleDateFormat("yyyyMMddHHmmSS").format(new Date()));
                sReturn += "#"+file.getOriginalFilename();
                return JsonMessage.showInfoMessage("File Upload Succeed#" + sReturn);
            }else{
                return JsonMessage.showErrorMessage("No file detected from request", "file upload is null");
            }
        }catch (Exception e){
            logger.error("Fail /upload_users_file", e);
            return JsonMessage.showErrorMessage("File Upload Failed", e.getMessage());
        }
    }

    @RequestMapping(value = "/403")
    public String get403Exception(Map<String, Object> mapObj, Exception exception) {
//        String loggedUser = SecurityContextHolder.getContext().getAuthentication().getName();
//        LoggedUserWrapper authentication = securityContextUtility.getByUsername(loggedUser);
//        mapObj.put("authentication", authentication);
		mapObj.put("errorInfo", exception);
		return "error/403";
	}

	@RequestMapping(value = "/404")
	public String get404Exception(Map<String, Object> mapObj, Exception exception) {
//        String loggedUser = SecurityContextHolder.getContext().getAuthentication().getName();
//        LoggedUserWrapper authentication = securityContextUtility.getByUsername(loggedUser);
//        mapObj.put("authentication", authentication);
		mapObj.put("errorInfo", exception);
		return "error/404";
	}


	@RequestMapping(value = {"/admin/signin" })
	public String getSignIn(@RequestParam(value = "error", required = false) String error,
			Map<String, Object> mapObj) {
		try {
			mapObj.put("domainRoot", domainRoot != null ? domainRoot : "http://localhost:8080");
			mapObj.put("serverDate", new Date());
			if (error != null) {
				mapObj.put("error", "Email atau password salah");
			}
			if (applicationConfigService != null) {
				try {
					mapObj.put("applicationName", applicationConfigService.getByConfigId("app.name"));
					mapObj.put("applicationDescription", applicationConfigService.getByConfigId("app.description"));
				} catch (Exception e) {
					logger.warn("Error loading application config", e);
					mapObj.put("applicationName", "Project Cepat Kelar");
					mapObj.put("applicationDescription", "Admin Management System");
				}
			} else {
				mapObj.put("applicationName", "Project Cepat Kelar");
				mapObj.put("applicationDescription", "Admin Management System");
			}
		} catch (Exception e) {
			logger.error("Error in getSignIn", e);
			mapObj.put("applicationName", "Project Cepat Kelar");
			mapObj.put("applicationDescription", "Admin Management System");
		}
		return "backoffice/admin-login";
	}

	public Boolean validateEmailAddressFormat(String emailAddress) {
		regexPattern = Pattern.compile("^([a-zA-Z0-9_.+-])+\\@(([a-zA-Z0-9-])+\\.)+([a-zA-Z0-9]{2,4})+$");
		regMatcher = regexPattern.matcher(emailAddress);
		if (regMatcher.matches()) {
			return true;
		} else {
			return false;
		}
	}


}
