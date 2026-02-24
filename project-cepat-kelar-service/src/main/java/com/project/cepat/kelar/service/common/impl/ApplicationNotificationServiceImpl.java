package com.project.cepat.kelar.service.common.impl;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;

import com.project.cepat.kelar.common.web.DataTableObject;
import com.project.cepat.kelar.jpa.model.common.ApplicationNotification;
import com.project.cepat.kelar.jpa.repository.common.ApplicationNotificationRepository;
import com.project.cepat.kelar.service.common.ApplicationNotificationService;

@Service
public class ApplicationNotificationServiceImpl implements ApplicationNotificationService {
	private static final Logger logger = LoggerFactory.getLogger(ApplicationNotificationServiceImpl.class);
	
    private final ApplicationNotificationRepository applicationNotificationRepository;

    public ApplicationNotificationServiceImpl(ApplicationNotificationRepository applicationNotificationRepository) {
        this.applicationNotificationRepository = applicationNotificationRepository;
    }

    @Override
    public Long getNum() {
        return applicationNotificationRepository.count();
    }

    @Override
    public ApplicationNotification save(ApplicationNotification applicationNotification) throws Exception {
        return applicationNotificationRepository.save(applicationNotification);
    }

    @Override
    public ApplicationNotification getById(Long aLong) throws Exception {
        return applicationNotificationRepository.findById(aLong).orElse(null);
    }

    @Override
    public Boolean delete(Long aLong) throws Exception {
        try {
            ApplicationNotification model = applicationNotificationRepository.findById(aLong).orElse(null);
            if (model != null) {
                applicationNotificationRepository.deleteById(aLong);
                return true;
            } else {
                logger.info("No Such Notification with id : " + aLong);
                return false;
            }

        } catch (Exception e) {
            logger.error("Fail delete", e);
            throw new Exception(e);
        }
    }

    @Override
    public Page<ApplicationNotification> getPageableList(String param, int startPage, int pageSize, Sort sort) throws Exception {
        int page = DataTableObject.getPageFromStartAndLength(startPage, pageSize);
        return applicationNotificationRepository.getPageable(param, PageRequest.of(page, pageSize, sort));
    }

    @Override
    public List<ApplicationNotification> getByDate(Date pDate) throws Exception {
        List<ApplicationNotification> rList = new ArrayList<>();
        try {
            List<ApplicationNotification> modelList = applicationNotificationRepository.getActiveList();
            if (modelList != null && modelList.size() > 0) {
                for (ApplicationNotification notification : modelList) {
                    if (pDate.after(notification.getNotificationStartDate()) || pDate.before(notification.getNotificationEndDate())) {
                        rList.add(notification);
                    }
                }
            }
        } catch (Exception e) {
            logger.error("Fail getByDate", e);
            throw new Exception(e);
        }
        return rList;
    }

    @Override
    public List<ApplicationNotification> getAll() throws Exception {
        return (List<ApplicationNotification>) applicationNotificationRepository.findAll();
    }
}
