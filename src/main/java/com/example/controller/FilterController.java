package com.example.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.amazonaws.services.s3.AmazonS3;
import com.datastax.oss.driver.api.core.config.DriverConfigLoader;
import com.example.entity.Filter;
import com.example.entity.Info;
import com.example.service.DBService;
import com.example.service.FilterService;
import com.example.service.InfoService;
import com.example.service.RecommendService;

@Controller
public class FilterController {

	@Autowired
	private InfoService infoService;
	@Autowired
	private DBService dbService;
	@Autowired // 사진 업로드할때 필요
	private AmazonS3 s3client;
	@Autowired
	private FilterService filterService;
	
	@Autowired
	PasswordEncoder passwordEncoder;
	@Autowired
	RecommendService recommendService;
	
	@PostMapping("/filterUpdate")
    public String filterUpdate(RedirectAttributes redirectAttributes, Model model, @RequestParam("gender") String gender,@RequestParam("maximum_distance") int maximum_distance, @RequestParam("lower") int lower, @RequestParam("upper") int upper) {
         List<Integer> age_range = new ArrayList<>();
         age_range.add(lower); // 0번 자리에 최소연령 추가
         age_range.add(upper); // 1번 자리에 최대연령 추가
         
       Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
       String username = authentication.getName();
       Filter filter = new Filter(username,age_range,gender,maximum_distance);
       filterService.updateFilter(filter);
       DriverConfigLoader loader = dbService.getConnection();
       List<Info> infos = dbService.findAllByColumnValue(loader, Info.class, "username", username);
       Info userInfo = (Info) infos.get(0);

       redirectAttributes.addFlashAttribute("filter", filter);
       redirectAttributes.addFlashAttribute("mvo", userInfo);
       
       return "redirect:/profile";
    }
	
	
	
	

	
}
