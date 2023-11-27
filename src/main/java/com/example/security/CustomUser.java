package com.example.security;

import java.time.Instant;
import java.util.List;
import java.util.Map;

import org.springframework.security.core.authority.AuthorityUtils;
import org.springframework.security.core.userdetails.User;

import com.example.entity.Info;

import lombok.Data;

@Data
public class CustomUser extends User{
	
	private Info info;
	
	public CustomUser(Info info) {
		super(info.getUsername(), info.getPassword(), AuthorityUtils.createAuthorityList("ROLE_"+info.getRole().toString()));
		
		this.info = info;
		
	}
	
	public String getNickname() {
        return info.getNickname();
    }
	public String getPhone() {
        return info.getPhone();
    }
	public int getAge() {
        return info.getAge();
    }
	public String getInterest() {
        return info.getInterest();
    }
	public String getMbti() {
        return info.getMbti();
    }
	public String getSport() {
        return info.getSport();
    }
	public String getDrinking() {
        return info.getDrinking();
    }
	public String getSmoking() {
        return info.getSmoking();
    }
	public String getJob() {
        return info.getJob();
    }
	public String getSchool() {
        return info.getSchool();
    }
	public String getAboutme() {
        return info.getAboutme();
    }
	public Instant getRegister_date() {
        return info.getRegister_date();
    }
	public String getSex() {
        return info.getSex();
    }
	public Boolean getStatus() {
        return info.getStatus();
    }
	public List<String> getAddress() {
        return info.getAddress();
    }
	public Map<Integer, String> getPhoto() {
        return info.getPhoto();
    }
	
	
	
	
	 
	
	
}