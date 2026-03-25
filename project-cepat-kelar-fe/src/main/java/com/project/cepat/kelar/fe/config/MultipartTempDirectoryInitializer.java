package com.project.cepat.kelar.fe.config;

import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

import jakarta.annotation.PostConstruct;

@Component
public class MultipartTempDirectoryInitializer {

    @Value("${spring.servlet.multipart.location:./tmp/uploads}")
    private String multipartTempLocation;

    @PostConstruct
    public void ensureMultipartTempDirectoryExists() throws Exception {
        Path uploadTempPath = Paths.get(multipartTempLocation).toAbsolutePath().normalize();
        Files.createDirectories(uploadTempPath);
    }
}
