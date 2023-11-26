package com.example.service;

import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import com.example.entity.ChatRoomNotification;
import com.example.entity.Chatting;
import com.example.entity.Info;

public interface ChatService {

	void createChatting(Chatting chatting, String username);

	List<Chatting> getChattings(UUID room_uuid);

	List<ChatRoomNotification> getChatRoomInteractions(String username);

	void insertChatting(Chatting chatting);

	UUID createChattingInteraction(String username, String oppUserName);

	
	
	
}
