package com.example.service;

import java.util.List;
import java.util.UUID;

import com.example.entity.ChatRoomNotification;
import com.example.entity.Chatting;
import com.example.entity.Info;

import jakarta.servlet.http.HttpSession;

public interface ChatService {

	void createChatting(Chatting chatting, HttpSession session);

	List<Chatting> getChattings(UUID room_uuid);

	List<ChatRoomNotification> getChatRoomInteractions(String username);

	void insertChatting(Chatting chatting);

	UUID createChattingInteraction(Info myInfo, String oppUserName);

	
	
	
}
