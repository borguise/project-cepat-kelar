package com.project.cepat.kelar.common.controller;

import java.io.IOException;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.json.JsonParseException;
import org.springframework.context.ApplicationContext;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ModelAttribute;

import com.project.cepat.kelar.common.constant.AppConstant;
import com.project.cepat.kelar.common.constant.AppTimeZone;
import com.project.cepat.kelar.common.util.MultilangUtil;
import com.project.cepat.kelar.common.web.JsonMessage;
import com.project.cepat.kelar.common.web.ResponseStatus;
import com.project.cepat.kelar.common.web.ResponseWrapper;

import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import lombok.AccessLevel;
import lombok.Data;
import lombok.Getter;
import lombok.Setter;
import tools.jackson.core.JacksonException;
import tools.jackson.databind.ObjectMapper;

@Data
public abstract class BaseController {
	
	private static final Logger log = LoggerFactory.getLogger(BaseController.class);
	
	@Autowired
	private ApplicationContext appCtx;
	
	// Administrator
	public static final String SYSTEM = AppConstant.UserRole.SYSTEM;
	public static final String ADMIN = AppConstant.UserRole.ADMIN;
	public static final String ADMIN_HR = AppConstant.UserRole.ADMIN_HR;
	public static final String DRAFTER_EOFFICE = AppConstant.UserRole.DRAFTER_EOFFICE;
	public static final String MANAGER_HR = AppConstant.UserRole.MANAGER_HR;
	public static final String EMPLOYEE = AppConstant.UserRole.EMPLOYEE;
	public static final String AGENCY = AppConstant.UserRole.AGENCY;
	public static final String EMPLOYERS = AppConstant.UserRole.EMPLOYERS;
	public static final String PARTNERS = AppConstant.UserRole.PARTNERS;
	public static final String CANDIDATE = AppConstant.UserRole.CANDIDATE;
	
	
	public static final String INBOX = AppConstant.Notification.INBOX;
	public static final String TIME_OFF = AppConstant.Notification.TIME_OFF;
	public static final String ATTENDANCE = AppConstant.Notification.ATTENDANCE;
	public static final String WFH = AppConstant.Notification.WFH;

	public static final String PT01 = AppConstant.PhaseType.PT01;
	public static final String PT02 = AppConstant.PhaseType.PT02;
	public static final String PT03 = AppConstant.PhaseType.PT03;
	public static final String PT04 = AppConstant.PhaseType.PT04;
	
	public static final String NEW = AppConstant.NotificationStatus.NEW;
	public static final String READ = AppConstant.NotificationStatus.READ;
	public static final String DELETED = AppConstant.NotificationStatus.NEW;
	
	
	public static final String TIME_OFF_REQUEST = AppConstant.NotificationSubject.TIME_OFF_REQUEST;
	public static final String TIME_OFF_APPROVE = AppConstant.NotificationSubject.TIME_OFF_APPROVE;
	public static final String TIME_OFF_REJECT = AppConstant.NotificationSubject.TIME_OFF_REJECT;
	
	public static final String ATTENDANCE_REQUEST = AppConstant.NotificationSubject.ATTENDANCE_REQUEST;
	public static final String ATTENDANCE_APPROVE = AppConstant.NotificationSubject.ATTENDANCE_APPROVE;
	public static final String ATTENDANCE_REJECT = AppConstant.NotificationSubject.ATTENDANCE_REJECT;
	
	public static final String WFH_REQUEST = AppConstant.NotificationSubject.WFH_REQUEST;
	public static final String WFH_APPROVE = AppConstant.NotificationSubject.WFH_APPROVE;
	public static final String WFH_REJECT = AppConstant.NotificationSubject.WFH_REJECT;
	
	
	public static final class RedirectPage {
		public static final String FORBIDDEN = "redirect:/403";
		public static final String NOT_FOUND = "redirect:/404";
		public static final String UPGRADE_PRO = "error/redirect-billing";
		public static final String INVALID_REGISTRATION_URL = "registration/errorPage";
		
	}
	
	private static final String EMAIL_PATTERN = "^[_A-Za-z0-9-\\+]+(\\.[_A-Za-z0-9-]+)*@[A-Za-z0-9-]+(\\.[A-Za-z0-9]+)*(\\.[A-Za-z]{2,})$";

	private static final int MAX_SIZE_PER_PAGE = 100; 
	
