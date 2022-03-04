package com.project.market.security.model.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import com.project.market.security.model.dao.SecurityDao;

import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@AllArgsConstructor
@Slf4j
public class SecurityService implements UserDetailsService {
	
	@Autowired
	private SecurityDao securityDao;
	
	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		log.debug("username = {}", username);
		UserDetails member = securityDao.loadUserByUsername(username);
		log.debug("member = {}", member);
		if(member == null)
			throw new UsernameNotFoundException(username);
		return member;
	}

}
