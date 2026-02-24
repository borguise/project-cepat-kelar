package com.project.cepat.kelar.common.wrapper;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.WebAuthenticationDetails;

import com.project.cepat.kelar.common.constant.AppConstant;

import jakarta.servlet.http.HttpServletRequest;
import lombok.Data;

@Data
public class LoggedUserWrapper implements Serializable {

	private static final long serialVersionUID = -7112286365899288190L;

	private String username;
	private String name;
	private String role;
	private String userType;
	private String email;
	private List<String> menuList = new ArrayList<String>();
	
	public void addMenu(String... menuUrls) {
		for (String mu : menuUrls) {
			menuList.add(mu);
		}
	}
	
	public static LoggedUserWrapper build(Authentication authentication) {
		
		Map authInfo = null;
		LoggedUserWrapper loggedUser = new LoggedUserWrapper();
		
		// if no login user, it will cast as WebAuthenticationDetails
		if(authentication.getDetails() instanceof WebAuthenticationDetails) {
		} else { // if theres login user, it will cast as HashMap
			authInfo = (HashMap) authentication.getDetails();
		}
		
		if(null != authentication && null != authInfo) {
			loggedUser = (LoggedUserWrapper) authInfo.get("loggedUser");
		}
		
		return loggedUser;
	}
	
	public static LoggedUserWrapper build(HttpServletRequest request) {
		LoggedUserWrapper loggedUser = new LoggedUserWrapper();
		loggedUser.setUsername(String.valueOf(request.getAttribute(AppConstant.TokenInfo.USERNAME)));
		loggedUser.setRole(String.valueOf(request.getAttribute(AppConstant.TokenInfo.ROLE)));
		return loggedUser;
	}

}
