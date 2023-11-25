package com.example.controller;
import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
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

import jakarta.servlet.http.HttpSession;

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
	public String showChatRoom(Model model, HttpSession session) {
		System.out.println("[ChatController][@GetMapping][/showChatRoom]");
		
		Info info = (Info) session.getAttribute("mvo");
		List<ChatRoomNotification> chatRoomNotifications = chatService.getChatRoomInteractions(info.getUsername());
		model.addAttribute("chatRoomNotifications", chatRoomNotifications);
		
		model.addAttribute("hostAddress", new EC2MetadataService().getEC2InstancePublicIPv4());
		
		return "/chat/showChatRoom";
	}
	
	@GetMapping("/createChatting")
	public String createChatting(@RequestParam String oppUserName, HttpSession session, RedirectAttributes rttr) {
		System.out.println("[ChatController][/createChatting]");
		
		Info myInfo = (Info) session.getAttribute("mvo");
		
		// 상대 이름, 내 이름을 이용하여 interaction의 chatting을 상대입장, 내입장으로 만든다.
		UUID chatRoomUuid = chatService.createChattingInteraction(myInfo, oppUserName);
		
		rttr.addFlashAttribute("chatRoomUuid", chatRoomUuid);
		
		return "redirect:/showChatRoom";
		
	}
	
	
	
}
