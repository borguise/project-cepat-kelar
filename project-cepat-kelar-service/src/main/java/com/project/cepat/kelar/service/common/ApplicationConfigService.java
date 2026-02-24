package com.project.cepat.kelar.service.common;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Sort;

import com.project.cepat.kelar.common.service.CommonService;
import com.project.cepat.kelar.jpa.model.common.ApplicationConfig;

public interface ApplicationConfigService extends CommonService<ApplicationConfig, Long> {

    Page<ApplicationConfig> getPageableList(String param, int startPage, int pageSize, Sort sort) throws Exception;

    ApplicationConfig getByConfigId(String configId);
}
