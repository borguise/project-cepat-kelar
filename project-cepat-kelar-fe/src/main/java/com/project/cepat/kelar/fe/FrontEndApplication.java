package com.project.cepat.kelar.fe;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.persistence.autoconfigure.EntityScan;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;

@SpringBootApplication(scanBasePackages = "com.project.cepat.kelar")
@EntityScan(basePackages = "com.project.cepat.kelar.jpa.model")
@EnableJpaRepositories(basePackages = "com.project.cepat.kelar.jpa.repository")
public class FrontEndApplication {

	public static void main(String[] args) {
		SpringApplication.run(FrontEndApplication.class, args);
	}

}
