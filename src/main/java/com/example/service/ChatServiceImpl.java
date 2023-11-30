package com.example.service;

import java.time.Instant;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.UUID;
import java.util.function.Function;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.datastax.oss.driver.api.core.config.DriverConfigLoader;
import com.example.entity.ChatRoomNotification;
import com.example.entity.Chatting;
import com.example.entity.ChattingNotification;
import com.example.entity.Info;
import com.example.entity.Interaction;
import com.example.tools.TimeCalculator;


@Service
public class ChatServiceImpl implements ChatService {

	@Autowired
	DBService dbService;
	
	@Autowired
	RecommendService recommendService;

	@Override
	public void createChatting(Chatting chatting, String username) {

		/*
		 * 채팅 생성할 때 필요한 것들 1. room_uuid : (TODO 추후 방을 클릭하면 room_uuid를 가져오는 식으로 코딩을 할 것임)
		 * 2. chatted_at : 자바에서 걍 만들면 된다 3. chat_uuid : 상대방 아이디를 좋아요 정보를 통해 가져오면 됨 (아직
		 * 구현되지 않았음) ※ chat_cotent : 발화 내용은 자바스크립트에서 chatting에 담겨서 올 것임.
		 */

		System.out.println("ChatServiceImpl, createChatting 서비스에 들어옴.");
		System.out.println(chatting.toString());

		chatting.setChatted_at(Instant.now());
		chatting.setChat_uuid(UUID.randomUUID());
		chatting.setChat_chatter(username);

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
	public List<ChattingNotification> getChattingNotifications(UUID room_uuid) {
		// TODO Auto-generated method stub
		System.out.println("[ChatServiceImpl][getChattingNotifications]");

		Map<String, Object> colval = new HashMap<String, Object>();
		colval.put("room_uuid", room_uuid);

		DriverConfigLoader loader = dbService.getConnection();
		List<Chatting> chattings = dbService.findAllByColumnValues(loader, Chatting.class, colval);
		List<ChattingNotification> chattingNotifications = new ArrayList<ChattingNotification>();
		
		// Info 객체를 저장할 맵 (임시 저장소)
	    Map<String, Info> infoCache = new HashMap<>();
		
		for (Chatting chatting : chattings) {
			// 기본 속성 복사
		    ChattingNotification chattingNotification = new ChattingNotification();
		    chattingNotification.setChat_chatter(chatting.getChat_chatter());
		    chattingNotification.setChat_content(chatting.getChat_content());
		    if (chatting.getChat_emoticon() != null) {
		    	chattingNotification.setChat_emoticon(chatting.getChat_emoticon());		    	
		    }
		    chattingNotification.setChat_uuid(chatting.getChat_uuid());
		    chattingNotification.setChatted_at(chatting.getChatted_at());
		    chattingNotification.setRead_status(chatting.getRead_status());
		    chattingNotification.setRoom_uuid(chatting.getRoom_uuid());
		    
		    /*
		     * private String photo_base64;
		     * private String nickname;
		     * private String relative_time;
		     */
		    
		    // photo_base64
		    String chatterName = chatting.getChat_chatter();
	        Info info;

	        if (!infoCache.containsKey(chatterName)) {
	            // 새로운 chatterName에 대한 Info 조회
	            List<Info> infos = dbService.findAllByColumnValue(loader, Info.class, "username", chatterName);
	            info = infos.get(0);
	            infoCache.put(chatterName, info);
	        } else {
	            // 캐시된 Info 사용
	            info = infoCache.get(chatterName);
	        }

        	if (info.getPhoto_base64() == null) {
        		List<String> photos_base64 = recommendService.getS3Photos(info);
        		chattingNotification.setPhoto_base64(photos_base64.get(0));
        	} else {
        		chattingNotification.setPhoto_base64(info.getPhoto_base64());
        	}
        	
        	// nickname
        	chattingNotification.setNickname(info.getNickname());
        	
        	// relative_time
        	Instant abs_time = chatting.getChatted_at();
        	TimeCalculator timeCalculator = new TimeCalculator();
        	String formattedTime = timeCalculator.formatTimeKST(abs_time);

        	chattingNotification.setRelative_time(formattedTime);

        	
        	chattingNotifications.add(chattingNotification);
		    
		}
		
		return chattingNotifications;
	}

	@Override
	public List<ChatRoomNotification> getChatRoomInteractions(String username) {
		System.out.println("[ChatServiceImpl][getChatRoomInteractions][username:" + username + "]");
		Map<String, Object> interactionColumnValues = new HashMap<>();
		interactionColumnValues.put("from_to", "from");
		interactionColumnValues.put("type", "chatting");
		interactionColumnValues.put("my_username", username);
		
        DriverConfigLoader loader = dbService.getConnection();
        
        List<Interaction> interactions = dbService.findAllByColumnValues(loader, Interaction.class, interactionColumnValues);
        
        System.out.println("[interactions]" + interactions.toString());
        
        List<ChatRoomNotification> chatRoomNotifications = new ArrayList<ChatRoomNotification>();
        
        for (Interaction interaction : interactions) {
        	ChatRoomNotification chatRoomNotification = new ChatRoomNotification(interaction);
        	
        	Map<String, Object> chatColumnValues = new LinkedHashMap<>();
        	chatColumnValues.put("room_uuid", interaction.getType_uuid());
        	chatColumnValues.put("read_status", false);
        	
        	List<Chatting> chattings = dbService.findAllByColumnValues(loader, Chatting.class, chatColumnValues);
        	
        	/*
        	 * private String photo_base64;
        	 * private String nickname;
        	 * private String last_chatting;
        	 * private String relative_time;
        	 */
        	List<Info> infos = dbService.findAllByColumnValue(loader, Info.class, "username", interaction.getOpponent_username());
        	Info info = infos.get(0);
        	
        	// photo_base64
        	if (info.getPhoto_base64() == null) {
        		List<String> photos_base64 = recommendService.getS3Photos(info);
        		chatRoomNotification.setPhoto_base64(photos_base64.get(0));
        	} else {
        		chatRoomNotification.setPhoto_base64(info.getPhoto_base64());
        	}
        	
        	// nickname
        	chatRoomNotification.setNickname(info.getNickname());
        	
        	// last_chatting
        	// relative_time
        	Map<String, Object> last_chattingCV = new LinkedHashMap<>();
        	last_chattingCV.put("room_uuid", interaction.getType_uuid());
        	last_chattingCV.put("chat_chatter", interaction.getOpponent_username());
        	List<Chatting> last_chattings = dbService.findAllByColumnValues(loader, Chatting.class, last_chattingCV);
        	
        	Chatting last_chatting = null;
        	Instant abs_time = null;
        	if (last_chattings != null && !last_chattings.isEmpty()) {
        		last_chatting = last_chattings.stream().reduce((first, second) -> second).orElse(null);
        		abs_time = last_chatting.getChatted_at();
        		
        		chatRoomNotification.setLast_chatting(last_chatting.getChat_content());
            	
            	TimeCalculator timeCalculator = new TimeCalculator();
            	String relative_time = timeCalculator.timeAgo(abs_time);
            	
            	chatRoomNotification.setRelative_time(relative_time);
        	}
        	
        	// 내 이름과 비교하여 같으면 알림을 하지 않기.
        	chattings = chattings.stream()
                    .filter(chatting -> !chatting.getChat_chatter().equals(username))
                    .collect(Collectors.toList());
        	
        	
        	chatRoomNotification.setNotification_count(chattings.size());
        	chatRoomNotifications.add(chatRoomNotification);
        }
        
        
        
        return chatRoomNotifications;
	
	}


	@Override
	public void insertChatting(Chatting chatting) {
		
		chatting.setChat_uuid(UUID.randomUUID());
		chatting.setChatted_at(Instant.now());
		chatting.setRead_status(false);
		
		DriverConfigLoader loader = dbService.getConnection();
		dbService.save(loader, Chatting.class, chatting);
	}


	@Override
	public UUID createChattingInteraction(String username, String oppUserName) {
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
		myChatRoom.setMy_username(username);
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
		oppChatRoom.setOpponent_username(username);
		oppChatRoom.setInteraction_uuid(UUID.randomUUID());
		
		DriverConfigLoader loader = dbService.getConnection();
		dbService.save(loader, Interaction.class, myChatRoom);
		dbService.save(loader, Interaction.class, oppChatRoom);
		
		return chatRoomUuid;
	}

	@Override
	public ChattingNotification getChattingNotification(Chatting chatting) {
	    System.out.println("[ChatServiceImpl][getChattingNotification]");

	    ChattingNotification chattingNotification = new ChattingNotification();

	    if (chatting.getChat_chatter() != null) {
	        chattingNotification.setChat_chatter(chatting.getChat_chatter());
	    } if (chatting.getChat_content() != null) {
	        chattingNotification.setChat_content(chatting.getChat_content());
	    } if (chatting.getChat_emoticon() != null) {
	        chattingNotification.setChat_emoticon(chatting.getChat_emoticon());
	    } if (chatting.getChat_uuid() != null) {
	        chattingNotification.setChat_uuid(chatting.getChat_uuid());
	    } if (chatting.getChatted_at() != null) {
	        chattingNotification.setChatted_at(chatting.getChatted_at());
	    } if (chatting.getRead_status() != null) {
	        chattingNotification.setRead_status(chatting.getRead_status());
	    } if (chatting.getRoom_uuid() != null) {
	        chattingNotification.setRoom_uuid(chatting.getRoom_uuid());
	    }
	    
	    DriverConfigLoader loader = dbService.getConnection();
	    List<Info> infos = dbService.findAllByColumnValue(loader, Info.class, "username", chatting.getChat_chatter());
    	Info info = infos.get(0);
    	
    	// photo_base64
    	if (info.getPhoto_base64() == null) {
    		List<String> photos_base64 = recommendService.getS3Photos(info);
    		chattingNotification.setPhoto_base64(photos_base64.get(0));
    	} else {
    		chattingNotification.setPhoto_base64(info.getPhoto_base64());
    	}
    	
    	// nickname
    	chattingNotification.setNickname(info.getNickname());
    	
    	// relative_time
    	Instant abs_time = chatting.getChatted_at();
    	TimeCalculator timeCalculator = new TimeCalculator();
    	String formattedTime = timeCalculator.formatTimeKST(abs_time);

    	chattingNotification.setRelative_time(formattedTime);
    	
	    return chattingNotification;
	}



}