	public static final String PAGE_PARAM_NOTES = "the value is absolute (non negative)";
	public static final String SIZE_PARAM_NOTES = "max value is 100";
	
	public static final int BOOLEAN_FALSE = 0;
	public static final int BOOLEAN_TRUE = 1;
	
	@Getter(value = AccessLevel.PRIVATE)
	private final Pattern pattern = Pattern.compile(EMAIL_PATTERN);
	
	@Setter(value = AccessLevel.PRIVATE)
	@Getter(value = AccessLevel.PRIVATE)
	private Matcher matcher;

	@Setter(value = AccessLevel.PRIVATE)
	@Getter(value = AccessLevel.PRIVATE)
	private ResponseEntity<Object> response = null;
	
	@ModelAttribute("pageTitle")
    public String pageTitle() {
    	return "";
    }
    
    @ModelAttribute("model")
    public Object newModel() {
    	return null;
    }

    // REST API Response
	public ResponseEntity<Object> buildResponseGeneralSuccess() {
		return buildResponseGeneralSuccess(null);
	}
	
	public ResponseEntity<Object> buildResponseGeneralError() {
		return buildResponseGeneralError(null);
	}
	
	public ResponseEntity<Object> buildResponseGeneralSuccess(Object data) {
		setResponse(new ResponseEntity<Object>(ResponseWrapper.build(data, ResponseStatus.GENERAL_SUCCESS), HttpStatus.OK));
		return this.response;
	}
	
	public ResponseEntity<Object> unauthorized() {
		return buildResponse(null, ResponseStatus.AUTHORIZATION_FAIL, HttpStatus.UNAUTHORIZED);
	}
	
	public ResponseEntity<Object> unauthorized(Object data) {
		return buildResponse(data, ResponseStatus.AUTHORIZATION_FAIL, HttpStatus.UNAUTHORIZED);
	}
	
	public ResponseEntity<Object> ok(Object data) {
		return buildResponseGeneralSuccess(data);
	}

	public ResponseEntity<Object> responseSuccess(String code, String message) {
		setResponse(new ResponseEntity<Object>(ResponseWrapper.build(code, message), HttpStatus.OK));
		return this.response;
	}
	
	public ResponseEntity<Object> buildResponseGeneralError(Object data) {
		setResponse(new ResponseEntity<Object>(ResponseWrapper.build(data, ResponseStatus.GENERAL_ERROR), HttpStatus.INTERNAL_SERVER_ERROR));
		return this.response;
	}
	
	public ResponseEntity<Object> internalServerError(Object data) {
		return buildResponseGeneralError(data);
	}
	
	public ResponseEntity<Object> buildResponse(Object data, ResponseStatus responseStatus, HttpStatus httpStatus) {
		setResponse(new ResponseEntity<Object>(ResponseWrapper.build(data, responseStatus), httpStatus));
		return this.response;
	}
	
	public ResponseEntity<Object> buildResponse(ResponseStatus responseStatus, HttpStatus httpStatus) {
		setResponse(new ResponseEntity<Object>(ResponseWrapper.build(null, responseStatus), httpStatus));
		return this.response;
	}

	public ResponseEntity<Object> buildResponse(Object data, String code, String message, HttpStatus httpStatus) {
		setResponse(new ResponseEntity<Object>(ResponseWrapper.build(data, code, message), httpStatus));
		return this.response;
	}
	
	public ResponseEntity<Object> buildResponseProcessing(ResponseStatus responseStatus) {
		setResponse(new ResponseEntity<Object>(ResponseWrapper.build(null, responseStatus), HttpStatus.ACCEPTED));
		return this.response;
	}
	
	public ResponseEntity<Object> buildResponseNotFound() {
		setResponse(new ResponseEntity<Object>(ResponseWrapper.build(null, ResponseStatus.GENERAL_NOT_FOUND), HttpStatus.NOT_FOUND));
		return this.response;
	}
	
	public ResponseEntity<Object> buildResponseNotFound(Object data) {
		setResponse(new ResponseEntity<Object>(ResponseWrapper.build(data, ResponseStatus.GENERAL_NOT_FOUND), HttpStatus.NOT_FOUND));
		return this.response;
	}
	
	public ResponseEntity<Object> buildResponseLinkNotAvailable() {
		setResponse(new ResponseEntity<Object>(ResponseWrapper.build(null, ResponseStatus.LINK_IS_UNAVAILABLE), HttpStatus.NOT_FOUND));
		return this.response;
	}
	
