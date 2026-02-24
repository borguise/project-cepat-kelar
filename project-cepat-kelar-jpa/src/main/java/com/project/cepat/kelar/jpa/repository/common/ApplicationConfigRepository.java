package com.project.cepat.kelar.jpa.repository.common;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.querydsl.QuerydslPredicateExecutor;
import org.springframework.data.repository.query.Param;

import com.project.cepat.kelar.jpa.model.common.ApplicationConfig;

public interface ApplicationConfigRepository extends JpaRepository<ApplicationConfig, Long>, QuerydslPredicateExecutor<ApplicationConfig> {

    @Query(value = "select mc from ApplicationConfig mc where mc.configId like %:text% or mc.configValue like %:text%")
    Page<ApplicationConfig> getPageable(@Param("text") String text, Pageable pageable);

    @Query(value = "SELECT ac from ApplicationConfig ac where ac.configId=:configId")
    ApplicationConfig getByAppConfigId(@Param("configId") String configId);
}
