package com.project.cepat.kelar.service.common;

import java.util.Date;
import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Sort;

import com.project.cepat.kelar.common.service.CommonService;
import com.project.cepat.kelar.wrapper.common.SchedulerWrapper;

public interface SchedulerService extends CommonService<SchedulerWrapper, Long> {

    List<SchedulerWrapper> getAvailableListByTimeRange(Date scheduleStartDate, Date scheduleEndDate, Integer scheduleType) throws Exception;

    Page<SchedulerWrapper> getPageableList(String param, Integer startPage, Integer pageSize, Sort sort) throws Exception;
}