	public ResponseEntity<Object> buildResponseLinkNotAvailable(Object data) {
		setResponse(new ResponseEntity<Object>(ResponseWrapper.build(data, ResponseStatus.LINK_IS_UNAVAILABLE), HttpStatus.NOT_FOUND));
		return this.response;
	}
	
	public ResponseEntity<Object> buildResponseLinkExpired() {
		setResponse(new ResponseEntity<Object>(ResponseWrapper.build(null, ResponseStatus.LINK_IS_EXPIRED), HttpStatus.NOT_FOUND));
		return this.response;
	}
	
	public ResponseEntity<Object> buildResponseLinkExpired(Object data) {
		setResponse(new ResponseEntity<Object>(ResponseWrapper.build(data, ResponseStatus.LINK_IS_EXPIRED), HttpStatus.NOT_FOUND));
		return this.response;
	}
	
	public ResponseEntity<Object> buildResponseLinkUsed() {
		setResponse(new ResponseEntity<Object>(ResponseWrapper.build(null, ResponseStatus.LINK_IS_USED), HttpStatus.NOT_FOUND));
		return this.response;
	}
	
	public ResponseEntity<Object> buildResponseLinkUsed(Object data) {
		setResponse(new ResponseEntity<Object>(ResponseWrapper.build(data, ResponseStatus.LINK_IS_USED), HttpStatus.NOT_FOUND));
		return this.response;
	}
	
	public ResponseEntity<Object> buildResponseNotFound(ResponseStatus responseStatus) {
		setResponse(new ResponseEntity<Object>(ResponseWrapper.build(null, responseStatus), HttpStatus.NOT_FOUND));
		return this.response;
	}
	
	public ResponseEntity<Object> buildResponseBadRequest(Object data) {
		setResponse(new ResponseEntity<Object>(ResponseWrapper.build(data, ResponseStatus.GENERAL_WARN), HttpStatus.BAD_REQUEST));
		return this.response;
	}
	
	public ResponseEntity<Object> badRequest(Object data) {
		return buildResponseBadRequest(data);
	}
	
	public ResponseEntity<Object> notModified(Object data) {
		setResponse(new ResponseEntity<Object>(ResponseWrapper.build(data, ResponseStatus.GENERAL_WARN), HttpStatus.NOT_MODIFIED));
		return this.response;
	}
	
	public ResponseEntity<Object> found(Object data) {
		setResponse(new ResponseEntity<Object>(ResponseWrapper.build(data, ResponseStatus.GENERAL_INFO), HttpStatus.FOUND));
		return this.response;
	}
	
	public ResponseEntity<Object> notFound(Object data) {
		return buildResponseNotFound(data);
	}
	
	// AJAX Responses
	public JsonMessage ajaxSuccessSave() {
		MultilangUtil multilang = appCtx.getBean(MultilangUtil.class);
		if(null != multilang)
			return JsonMessage.showInfoMessage(multilang.get("message.save.succeed"));
		
		return JsonMessage.showInfoMessage("Save Success");
	}
	
	public JsonMessage ajaxSuccessChangePasswordEmployee() {
		MultilangUtil multilang = appCtx.getBean(MultilangUtil.class);
		if(null != multilang)
			return JsonMessage.showInfoMessage(multilang.get("message.change.password"));
		
		return JsonMessage.showInfoMessage("Save Success");
	}
	
	public JsonMessage ajaxSuccessChangePasswordAccount() {
		MultilangUtil multilang = appCtx.getBean(MultilangUtil.class);
		if(null != multilang)
			return JsonMessage.showInfoMessage(multilang.get("message.change.passwordAcc"));
		
		return JsonMessage.showInfoMessage("Save Success");
	}
	
	public JsonMessage ajaxFailSave() {
		MultilangUtil multilang = appCtx.getBean(MultilangUtil.class);
		if(null != multilang)
			return JsonMessage.showErrorMessage(multilang.get("message.save.failed"));
		
		return JsonMessage.showErrorMessage("Save Fail");
	}
	
	public JsonMessage ajaxFailSave(String messageDetail) {
		MultilangUtil multilang = appCtx.getBean(MultilangUtil.class);
		if(null != multilang)
			return JsonMessage.showErrorMessage(multilang.get("message.save.failed"), messageDetail);
		
		return JsonMessage.showErrorMessage("Save Fail", messageDetail);
	}
	
