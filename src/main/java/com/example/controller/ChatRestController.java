package com.example.controller;


import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.datastax.oss.driver.api.core.config.DriverConfigLoader;
import com.example.entity.Chatting;
import com.example.entity.Info;
import com.example.service.ChatService;
import com.example.service.DBService;

@RestController
public class ChatRestController {
	
	@Autowired
	ChatService chatService;
	@Autowired
	DBService dbService;
	
	
	@PostMapping("/CreateChatting")
    public void createChatting(@RequestBody Chatting chatting) {
        // 채팅방 생성 로직
		System.out.print("[ChatRestController][/CreateChatting]");
		
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		String username = authentication.getName();
		
		chatService.createChatting(chatting, username);
    }
	
	@GetMapping("/GetChatting")
    public List<Chatting> getChatting(@RequestParam UUID room_uuid) {
		System.out.println("[ ChatRestController ] [ getChatting ] [ room_uuid : " + room_uuid + "]");
		
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
	    String username = authentication.getName();
		
		List<Chatting> chattings = chatService.getChattings(room_uuid);
		
		System.out.println("[ ChatRestController ] [ getChatting ] 변환 전 : " + chattings.toString());
		
		// 클릭 시 "chatting" 테이블의 상대방의 read_status를 true로 바꿈
		DriverConfigLoader loader = dbService.getConnection();
	    Map<String, Object> updateValues = new HashMap<String, Object>();
	    updateValues.put("read_status", true);
	    
		for (Chatting chatting : chattings) {
			
	        if (!chatting.getChat_chatter().equals(username)) {
	        	Map<String, Object> whereValues = new HashMap<String, Object>();
	        	whereValues.put("chat_uuid", chatting.getChat_uuid());
	        	whereValues.put("room_uuid", chatting.getRoom_uuid());
	        	whereValues.put("chatted_at", chatting.getChatted_at());
	        	
	        	dbService.updateByColumnValues(loader, Chatting.class, updateValues, whereValues);
	        }
	    }
	    
		List<Chatting> changedChattings = chatService.getChattings(room_uuid);
	    System.out.println("[ ChatRestController ] [ getChatting ] 변환 후 : " + changedChattings.toString());
		
        return changedChattings; // 채팅 목록 반환
    }
	

}
