package com.project.cepat.kelar.common.constant;

import java.util.Base64;
import java.util.HashMap;
import java.util.Map;

public class AppConstant {
	
	public static final Long ADMIN_ACCOUNT_ID = -19l;
	public static final Long ADMIN_EMPLOYEE_ID = -13l;
	public static final Long ADMIN_STORE_ID = -7l;
	
	public static final Long ACCOUNT_EMPLOYEE_ID = -1l;
	public static final Long ACCOUNT_STORE_ID = -1l;
	
	public static final String SWAGGER_URL_WHITELIST[] = { "/swagger-resources/**", "/swagger-ui.html", "/v2/api-docs", "/webjars/**" };
	public static final String ACTUATOR_V1_URL_WHITELIST[] = { "/health", "/info", "/metrics", "/trace" };
	
	public static final String SECURITY_HTTP_BASIC_REALM_NAME = "WheeHQ";
	public static final String SECURITY_JWT_SIGN_KEY = "WheeAr3Th3Ch4mPi0ns19";
	
	public static final String OTP_SECRET_KEY = "d01b01e";

	public static final String REPORT_WHEE = "WHEE";
	public static final String REPORT_RUBICONE = "RUBICONE";
	public static final String REPORT_EXCEL_EXTENSION = "application/vnd.ms-excel";
	public static final String[] REPORT_WHEE_TO_ARRAY = {"ranggapuja@whee.co.id","rendypuja@whee.co.id"};
	public static final String[] REPORT_RUBICONE_TO_ARRAY = {"tanyajohanwijaya@gmail.com","edwardelitemarketer@gmail.com"};
	public static final String[] REPORT_EAGLE_EYE_CC_ARRAY = {"salprima@whee.co.id","pamkin@whee.co.id","dicky@whee.co.id","alman@whee.co.id","angga@whee.co.id"};
	public static final String WHEE_REFERRAL_MAIL_DOMAIN = "@mkt.whee.co.id";
	public static final String[] RUBICONE_REFERRAL_MAIL = {"tanyajohanwijaya@gmail.com","valanza.id@gmail.com"};
	
	public static final class OAuthClientDetails {
		
		public static final class FinanceExecutor {
			public static final String ID = "WheeFinanceExecutor19";
			public static final String SECRET = "Wh33FiN4nc31nTheZky";
			public static final int ACCESS_TOKEN_VALIDITY_SECONDS = 99 * 86400; // 99 days
			public static final int REFRESH_TOKEN_VALIDITY_SECONDS = 99 * 86400; // 99 days
			
			public static String buildBasicAuthorization() {
				StringBuilder basicAuth = new StringBuilder("Basic ");
				String basicAuthEncoded = Base64.getEncoder().encodeToString(ID.concat(":").concat(SECRET).getBytes());
				basicAuth.append(new String(basicAuthEncoded));
				return basicAuth.toString();
			}
		}
		
		public static final class BatchExecutor {
			public static final String ID = "WheeBatchExecutor19";
			public static final String SECRET = "Wh33b4tch4s1qu3S3k4l3";
			public static final int ACCESS_TOKEN_VALIDITY_SECONDS = 99 * 86400; // 99 days
			public static final int REFRESH_TOKEN_VALIDITY_SECONDS = 99 * 86400; // 99 days
			
			public static String buildBasicAuthorization() {
				StringBuilder basicAuth = new StringBuilder("Basic ");
				String basicAuthEncoded = Base64.getEncoder().encodeToString(ID.concat(":").concat(SECRET).getBytes());
				basicAuth.append(new String(basicAuthEncoded));
				return basicAuth.toString();
			}
		}
		
		public static final class SmartDashboard {
			public static final String ID = "WheeSmartDashboard19";
			public static final String SECRET = "Wh33hEr3T0cr34teFu7Ur3";
			public static final int ACCESS_TOKEN_VALIDITY_SECONDS = 99 * 86400; // 99 days
			public static final int REFRESH_TOKEN_VALIDITY_SECONDS = 99 * 86400; // 99 days
			
			public static String buildBasicAuthorization() {
				StringBuilder basicAuth = new StringBuilder("Basic ");
				String basicAuthEncoded = Base64.getEncoder().encodeToString(ID.concat(":").concat(SECRET).getBytes());
				basicAuth.append(new String(basicAuthEncoded));
				return basicAuth.toString();
			}
		}
		
