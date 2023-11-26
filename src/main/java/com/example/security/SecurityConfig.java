package com.example.security;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.crypto.factory.PasswordEncoderFactories;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;

@EnableWebSecurity
public class SecurityConfig {
	
	@Autowired
	private CustomUserDetailsService userService;

	@Bean
	public PasswordEncoder passwordEncoder() { //비밀번호 인코딩 기능
		return PasswordEncoderFactories.createDelegatingPasswordEncoder();
	}
	
	@Bean
	public SecurityFilterChain filterChain(HttpSecurity http) throws Exception {
	    http
	        .authorizeRequests(authz -> authz
	            .antMatchers("/css/**", "/img/**", "/js/**", "/lib/**", "/scss/**", "/video/**", "/Jointemplate/**", "/Logintemplate/**").permitAll() // 정적 리소스에 대한 접근 허용
	            .antMatchers("/", "/login", "/join").permitAll()
	            .anyRequest().authenticated()
	        )
	        .formLogin(form -> form
	            .loginPage("/login")
	            .defaultSuccessUrl("/recommend", true)
	            .permitAll()
	        )
	        .logout(logout -> logout
	            .logoutUrl("/logout")
	            .logoutSuccessUrl("/")
	            .permitAll())
	        ;
	    
	    http.userDetailsService(userService);
	    return http.build();
	}

	
}
