package com.project.cepat.kelar.common.web;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;

import com.project.cepat.kelar.common.constant.AppConstant;
import com.project.cepat.kelar.common.constant.AppTimeZone;

import io.micrometer.common.util.StringUtils;
import jakarta.servlet.http.HttpServletRequest;
import lombok.Getter;
import lombok.Setter;


public class UserContext implements Serializable {
	
	private static final long serialVersionUID = 7173516933346271212L;

	private static final Logger log = LoggerFactory.getLogger(UserContext.class);
	
	@Getter
    private final String username;
	@Getter
    private final List<GrantedAuthority> authorities;
	@Getter
    private final Long userNo;
	@Getter
    private final String userEmail;
	@Getter
    private final String userMobile;
	@Getter
    private AppTimeZone timezone;
	
	@Getter
	@Setter
	private Object authentication;
	@Setter
	private boolean hasAccessForMenuUri; // has access to specified Menu URI (applicable only for SmartDashboard)
	
	private String role;

    private UserContext(String username, List<GrantedAuthority> authorities, Long userNo,
    		String userEmail, String userMobile) {
        this.username = username;
        this.authorities = authorities;
        this.userNo = userNo;
        this.userEmail = userEmail;
        this.userMobile = userMobile;
        String name = SecurityContextHolder.getContext().getAuthentication().getName();
        AppTimeZone timezoneGmt = null ;
        if(!name.equals("anonymousUser")) {
        	Map details = (HashMap) SecurityContextHolder.getContext().getAuthentication().getDetails();
        	Object object = details.get("timezone");
        	timezoneGmt = (AppTimeZone) object;
        }
        this.timezone = timezoneGmt;
    }
    
    private UserContext(String username, Collection<GrantedAuthority> authorities, Long userNo,
    		String userEmail, String userMobile) {
        this.username = username;
        this.authorities = new ArrayList<GrantedAuthority>();
        for (GrantedAuthority ga : authorities) {
        	this.authorities.add(new SimpleGrantedAuthority((ga.getAuthority().split("=")[1]).replaceAll("}", "")));
		}
        this.userNo = userNo;
        this.userEmail = userEmail;
        this.userMobile = userMobile;
    }
    
    @Deprecated
    public static UserContext create(String username, List<GrantedAuthority> authorities) {
        if (StringUtils.isBlank(username)) throw new IllegalArgumentException("Username is blank: " + username);
        return new UserContext(username, authorities, null, null, null);
    }
    
    @Deprecated
    public static UserContext build(String username, Collection<GrantedAuthority> authorities) {
        if (StringUtils.isBlank(username)) throw new IllegalArgumentException("Username is blank: " + username);
        return new UserContext(username, authorities, null, null, null);
    }
    
    /**
     * applicable for SmartDashboard
     * 
     * @param request
     * @return
     */
    public static UserContext build(HttpServletRequest request) {
    	
    	Long userNo = null, accountId = null, storeId = null, employeeId = null;
    	String userName = null, userEmail = null, userMobile = null;
    	List<GrantedAuthority> authorities = null;
    	
    	String userNoStr = String.valueOf(null != request.getAttribute(AppConstant.TokenInfo.USER_NO) 
    			? request.getAttribute(AppConstant.TokenInfo.USER_NO) : "-666");
    	userNo = Long.valueOf(userNoStr);
    	
    	userName = String.valueOf(request.getAttribute(AppConstant.TokenInfo.USERNAME));
    	userEmail = String.valueOf(request.getAttribute(AppConstant.TokenInfo.USER_EMAIL));
    	userMobile = String.valueOf(request.getAttribute(AppConstant.TokenInfo.USER_MOBILE));
    	
    	authorities = (ArrayList<GrantedAuthority>) request.getAttribute(AppConstant.TokenInfo.AUTHORITIES);
    	
    	return new UserContext(userName, authorities, userNo, userEmail, userMobile);
    }
    
    /**
     * applicable for Mobile API
     * 
     * @param auth
     * @return
     */
    public static UserContext build(Authentication auth) {
        
        Long userNo = null;
        String userEmail = null, userMobile = null;
        
        return new UserContext((String) auth.getPrincipal(), new ArrayList<>(auth.getAuthorities()), userNo, userEmail, userMobile);
    }

    public boolean hasAccess() {
		return hasAccessForMenuUri;
	}
    
	public String getRole() {
		List<LinkedHashMap<String, String>> authoritiesMap = (ArrayList) authorities;
    	LinkedHashMap<String, String> map = authoritiesMap.get(0);
    	for (String key : map.keySet()) {
			role = map.get(key);
		}
    	return role;
	}

}
