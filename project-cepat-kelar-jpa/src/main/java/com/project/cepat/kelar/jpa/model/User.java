package com.project.cepat.kelar.jpa.model;

import java.util.Arrays;
import java.util.Collection;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Map;
import java.util.Set;

import jakarta.persistence.CollectionTable;
import jakarta.persistence.Column;
import jakarta.persistence.Convert;
import jakarta.persistence.ElementCollection;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.SequenceGenerator;
import jakarta.persistence.Table;
import jakarta.persistence.Transient;

import org.hibernate.type.YesNoConverter;
import org.springframework.security.core.CredentialsContainer;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import lombok.Data;

@Entity
@Table(name = "user")
@Data
public class User implements UserDetails, CredentialsContainer {

	private static final long serialVersionUID = 6461391383421356892L;
	private static final String SEQ_GEN = "seq_gen_user";
	private static final String SEQ = "seq_user";

	@Id
	@GeneratedValue(strategy = GenerationType.AUTO, generator = SEQ_GEN)
	@SequenceGenerator(name = SEQ_GEN, sequenceName = SEQ)
	@Column(name = "NO")
	private Long no;

	@Column(name = "USERNAME", length = 100, unique = true)
	private String username;

	@Column(name = "EMAIL", unique = true, length = 191)
	private String email;

	@Column(name = "MOBILE", unique = true, length = 191)
	private String mobile;

	@Column(name = "PASSWORD", length = 100)
	private String password;

	@Convert(converter = YesNoConverter.class)
	@Column(name = "ENABLED")
	private boolean enabled;

	@ElementCollection(fetch = FetchType.EAGER)
	@CollectionTable(name = "au_user_role", joinColumns = @JoinColumn(name = "USER_NO"))
	@Column(name = "ROLE")
	private Set<String> roles = new HashSet<>();

	@Transient
	private Set<GrantedAuthority> authorities = new HashSet<>();

	@Convert(converter = YesNoConverter.class)
	@Column(name = "ACC_NON_EXP")
	private boolean accountNonExpired;

	@Convert(converter = YesNoConverter.class)
	@Column(name = "ACC_NON_LOCK")
	private boolean accountNonLocked;

	@Convert(converter = YesNoConverter.class)
	@Column(name = "CRD_NON_EXP")
	private boolean credentialsNonExpired;

	@Convert(converter = YesNoConverter.class)
	@Column(name = "IS_ADMIN")
	private boolean isAdmin;

	@Override
	public String getPassword() {
		return password;
	}

	@Override
	public String getUsername() {
		return username;
	}

	@Override
	public Collection<? extends GrantedAuthority> getAuthorities() {
		authorities.clear();
		for (String role : roles) {
			authorities.add(new SimpleGrantedAuthority(role));
		}
		return authorities;
	}

	@Override
	public boolean isAccountNonExpired() {
		return accountNonExpired;
	}

	@Override
	public boolean isAccountNonLocked() {
		return accountNonLocked;
	}

	@Override
	public boolean isCredentialsNonExpired() {
		return credentialsNonExpired;
	}

	@Override
	public boolean isEnabled() {
		return enabled;
	}

	@Override
	public void eraseCredentials() {
		password = null;
	}

	public void addRole(String... roles) {
		Map<String, Object> map = new HashMap<String, Object>();
		for (String role : roles) {
			map.put(role, null);
			this.authorities.add(new SimpleGrantedAuthority(role));
		}
		this.roles.addAll(map.keySet());
	}

	public void removeRole(String... roles) {
		Map<String, Object> map = new HashMap<String, Object>();
		for (String role : roles) {
			map.put(role, null);
			this.authorities.remove(new SimpleGrantedAuthority(role));
		}
		this.roles.removeAll(map.keySet());
	}

	@Transient
	public String getRole() {
		String[] arrRole = this.roles.stream().toArray(String[]::new);
		return Arrays.toString(arrRole);
	}

}
