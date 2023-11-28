package com.example.service;

import java.util.List;
import java.util.UUID;

import com.example.entity.ChatRoomNotification;
import com.example.entity.Chatting;
import com.example.entity.ChattingNotification;

public interface ChatService {

	void createChatting(Chatting chatting, String username);

	List<Chatting> getChattings(UUID room_uuid);

	List<ChatRoomNotification> getChatRoomInteractions(String username);

	void insertChatting(Chatting chatting);

	UUID createChattingInteraction(String username, String oppUserName);

	List<ChattingNotification> getChattingNotifications(UUID room_uuid);

	ChattingNotification getChattingNotification(Chatting chatting);

	
	
	
}
