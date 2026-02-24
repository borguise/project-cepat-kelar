package com.project.cepat.kelar.jpa.repository;

import java.util.List;
import java.util.Optional;
import java.util.Set;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.querydsl.QuerydslPredicateExecutor;
import org.springframework.data.repository.query.Param;

import com.project.cepat.kelar.jpa.model.User;

public interface UserRepository extends JpaRepository<User, Long>, QuerydslPredicateExecutor<User> {
	
	Optional<User> findByUsername(String username);

	Optional<User> findByNo(Long no);
	
	Optional<User> findByEmail(String email);
	
	Optional<User> findByMobile(String mobile);
	
	Optional<User> findByUsernameAndEnabledTrue(String username);
	
	Optional<User> findByEmailAndEnabledTrue(String email);
	
	Optional<User> findByMobileAndEnabledTrue(String mobile);
	
	Optional<User> findByUsernameAndPasswordAndEnabledTrue(String username, String password);
	
	List<User> findByRoles(Set<String> roles);
	
	@Query(value = "select mc from User mc where mc.username like  %:text%")
	Page<User> getPageable(@Param("text") String text, Pageable pageable);
	
//    @Query(value = "select a from User a where a.username like %:sSearch% ")
//    Page<User> getPageable(@Param("sSearch") String sSearch, Pageable pageable);
//    
//    @Query(value = "select role from User a where a.username =:username")
//    String getRoleByUser(@Param("username") String username);
//    
//    @Query(value = "select a from User a where a.username =:username")
//    User getByUser(@Param("username") String username);
//    
//    @Query(value = "select a from User a where a.username =:username")
//    User getByUserName(@Param("username") String username);
}
