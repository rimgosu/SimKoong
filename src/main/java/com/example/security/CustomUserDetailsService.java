package com.example.security;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import com.datastax.oss.driver.api.core.config.DriverConfigLoader;
import com.example.entity.Info;
import com.example.service.DBService;

@Service
public class CustomUserDetailsService implements UserDetailsService {

    @Autowired
    DBService dbService;
    
    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        
    	Map<String, Object> CV = new HashMap<String, Object>();
    	
    	CV.put("username", username);
    	
    	DriverConfigLoader loader = dbService.getConnection();
    	List<Info> info = dbService.findAllByColumnValues(loader, Info.class, CV);
    	
    	if (info.size() == 0 ) {
    		throw new UsernameNotFoundException(username+"없음");
    	}
    	return new CustomUser(info.get(0));
    	
    }
}