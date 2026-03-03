package com.project.cepat.kelar.fe.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.ApplicationRunner;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Profile;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.project.cepat.kelar.jpa.model.Admin;
import com.project.cepat.kelar.jpa.model.User;
import com.project.cepat.kelar.jpa.repository.AdminRepository;
import com.project.cepat.kelar.jpa.repository.UserRepository;

/**
 * Loads test data into the database on application startup (dev profile only)
 */
@Configuration
@Profile("devfadhil")
public class TestDataLoader {
    
    private static final Logger logger = LoggerFactory.getLogger(TestDataLoader.class);
    
    @Autowired
    private PasswordEncoder passwordEncoder;
    
    @Bean
    public ApplicationRunner loadTestData(UserRepository userRepository, AdminRepository adminRepository) {
        return args -> {
            try {
                // Check if test user already exists
                if (userRepository.findByUsername("admin").isPresent()) {
                    logger.info("Test user 'admin' already exists");
                    return;
                }
                
                // Create test user (let sequence generate the ID)
                User testUser = new User();
                testUser.setUsername("admin");
                testUser.setEmail("admin@test.com");
                testUser.setMobile("081234567890");
                // Password: admin123
                testUser.setPassword(passwordEncoder.encode("admin123"));
                testUser.setEnabled(true);
                testUser.setAdmin(true);
                testUser.setAccountNonExpired(true);
                testUser.setAccountNonLocked(true);
                testUser.setCredentialsNonExpired(true);
                testUser.addRole("ROLE_ADMIN");
                testUser.addRole("ROLE_SYSTEM");
                
                User savedUser = userRepository.saveAndFlush(testUser);
                logger.info("Test user created: {}", savedUser.getUsername());
                
                // Create admin record
                Admin admin = new Admin();
                admin.setUserNo(savedUser);
                admin.setDescription("Test Admin User");
                adminRepository.save(admin);
                logger.info("Admin record created for user: {}", savedUser.getUsername());
                
            } catch (Exception e) {
                logger.error("Error loading test data", e);
            }
        };
    }
}
