package com.example.websocketconfig;

import java.time.Instant;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.stereotype.Controller;

import com.example.entity.Chatting;
import com.example.entity.ChattingNotification;
import com.example.service.ChatService;

@Controller
public class GreetingController {
	
	@Autowired
	ChatService chatService;

	/*
	 * "/app/hello" : 클라이언트 -> 서버 메시지 받음.
	 * "/topic/greetings" : 서버 -> 구독하는 모든 클라이언트에게 전송.
	 */
	
	@MessageMapping("/hello")
	@SendTo("/topic/greetings")
	public ChattingNotification greeting(Chatting chatting) throws Exception {
		System.out.println("[GreetingController][@MessageMapping(\"/hello\")][chatting]"+ chatting.toString());
		
		
		chatService.insertChatting(chatting);
		/*
		 * private String photo_base64;
		 * private String nickname;
		 * private String relative_time;
		 */
		
		ChattingNotification chattingNotification = chatService.getChattingNotification(chatting);
		
		
		
		
		Thread.sleep(1000);
		// Greeting 객체를 만들고 반환함
		return chattingNotification;
	}

}
