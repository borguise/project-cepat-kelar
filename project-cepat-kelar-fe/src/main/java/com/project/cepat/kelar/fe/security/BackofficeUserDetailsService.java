package com.project.cepat.kelar.fe.security;

import java.util.Optional;

import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import com.project.cepat.kelar.jpa.model.User;
import com.project.cepat.kelar.jpa.repository.AdminRepository;
import com.project.cepat.kelar.jpa.repository.UserRepository;

@Service
public class BackofficeUserDetailsService implements UserDetailsService {

    private final UserRepository userRepository;
    private final AdminRepository adminRepository;

    public BackofficeUserDetailsService(UserRepository userRepository, AdminRepository adminRepository) {
        this.userRepository = userRepository;
        this.adminRepository = adminRepository;
    }

    @Override
    public UserDetails loadUserByUsername(String identifier) throws UsernameNotFoundException {
        User user = findByIdentifier(identifier)
            .orElseThrow(() -> new UsernameNotFoundException("User not found"));

        if (adminRepository.findByUserNo(user).isEmpty()) {
            throw new UsernameNotFoundException("Admin profile not found");
        }

        return user;
    }

    private Optional<User> findByIdentifier(String identifier) {
        if (identifier == null || identifier.isBlank()) {
            return Optional.empty();
        }
        return userRepository.findByUsernameAndEnabledTrue(identifier)
            .or(() -> userRepository.findByEmailAndEnabledTrue(identifier))
            .or(() -> userRepository.findByMobileAndEnabledTrue(identifier));
    }
}
