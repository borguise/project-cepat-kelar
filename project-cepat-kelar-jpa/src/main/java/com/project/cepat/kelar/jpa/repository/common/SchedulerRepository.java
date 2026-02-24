package com.project.cepat.kelar.jpa.repository.common;

import java.util.Date;
import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.querydsl.QuerydslPredicateExecutor;
import org.springframework.data.repository.query.Param;

import com.project.cepat.kelar.jpa.model.common.Scheduler;

public interface SchedulerRepository extends JpaRepository<Scheduler, Long>, QuerydslPredicateExecutor<Scheduler> {

    @Query(value = "select ws  from Scheduler ws where ws.schedulerName like %:text% or ws.description like %:text%")
    Page<Scheduler> getPageable(@Param("text") String text, Pageable pageable);

    @Query(value = "select ws  from Scheduler ws where ws.active=true and (ws.schedulerName like %:text% or ws.description like %:text%)")
    Page<Scheduler> getPageableActive(@Param("text") String text, Pageable pageable);


    @Query(value = "select ws from Scheduler ws where ws.scheduleDate between :scheduleStartDate and :scheduleEndDate and ws.scheduleType=2 and ws.active=true")
    List<Scheduler> findActiveOnDemandScheduleList(@Param("scheduleStartDate") Date scheduleStartDate,@Param("scheduleEndDate") Date  scheduleEndDate);

    @Query(value = "select ws from Scheduler ws where ws.scheduleTime between :startTime and :endTime and ws.scheduleType=1 and ws.active=true")
    List<Scheduler> findActiveRoutineSchedule(@Param("startTime") Date startDate, @Param("endTime") Date endTime);
}
