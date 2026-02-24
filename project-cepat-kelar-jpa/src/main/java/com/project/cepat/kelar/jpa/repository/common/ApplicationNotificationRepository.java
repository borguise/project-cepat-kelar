package com.project.cepat.kelar.jpa.repository.common;

import java.util.Date;
import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.querydsl.QuerydslPredicateExecutor;
import org.springframework.data.repository.query.Param;

import com.project.cepat.kelar.jpa.model.common.ApplicationNotification;

public interface  ApplicationNotificationRepository extends JpaRepository<ApplicationNotification, Long>, QuerydslPredicateExecutor<ApplicationNotification> {

    @Query(value = "select mc from ApplicationNotification mc where mc.active = true and (mc.notificationName like concat('%', :text, '%') or mc.description like concat('%', :text, '%'))")
    Page<ApplicationNotification> getPageable(@Param("text") String text, Pageable pageable);

    @Query(value = "select mc from ApplicationNotification mc where mc.active = true and mc.notificationStartDate>=:notificationStartDate and mc.notificationEndDate<=:notificationEndDate and (mc.notificationName like concat('%', :text, '%') or mc.description like concat('%', :text, '%'))")
    List<ApplicationNotification> getPageable(@Param("text") String text, @Param("notificationStartDate") Date notificationStartDate, @Param("notificationEndDate") Date notificationEndDate);

    @Query(value = "select mc  from ApplicationNotification mc where mc.active = true")
    List<ApplicationNotification> getActiveList();
}