	public JsonMessage ajaxNoDataSave() {
		MultilangUtil multilang = appCtx.getBean(MultilangUtil.class);
		if(null != multilang)
			return JsonMessage.showWarningMessage(multilang.get("message.nodata.saved"));
		
		return JsonMessage.showWarningMessage("No Data Saved");
	}
	
	public JsonMessage ajaxSuccessDelete() {
		MultilangUtil multilang = appCtx.getBean(MultilangUtil.class);
		if(null != multilang)
			return JsonMessage.showInfoMessage(multilang.get("message.delete.succeed"));
		
		return JsonMessage.showErrorMessage("Delete Success");
	}

	public JsonMessage ajaxSuccessEnabled() {
		MultilangUtil multilang = appCtx.getBean(MultilangUtil.class);
		if(null != multilang)
			return JsonMessage.showInfoMessage(multilang.get("message.enabled.succeed"));
		
		return JsonMessage.showErrorMessage("Enabled Success");
	}

	public JsonMessage ajaxSuccessDisabled() {
		MultilangUtil multilang = appCtx.getBean(MultilangUtil.class);
		if(null != multilang)
			return JsonMessage.showInfoMessage(multilang.get("message.disabled.succeed"));
		
		return JsonMessage.showErrorMessage("Disabled Success");
	}
	
	public JsonMessage ajaxNoDataSave(String messageDetail) {
		MultilangUtil multilang = appCtx.getBean(MultilangUtil.class);
		if(null != multilang)
			return JsonMessage.showErrorMessage(multilang.get("message.nodata.saved"), messageDetail);
		
		return JsonMessage.showErrorMessage("No Data Saved", messageDetail);
	}
	
	public JsonMessage ajaxForbidden() {
		MultilangUtil multilang = appCtx.getBean(MultilangUtil.class);
		if(null != multilang)
			return JsonMessage.showErrorMessage(multilang.get("message.insufficient.privilege"));
		
		return JsonMessage.showErrorMessage("Forbidden Access");
	}
	
	public JsonMessage ajaxException(Exception e) {		
		return JsonMessage.showErrorMessage(ResponseStatus.GENERAL_ERROR.getMessage(), e.getMessage());
	}
	
	public JsonMessage ajaxException(String exceptionMessageDetail) {		
		return JsonMessage.showErrorMessage(ResponseStatus.GENERAL_ERROR.getMessage(), exceptionMessageDetail);
	}
	
	public JsonMessage ajaxError(String errorMessageDetail) {		
		return JsonMessage.showErrorMessage(ResponseStatus.GENERAL_ERROR.getMessage(), errorMessageDetail);
	}
	
	public boolean validEmail(final String email) {
		matcher = pattern.matcher(email);
		return matcher.matches();
	}
	
	public int safetifyPage(int page) {
		return Math.abs(page);
	}
	
	public int safetifySize(int size) {
		if(size < 0 )
			return Math.abs(size);
		
		if(size > MAX_SIZE_PER_PAGE)
			return MAX_SIZE_PER_PAGE;
		
		return size;
	}
	
	@Deprecated
	public String likely(String keyword) {
		return String.format("%s%s%s", "%", keyword, "%");
	}
	
	public static final DateFormat DATA_TABLE_DATE_FMT = new SimpleDateFormat("dd MMM yyyy");
	public Date fromDataTableToDate(String datePickerString) {
		Date result = null;
		try {
			result = DATA_TABLE_DATE_FMT.parse(datePickerString);
		} catch (ParseException e) {
			log.error("", e);
		}
		return result;
	}
	
	public AppTimeZone timezoneCookie(HttpServletRequest request, AppTimeZone userTimezone) throws JsonParseException, JacksonException, IOException {
		ObjectMapper mapper = new ObjectMapper();
		AppTimeZone timezoneValue = userTimezone;
		String timezone = "";
		Cookie[] cookies = request.getCookies();
		
		if (cookies != null) {
			for (Cookie cookie : cookies) {
				if (cookie.getName().equals("TZ")) {
					timezone = cookie.getValue();
					timezoneValue= mapper.readValue("\""+timezone +"\"", AppTimeZone.class);
				} 
			}
		}
		return timezoneValue;
	}

//	public void validate(BindingResult bindingResult) throws FieldValidationException {
//		if (bindingResult.hasErrors()) {
//			FieldError fieldError = bindingResult.getFieldError();
//			throw new FieldValidationException(fieldError.getField() + " " + fieldError.getDefaultMessage());
//		}
//	}

}
