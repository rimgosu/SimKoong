package com.example.service;

import java.time.Instant;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.datastax.oss.driver.api.core.config.DriverConfigLoader;
import com.example.entity.ChatRoomNotification;
import com.example.entity.Chatting;
import com.example.entity.Info;
import com.example.entity.Interaction;

import jakarta.servlet.http.HttpSession;

@Service
public class ChatServiceImpl implements ChatService {

	@Autowired
	DBService dbService;

	@Override
	public void createChatting(Chatting chatting, HttpSession session) {

		/*
		 * 채팅 생성할 때 필요한 것들 1. room_uuid : (TODO 추후 방을 클릭하면 room_uuid를 가져오는 식으로 코딩을 할 것임)
		 * 2. chatted_at : 자바에서 걍 만들면 된다 3. chat_uuid : 상대방 아이디를 좋아요 정보를 통해 가져오면 됨 (아직
		 * 구현되지 않았음) ※ chat_cotent : 발화 내용은 자바스크립트에서 chatting에 담겨서 올 것임.
		 */

		System.out.println("ChatServiceImpl, createChatting 서비스에 들어옴.");
		System.out.println(chatting.toString());
		Info membersession = (Info) session.getAttribute("mvo");

		chatting.setChatted_at(Instant.now());
		chatting.setChat_uuid(UUID.randomUUID());
		chatting.setChat_chatter(membersession.getUsername());

		DriverConfigLoader loader = dbService.getConnection();
		dbService.save(loader, Chatting.class, chatting);

	}


	@Override
	public List<Chatting> getChattings(UUID room_uuid) {
		// TODO Auto-generated method stub
		System.out.println("[ChatServiceImpl][getChattings]");

		Map<String, Object> colval = new HashMap<String, Object>();
		colval.put("room_uuid", room_uuid);

		DriverConfigLoader loader = dbService.getConnection();
		List<Chatting> chattings = dbService.findAllByColumnValues(loader, Chatting.class, colval);

		return chattings;
	}

	@Override
	public List<ChatRoomNotification> getChatRoomInteractions(String username) {
		System.out.println("[ChatServiceImpl][getChatRoomInteractions][username:" + username + "]");
		Map<String, Object> interactionColumnValues = new HashMap<>();
		interactionColumnValues.put("from_to", "from");
		interactionColumnValues.put("type", "chatting");
		interactionColumnValues.put("my_username", username);
        
		System.out.println("[interactionColumnValues.toString()]" + interactionColumnValues.toString());
        
        DriverConfigLoader loader = dbService.getConnection();
        
        List<Interaction> interactions = dbService.findAllByColumnValues(loader, Interaction.class, interactionColumnValues);
        
        List<ChatRoomNotification> chatRoomNotifications = new ArrayList<ChatRoomNotification>();
        
        for (Interaction interaction : interactions) {
        	Map<String, Object> chatColumnValues = new LinkedHashMap<>();
        	chatColumnValues.put("room_uuid", interaction.getType_uuid());
        	chatColumnValues.put("read_status", false);
        	
        	List<Chatting> chattings = dbService.findAllByColumnValues(loader, Chatting.class, chatColumnValues);
        	
        	// 내 이름과 비교하여 같으면 알림을 하지 않기.
        	chattings = chattings.stream()
                    .filter(chatting -> !chatting.getChat_chatter().equals(username))
                    .collect(Collectors.toList());
        	
        	ChatRoomNotification chatRoomNotification = new ChatRoomNotification(interaction);
        	chatRoomNotification.setNotification_count(chattings.size());
        	chatRoomNotifications.add(chatRoomNotification);
        	System.out.println(chatRoomNotification.toString());
        }
        
        
        
        return chatRoomNotifications;
	
	}


	@Override
	public void insertChatting(Chatting chatting) {
		DriverConfigLoader loader = dbService.getConnection();
		dbService.save(loader, Chatting.class, chatting);
	}


	@Override
	public UUID createChattingInteraction(Info myInfo, String oppUserName) {
		System.out.println("[ChatServiceImpl][createChattingInteraction]");
		
		/*
		 * 채팅방은 두개로 분리해 만들어야 한다.
		 * 공통요소
		 *    - from_to : "from"
		 *    - interaction_regdate : instant.now()
		 *    - type : "chatting"
		 *    - type_uuid : uuid.random()
		 */
		
		String from_to = "from";
		Instant reg_date = Instant.now();
		String type = "chatting";
		UUID chatRoomUuid = UUID.randomUUID();
		
		/*
		 * 나의 채팅 요소
		 *    - my_username : myInfo.getUsername()
		 *    - opponent_username : oppUsername()
		 *    - interaction_uuid : uuid.random()
		 */
		Interaction myChatRoom = new Interaction();
		myChatRoom.setFrom_to(from_to);
		myChatRoom.setType_uuid(chatRoomUuid);
		myChatRoom.setInteraction_regdate(reg_date);
		myChatRoom.setType(type);
		myChatRoom.setMy_username(myInfo.getUsername());
		myChatRoom.setOpponent_username(oppUserName);
		myChatRoom.setInteraction_uuid(UUID.randomUUID());
		
		/*
		 * 나의 채팅 요소
		 *    - my_username : oppUsername()
		 *    - opponent_username : myInfo.getUsername()
		 *    - interaction_uuid : uuid.random()
		 */
		Interaction oppChatRoom = new Interaction();
		oppChatRoom.setFrom_to(from_to);
		oppChatRoom.setType_uuid(chatRoomUuid);
		oppChatRoom.setInteraction_regdate(reg_date);
		oppChatRoom.setType(type);
		oppChatRoom.setMy_username(oppUserName);
		oppChatRoom.setOpponent_username(myInfo.getUsername());
		oppChatRoom.setInteraction_uuid(UUID.randomUUID());
		
		DriverConfigLoader loader = dbService.getConnection();
		dbService.save(loader, Interaction.class, myChatRoom);
		dbService.save(loader, Interaction.class, oppChatRoom);
		
		return chatRoomUuid;
	}


}