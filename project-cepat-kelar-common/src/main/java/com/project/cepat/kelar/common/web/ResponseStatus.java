package com.project.cepat.kelar.common.web;

// @formatter:off
public enum ResponseStatus {

	// SUCCESS
	GENERAL_SUCCESS(1000, "General Success"),
	LOGOUT_SUCCESS(1100, "Logout success"),
	PROVINCE_CREATED(1001,"New Province created"),
	DISTRICT_CREATED(1002,"New District created"),
	SUB_DISTRICT_CREATED(1003,"New Sub District created"),
	VILLAGE_CREATED(1004,"New Village created"),

	// FAIL
	GENERAL_FAIL(2000, "General Failure"),
	USER_VERIFICATION_FAIL(2100, "User Verification fail"),
	AUTHORIZATION_FAIL(2222, "Authorization Failed"),
	AUTHORIZATION_TOKEN_INVALID(2223, "Authorization Token has invalidated"),
	FEIGN_CLIENT_HAS_FALLEN(2999, "Feign Client has fallen"),
	AUTHORIZATION_EXPIRED(2222, "Authorization Expired"),
	AUTHORIZATION_ACTIVE(1000, "Authorization Active"),
	
	// INFO
	GENERAL_INFO(3000, "General Information"),
	PROVINCE_NOT_FOUND(3001,"Province not found"),
	USER_IS_LOGGED_IN(3002,"User is Logged In"),
	USER_IS_LOGGED_OUT(3003,"User is Logged Out"),
	USER_CREATED(3004,"User Created"),
	USER_IS_LOGGED_IN_ANOTHER_APPS(3005,"User is Logged In another apps"),
	USER_NOT_EXIST(3100, "User Not Exist"),
	USER_NOT_CREATED(3005,"User Not Created"),
	USER_NOT_ACTIVE(3006,"Your account is inactive. For further information please contact us"),
	USER_WRONG_PASS_OR_EMAIL(3007,"The email address or password you entered is invalid"),
	USER_VERIFICATION_DATA_NOT_EXIST(3100, "User's Verification data not exist"),
	EMAIL_IS_ON_ITS_WAY(3200, "Email is on Its way"),
	SLACK_POST_IS_ON_ITS_WAY(3300, "Slack post is on Its way"),
	SMS_IS_ON_ITS_WAY(3400, "SMS is on Its way"),
	MOBILE_ALREADY_EXIST(3160, "Phone Number Already Registered"),
	EMAIL_ALREADY_EXIST(3170, "Email Already Registered"),
	EMAIL_OR_MOBILE_ALREADY_EXIST(3170, "Email or Mobile Already Registered"),
	CHECK_IN_FIRST(3170, "Please Clock In First"),
	APPLY_JOB_ALREADY_EXIST(3170, "Job has been apply"),
	
	// WARN
	GENERAL_WARN(4000, "General Warning"),
	USER_ALREADY_VERIFIED(4100, "User already verified"),
	USER_EMAIL_TAKEN(4101, "User's email taken"),
	LOGOUT_ALREADY(4102, "User already logged out"),
	CURRPASS_WRONG(4103, "Current password is wrong"),

	// ERROR
	GENERAL_ERROR(5000, "General Error"),
	TOKEN_IS_EMPTY(5100, "Token is empty"),
	LINK_IS_UNAVAILABLE(5001, "Link not Available"),
	LINK_IS_EXPIRED(5002, "Link Expired"),
	LINK_IS_USED(5003, "Link has been used"),
	TOKEN_IS_EXPIRED(5200, "Token is expired"),
	MOBILE_IS_INVALID(5200, "Mobile not exist"),
	TOKEN_IS_INVALID(5300, "Token is invalid"),
	
	// COMMON Response Status

	GENERAL_NOT_FOUND(9000, "Data Not Found"),
	ID_NOT_FOUND(5300, "Id not found"),
	MUST_UPDATE(5005, "Mohon Update Aplikasi Anda Ke Versi Terbaru");
	

	ResponseStatus(int code, String message) {
		this.code = code;
		this.message = message;
	}

	private final int code;
	private final String message;

	public int getCode() {
		return code;
	}

	public String getCodeString() {
		return String.valueOf(this.code);
	}

	public String getMessage() {
		return message;
	}

	public Type type() {
		return Type.valueOf(this);
	}

	public enum Type {

		SUCCESS(1), FAIL(2), INFO(3), WARN(4), ERROR(5);

		Type(int code) {
			this.code = code;
		}

		private final int code;

		public int getCode() {
			return code;
		}

		public static Type valueOf(int code) {
			int typeCode = code / 1000;
			for (Type type : values()) {
				if (type.code == typeCode) {
					return type;
				}
			}
			throw new IllegalArgumentException("No matching ResponseStatus.Type for [" + code + "]");
		}

		public static Type valueOf(ResponseStatus status) {
			return valueOf(status.code);
		}

	}
	
	public String toJsonString() {
		StringBuilder json = new StringBuilder();
		json.append("{");
			json.append("\"code\"").append(":").append(this.code).append(",");
			json.append("\"message\"").append(":").append("\""+ this.message +"\"");
		json.append("}");
		return json.toString();
	}

}
//@formatter:on
