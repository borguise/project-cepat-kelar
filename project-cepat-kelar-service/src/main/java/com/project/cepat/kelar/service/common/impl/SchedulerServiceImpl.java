package com.project.cepat.kelar.service.common.impl;

import java.sql.Time;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;

import com.project.cepat.kelar.common.web.DataTableObject;
import com.project.cepat.kelar.jpa.model.common.Scheduler;
import com.project.cepat.kelar.jpa.repository.common.SchedulerRepository;
import com.project.cepat.kelar.service.common.SchedulerService;
import com.project.cepat.kelar.wrapper.common.SchedulerWrapper;

@Service
public class SchedulerServiceImpl implements SchedulerService {
    public static final Integer ROUTINE = 1;
    public static final Integer ON_DEMAND = 2;

    private static final Logger logger = LoggerFactory.getLogger(SchedulerServiceImpl.class);
    
    private final SchedulerRepository schedulerRepository;

    public SchedulerServiceImpl(SchedulerRepository schedulerRepository) {
        this.schedulerRepository = schedulerRepository;
    }

    private Scheduler toEntity(SchedulerWrapper wrapper) throws Exception {
        Scheduler model = new Scheduler();
        if (wrapper.getId() != null) {
            model = schedulerRepository.findById(wrapper.getId()).orElse(new Scheduler());
            model.setUpdatedDate(new Date());
        } else {
            model.setCreatedDate(new Date());
            model.setUpdatedDate(new Date());
        }
        model.setDescription(wrapper.getDescription());
        model.setSchedulerName(wrapper.getSchedulerName());
        if (wrapper.getScheduleType().equalsIgnoreCase("ROUTINE"))
            model.setScheduleType(ROUTINE);
        else {
            model.setScheduleType(ON_DEMAND);
        }
        if (wrapper.getScheduleDate() != null && !wrapper.getScheduleDate().equals("")) {
            model.setScheduleDate(new SimpleDateFormat(wrapper.dateFormat).parse(wrapper.getScheduleDate()));
        }
        if (wrapper.getScheduleTime() != null && !wrapper.getScheduleTime().equals("")) {
            Long scheduleTime = (new SimpleDateFormat(wrapper.timeFormat).parse(wrapper.getScheduleTime()).getTime());
            model.setScheduleTime(new Time(scheduleTime));
        }
        model.setActive(wrapper.getActive());
        model.setClassName(wrapper.getClassName());
        return model;
    }

    private SchedulerWrapper toWrapper(Scheduler model) throws Exception {
        SchedulerWrapper wrapper = new SchedulerWrapper();
        wrapper.setId(model.getId());
        wrapper.setDescription(model.getDescription());
        wrapper.setCreatedDate(model.getCreatedDate());
        wrapper.setUpdatedDate(model.getUpdatedDate());
        wrapper.setSchedulerName(model.getSchedulerName());
        if (model.getScheduleType().equals(ROUTINE))
            wrapper.setScheduleType("ROUTINE");
        else
            wrapper.setScheduleType("ON DEMAND");
        if (model.getScheduleDate() != null) {
            wrapper.setScheduleDate(new SimpleDateFormat(wrapper.dateFormat).format(model.getScheduleDate()));
        }
        if (model.getScheduleTime() != null) {
            wrapper.setScheduleTime(model.getScheduleTime().toString());
        }
        wrapper.setActive(model.getActive());
        wrapper.setClassName(model.getClassName());
        return wrapper;
    }

    private List<SchedulerWrapper> toWrapperList(List<Scheduler> modelList) throws Exception {
        List<SchedulerWrapper> wrapperList = new ArrayList<>();
        if (modelList != null && modelList.size() > 0) {
            for (Scheduler scheduler : modelList) {
                wrapperList.add(toWrapper(scheduler));
            }
        }
        return wrapperList;
    }

    @Override
    public Long getNum() {
        return schedulerRepository.count();
    }

    @Override
    public SchedulerWrapper save(SchedulerWrapper wrapper) throws Exception {
        return toWrapper(schedulerRepository.save(toEntity(wrapper)));
    }

    @Override
    public SchedulerWrapper getById(Long aLong) throws Exception {
        return toWrapper(schedulerRepository.findById(aLong).orElse(null));
    }

    @Override
    public Boolean delete(Long aLong) throws Exception {
        try {
            schedulerRepository.deleteById(aLong);
            return true;
        } catch (Exception e) {
            logger.error("Fail delete", e);
            throw new Exception(e);
        }
    }

    @Override
    public List<SchedulerWrapper> getAll() throws Exception {
        List<Scheduler> tempList = (List<Scheduler>) schedulerRepository.findAll();
        return toWrapperList(tempList);
    }

    @Override
    public List<SchedulerWrapper> getAvailableListByTimeRange(Date scheduleStartDate, Date scheduleEndDate, Integer scheduleType) throws Exception {
        List<Scheduler> tempList = new ArrayList<>();
        if(scheduleType.equals(ON_DEMAND)) {
            tempList = (List<Scheduler>) schedulerRepository.findActiveOnDemandScheduleList(scheduleStartDate, scheduleEndDate);
        }else{
            tempList = (List<Scheduler>) schedulerRepository.findActiveRoutineSchedule(scheduleStartDate, scheduleEndDate);
        }
        return toWrapperList(tempList);
    }

    @Override
    public Page<SchedulerWrapper> getPageableList(String param, Integer startPage, Integer pageSize, Sort sort) throws Exception {
        int page = DataTableObject.getPageFromStartAndLength(startPage, pageSize);
        Page<Scheduler> schedulerPage = schedulerRepository.getPageable(param, PageRequest.of(page, pageSize, sort));
        List<SchedulerWrapper> wrapperList = toWrapperList(schedulerPage.getContent());
        return new PageImpl<SchedulerWrapper>(wrapperList, PageRequest.of(page, pageSize, sort), schedulerPage.getTotalElements());
    }
}
