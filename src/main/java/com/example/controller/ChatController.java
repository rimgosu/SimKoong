package com.example.controller;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.example.aws.EC2MetadataService;
import com.example.aws.EC2Migration;
import com.example.entity.ChatRoomNotification;
import com.example.entity.Info;
import com.example.service.ChatService;


@Controller
public class ChatController {
	
	@Autowired
	private ChatService chatService;
	
	@GetMapping("/chat")
	public String showChatPage() {
		System.out.println("채팅으로 들어왔음.");
		return "/chat/chat";
	}

	@GetMapping("/showChatRoom")
	public String showChatRoom(Model model) {
		System.out.println("[ChatController][@GetMapping][/showChatRoom]");
		
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		String username = authentication.getName();
		
		List<ChatRoomNotification> chatRoomNotifications = chatService.getChatRoomInteractions(username);
		model.addAttribute("chatRoomNotifications", chatRoomNotifications);
		
		EC2Migration ec2Migration = new EC2Migration();
		if (ec2Migration.osName.contains("win")) {
			model.addAttribute("hostAddress", "localhost");
		} else {
			model.addAttribute("hostAddress", new EC2MetadataService().getEC2InstancePublicIPv4());
			
		}
		
		
		return "/chat/showChatRoom";
	}
	
	@GetMapping("/createChatting")
	public String createChatting(@RequestParam String oppUserName, RedirectAttributes rttr) {
		System.out.println("[ChatController][/createChatting]");
		
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		String username = authentication.getName();
		
		// 상대 이름, 내 이름을 이용하여 interaction의 chatting을 상대입장, 내입장으로 만든다.
		UUID chatRoomUuid = chatService.createChattingInteraction(username, oppUserName);
		
		rttr.addFlashAttribute("chatRoomUuid", chatRoomUuid);
		
		return "redirect:/showChatRoom";
		
	}
	
	
	
}
