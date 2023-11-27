package com.example.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.example.entity.Info;
import com.example.service.InteractionService;
import com.example.service.RecommendService;

@Controller
public class InteractionController {
	
	@Autowired
	InteractionService interactionService;
	@Autowired
	RecommendService recommendService;
	
	@GetMapping("/interaction")
	public String showInteraction(Model model) {
		System.out.println("[InteractionController][/interaction]");
		
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		String myUsername = authentication.getName();
		
		/*
		 * 받아와야하는 정보들
		 * 1. 보낸 like
		 * 2. 받은 like
		 * 3. 받은 matching
		 * 
		 * 셋을 가져온 후 각각 뿌려주는 느낌으로 가면 된다.
		 * interaction에서 각각 받은 후 Info를 리스트에 저장하면 된다.
		 */
		
		// 1. 연결된 matching
		List<Info> matchedUsers = interactionService.getMatchedUsers(myUsername);
		
		// 2. 받은 좋아요
		List<Info> likedUsers = interactionService.getLikedUsers(myUsername);
		
		// 3. 보낸 좋아요
		List<Info> likeUsers = interactionService.getLikeUsers(myUsername);
		
		model.addAttribute("matchedUsers", matchedUsers);
		model.addAttribute("likedUsers", likedUsers);
		model.addAttribute("likeUsers", likeUsers);
		
		return "interaction/interaction";
	}
	
}
