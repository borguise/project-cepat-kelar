package com.project.cepat.kelar.service.common.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;

import com.project.cepat.kelar.common.web.DataTableObject;
import com.project.cepat.kelar.jpa.model.common.ApplicationConfig;
import com.project.cepat.kelar.jpa.repository.common.ApplicationConfigRepository;
import com.project.cepat.kelar.service.common.ApplicationConfigService;

@Service
public class ApplicationConfigServiceImpl implements ApplicationConfigService {

	private final ApplicationConfigRepository applicationConfigRepository;

    public ApplicationConfigServiceImpl(ApplicationConfigRepository applicationConfigRepository) {
        this.applicationConfigRepository = applicationConfigRepository;
    }

    public Long getNum() {
        return applicationConfigRepository.count();
    }

    public ApplicationConfig save(ApplicationConfig applicationConfig) throws Exception {
        return applicationConfigRepository.save(applicationConfig);
    }

    public ApplicationConfig getById(Long aLong) throws Exception {
        return applicationConfigRepository.findById(aLong).orElse(null);
    }

    public Boolean delete(Long aLong) throws Exception {
        try {
            applicationConfigRepository.deleteById(aLong);
            return true;
        } catch (Exception e) {
            throw new Exception(e);
        }
    }

    public List<ApplicationConfig> getAll() throws Exception {
        return (List<ApplicationConfig>) applicationConfigRepository.findAll();
    }

    @Override
    public Page<ApplicationConfig> getPageableList(String param, int startPage, int pageSize, Sort sort) throws Exception {
        int page = DataTableObject.getPageFromStartAndLength(startPage, pageSize);
        return applicationConfigRepository.getPageable(param, PageRequest.of(page, pageSize, sort));
    }

    public ApplicationConfig getByConfigId(String configId) {
        return applicationConfigRepository.getByAppConfigId(configId);
    }
}