		public static final class MobileApi {
			public static final String ID = "WheeMobileApi19";
			public static final String SECRET = "Wh3eAr3Th3Ch4mPi0ns77";
			public static final int ACCESS_TOKEN_VALIDITY_SECONDS = 99 * 86400; // 99 days
			public static final int REFRESH_TOKEN_VALIDITY_SECONDS = 99 * 86400; // 99 days
			
			public static String buildBasicAuthorization() {
				StringBuilder basicAuth = new StringBuilder("Basic ");
				String basicAuthEncoded = Base64.getEncoder().encodeToString(ID.concat(":").concat(SECRET).getBytes());
				basicAuth.append(new String(basicAuthEncoded));
				return basicAuth.toString();
			}
		}

		public static final class JobshubApi {
			public static final String ID = "WheeJobshubApi19";
			public static final String SECRET = "Wh3eAr3Th3Ch4mPi0ns77";
			public static final int ACCESS_TOKEN_VALIDITY_SECONDS = 99 * 86400; // 99 days
			public static final int REFRESH_TOKEN_VALIDITY_SECONDS = 99 * 86400; // 99 days
			
			public static String buildBasicAuthorization() {
				StringBuilder basicAuth = new StringBuilder("Basic ");
				String basicAuthEncoded = Base64.getEncoder().encodeToString(ID.concat(":").concat(SECRET).getBytes());
				basicAuth.append(new String(basicAuthEncoded));
				return basicAuth.toString();
			}
		}
		
		public static String getClientId(String headerBasicAuthorization) {
			if(headerBasicAuthorization.contentEquals(SmartDashboard.buildBasicAuthorization()))
				return SmartDashboard.ID;
			
			if(headerBasicAuthorization.contentEquals(MobileApi.buildBasicAuthorization()))
				return MobileApi.ID;
			
			if(headerBasicAuthorization.contentEquals(BatchExecutor.buildBasicAuthorization()))
				return BatchExecutor.ID;
			
			if(headerBasicAuthorization.contentEquals(FinanceExecutor.buildBasicAuthorization()))
				return FinanceExecutor.ID;
			
			return null;
		}
		
		public static boolean isValidBasicAuthorization(String headerBasicAuthorization) {
			
			if(headerBasicAuthorization.contentEquals(BatchExecutor.buildBasicAuthorization()))
				return true;
			
			if(headerBasicAuthorization.contentEquals(SmartDashboard.buildBasicAuthorization()))
				return true;
			
			if(headerBasicAuthorization.contentEquals(MobileApi.buildBasicAuthorization()))
				return true;
			
			if(headerBasicAuthorization.contentEquals(FinanceExecutor.buildBasicAuthorization()))
				return true;
			
			return false;
		}
		
	}
	
	public static final class HttpHeader {
		public static final String CONTENT_TYPE_JSON = "Content-Type:application/json;charset=utf-8";
		public static final String CONTENT_TYPE_URLENCODED = "Content-Type:application/x-www-form-urlencoded";
	}
	
	public static final class UserRole {
		
		// Administrator
		public static final String SYSTEM = "ROLE_SYSTEM";
		public static final String ADMIN = "ROLE_ADMIN";
		public static final String ADMIN_HR = "ROLE_ADMIN_HR";
		public static final String DRAFTER_EOFFICE = "ROLE_DRAFTER_EOFFICE";
		public static final String MANAGER_HR = "ROLE_MANAGER_HR";
		public static final String EMPLOYEE = "ROLE_EMPLOYEE";
		public static final String ADMIN_JOBSHUB = "ROLE_ADMIN_JOBSHUB";
		public static final String CANDIDATE = "ROLE_CANDIDATE";
		public static final String AGENCY = "ROLE_AGENCY";
		public static final String EMPLOYERS = "ROLE_EMPLOYERS";
		public static final String PARTNERS = "ROLE_PARTNERS";
		
	}
	
	public static final class Notification {
		public static final String INBOX = "INBOX";
		public static final String TIME_OFF = "TIME_OFF";
		public static final String ATTENDANCE = "ATTENDANCE";
		public static final String WFH = "WFH";
	}

