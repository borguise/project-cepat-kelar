package com.project.cepat.kelar.service.common;

import java.util.Date;
import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Sort;

import com.project.cepat.kelar.common.service.CommonService;
import com.project.cepat.kelar.jpa.model.common.ApplicationNotification;

public interface ApplicationNotificationService extends CommonService<ApplicationNotification,Long> {
    Page<ApplicationNotification> getPageableList(String param, int startPage, int pageSize, Sort sort) throws Exception;

    List<ApplicationNotification> getByDate(Date date) throws Exception;
}
