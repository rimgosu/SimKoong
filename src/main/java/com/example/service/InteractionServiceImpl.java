package com.example.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.datastax.oss.driver.api.core.config.DriverConfigLoader;
import com.example.entity.Info;
import com.example.entity.Interaction;

@Service
public class InteractionServiceImpl implements InteractionService {

	@Autowired
	DBService dbService;

	@Autowired
	RecommendService recommendService;

	private List<Info> cachedInfos; // 전역 변수로 Info 리스트를 캐시합니다.

	@Override
	public List<Info> getMatchedUsers(String myUsername) {
	    return getInteractionUsers(myUsername, "matching", "from");
	}

	@Override
	public List<Info> getLikedUsers(String myUsername) {
	    return getInteractionUsers(myUsername, "like", "from");
	}

	@Override
	public List<Info> getLikeUsers(String myUsername) {
	    return getInteractionUsers(myUsername, "like", "to");
	}

	private List<Info> getInteractionUsers(String myUsername, String type, String fromTo) {
	    System.out.println("[InteractionServiceImpl][getInteractionUsers] type: " + type + ", fromTo: " + fromTo);
	    try {
	        if (cachedInfos == null) {
	            cachedInfos = new ArrayList<>();
	        }

	        HashMap<String, Object> cv = new HashMap<>();
	        cv.put("my_username", myUsername);
	        cv.put("from_to", fromTo);
	        cv.put("type", type);

	        DriverConfigLoader loader = dbService.getConnection();
	        List<Interaction> interactions = dbService.findAllByColumnValues(loader, Interaction.class, cv);

	        List<Info> allInfos = dbService.findAll(loader, Info.class);
	        return filterUsersByInteraction(interactions, allInfos);
	    } catch (Exception e) {
	        System.out.println("조회 중 오류 발생: " + e.getMessage());
	        return null;
	    }
	}

	private List<Info> filterUsersByInteraction(List<Interaction> interactions, List<Info> allInfos) {
	    HashMap<String, Info> infoMap = new HashMap<>();
	    for (Info info : allInfos) {
	        infoMap.put(info.getUsername(), info);
	    }

	    List<Info> users = new ArrayList<>();
	    for (Interaction interaction : interactions) {
	        String opponentUsername = interaction.getOpponent_username();
	        if (infoMap.containsKey(opponentUsername)) {
	            Info user = infoMap.get(opponentUsername);
	            if (!cachedInfos.contains(user)) { // 캐시된 정보가 없으면 처리합니다.
	                if (user.getPhoto_base64() == null) {
	                    List<String> imageDatas = recommendService.getS3Photos(user);
	                    user.setPhoto_base64(imageDatas.get(0));
	                }
	                cachedInfos.add(user); // 새로운 정보를 캐시에 추가합니다.
	            }
	            users.add(user);
	        } else {
	            System.out.println("상대 유저 정보 없음: " + opponentUsername);
	        }
	    }
	    return users;
	}



}