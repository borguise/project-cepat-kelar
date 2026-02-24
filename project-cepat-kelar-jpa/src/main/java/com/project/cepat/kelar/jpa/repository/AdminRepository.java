package com.project.cepat.kelar.jpa.repository;

import java.util.Optional;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.querydsl.QuerydslPredicateExecutor;
import org.springframework.data.repository.query.Param;

import com.project.cepat.kelar.jpa.model.Admin;
import com.project.cepat.kelar.jpa.model.User;

public interface AdminRepository extends JpaRepository<Admin, Long>, QuerydslPredicateExecutor<Admin> {
	
	Optional<Admin> findByUserNo(User userNo);
	
	@Query(value = "select mc from Admin mc where mc.userNo.username like concat('%', :text, '%')")
	Page<Admin> getPageable(@Param("text") String text, Pageable pageable);
	
	@Query(value = "select mc from Admin mc where mc.deleted = 0")
	Page<Admin> getPageableActive(Pageable pageable);
	
}