	public static final class PhaseType {
		public static final String PT01 = "PT01"; //Qualified
		public static final String PT02 = "PT02"; //Interview
		public static final String PT03 = "PT03"; //Offered
		public static final String PT04 = "PT04"; //Hired
	}
	
	public static final class NotificationStatus {
		public static final String NEW = "NEW";
		public static final String READ = "READ";
		public static final String DELETED = "DELETED";
	}
	
	public static final class NotificationSubject {
		public static final String TIME_OFF_REQUEST = "Time off request";
		public static final String TIME_OFF_APPROVE = "Time off approve";
		public static final String TIME_OFF_REJECT = "Time off reject";
		
		public static final String ATTENDANCE_REQUEST = "Attendance Request";
		public static final String ATTENDANCE_APPROVE = "Attendance Approve";
		public static final String ATTENDANCE_REJECT = "Attendance Reject";

		public static final String WFH_REQUEST = "WFH Request";
		public static final String WFH_APPROVE = "WFH Approve";
		public static final String WFH_REJECT = "WFH Reject";
	}
	
	public static String[] ALLOWED_SYSTEM_PATH = new String[]{ 
			UserRole.ADMIN.replaceAll("ROLE_", ""), 
			UserRole.SYSTEM.replaceAll("ROLE_", ""), 
			UserRole.ADMIN_HR.replaceAll("ROLE_", ""),
			UserRole.DRAFTER_EOFFICE.replaceAll("ROLE_", ""),
    		UserRole.MANAGER_HR.replaceAll("ROLE_", ""),
			UserRole.EMPLOYEE.replaceAll("ROLE_", "")};
    public static String[] ALLOWED_FORWARD_SUCCESS_LOGIN = new String[]{
    		UserRole.ADMIN.replaceAll("ROLE_", ""), 
    		UserRole.ADMIN_HR.replaceAll("ROLE_", ""),
			UserRole.DRAFTER_EOFFICE.replaceAll("ROLE_", ""),
    		UserRole.MANAGER_HR.replaceAll("ROLE_", ""),
    		UserRole.SYSTEM.replaceAll("ROLE_", ""), 
    		UserRole.EMPLOYEE.replaceAll("ROLE_", "")};
	
	public static final class TokenInfo {
		public static final String USER_NO = "userNo";
		public static final String USERNAME = "userName";
		public static final String USER_EMAIL = "userEmail";
		public static final String USER_MOBILE = "userMobile";
		public static final String AUTHORITIES = "authorities";
		public static final String STORE_ID = "storeId";
		public static final String IS_ADMIN = "isAdmin";
		public static final String IS_TRIAL = "isTrial";
		
		// metadata
		public static final String APP_SOURCE = "appSource";
		public static final String CODE = "code";
		public static final String TIMELAPSE = "timelapse";
		public static final String ROLE = "role";
		
		// menu access
		public static final String MENU_ROLE_LIST = "menuRoleList";
		public static final String MENU_LIST = "menuList";
		public static final String MENU_CLUSTER = "menuCluster";
	}
	
	public static final class ClusterCode{
		public static final String ADM_MPAGE = "MPA01";
		public static final String ADM_AUTH = "ADM_AUTH";
		public static final String ROLE_ADMIN_FINANCE = "MPAB01";
		public static final String ROLE_ADMIN_DEV = "MPA_DEV";
		public static final String ROLE_ADMIN_CS = "MPA_CS";
		public static final String ROLE_ADMIN_MARKETING = "MPA_MKR";
		public static final String ADMIN_SALES_REGIONAL_MANAGER = "MPA_SRM";
		public static final String ADMIN_MERCHANT_ACQUSITION = "MPA_MA";
		
		
		
		public static String getCode(String role) {
			
			Map<String, String> map = new HashMap<>();
			map.put("ROLE_ADMIN", "MPA01");
			map.put("ROLE_ADMIN_HR", "MPA01");
			map.put("ROLE_ADMIN_EOFFICE", "MPA01");
			map.put("ROLE_DRAFTER_EOFFICE", "MPA01");
			map.put("ROLE_SYSTEM", "MPA01");
			
			return map.get(role);
		}
	}
	
}
