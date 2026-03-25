package com.project.cepat.kelar.fe.config;

import java.util.Optional;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.data.domain.AuditorAware;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;

import com.project.cepat.kelar.jpa.model.User;

@Configuration
public class AuditorAwareConfig {

    @Bean
    public AuditorAware<String> auditorProvider() {
        return new AuditorAwareImpl();
    }

    public static class AuditorAwareImpl implements AuditorAware<String> {

        @Override
        public Optional<String> getCurrentAuditor() {
            String auditor = "SYSTEM";
            try {
                Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
                
                if (authentication != null && authentication.isAuthenticated()) {
                    Object principal = authentication.getPrincipal();
                    
                    if (principal instanceof User) {
                        User user = (User) principal;
                        String username = user.getUsername();
                        if (username != null && !username.isEmpty()) {
                            return Optional.of(username);
                        }
                    }
                    
                    if (principal instanceof String) {
                        String principalStr = (String) principal;
                        if (!principalStr.isEmpty() && !"anonymousUser".equals(principalStr)) {
                            return Optional.of(principalStr);
                        }
                    }
                }
            } catch (Exception e) {
                // Silently fall through to SYSTEM
            }
            return Optional.of(auditor);
        }
    }
}
