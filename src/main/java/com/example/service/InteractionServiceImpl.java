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

	@Override
	public List<Info> getMatchedUsers(String myUsername) {
		System.out.println("[InteractionServiceImpl][getMatchedUsers]");
		/*
		 * my_username : myUsername
		 * from_to : from
		 * type : matching
		 */
		try {

			HashMap<String, Object> cv = new HashMap<String, Object>();
			cv.put("my_username", myUsername);
			cv.put("from_to", "from");
			cv.put("type", "matching");
			
			DriverConfigLoader loader = dbService.getConnection();
			List<Interaction> matches = dbService.findAllByColumnValues(loader, Interaction.class, cv);
			
			List<Info> matchedUsers = new ArrayList<Info>();
			for (Interaction match : matches) {
				List<Info> infos = dbService.findAllByColumnValue(loader, Info.class, "username", match.getOpponent_username());
				try {
					Info info =  infos.get(0);
					List<String> imageDatas = recommendService.getS3Photos(info);
					info.setPhoto_base64(imageDatas.get(0));
					matchedUsers.add(info);
				} catch (Exception e) {
					System.out.println("상대 유저가 사라짐");
					System.out.println(e);
				}
			}
			
			return matchedUsers;
		} catch (Exception e) {
			System.out.println("아무와도 매칭되지 않았음.");
			System.out.println(e);
			return null;
		}
	}

	@Override
	public List<Info> getLikedUsers(String myUsername) {
		System.out.println("[InteractionServiceImpl][getLikedUsers]");
		/*
		 * my_username : myUsername
		 * from_to : from
		 * type : like
		 */
		try {

			HashMap<String, Object> cv = new HashMap<String, Object>();
			cv.put("my_username", myUsername);
			cv.put("from_to", "from");
			cv.put("type", "like");
			
			DriverConfigLoader loader = dbService.getConnection();
			List<Interaction> likes = dbService.findAllByColumnValues(loader, Interaction.class, cv);
			
			List<Info> likedUsers = new ArrayList<Info>();
			for (Interaction like : likes) {
				List<Info> infos = dbService.findAllByColumnValue(loader, Info.class, "username", like.getOpponent_username());
				try {
					Info info =  infos.get(0);
					List<String> imageDatas = recommendService.getS3Photos(info);
					info.setPhoto_base64(imageDatas.get(0));
					likedUsers.add(info);
				} catch (Exception e) {
					System.out.println("상대 유저가 사라짐");
					System.out.println(e);
				}
			}
			
			return likedUsers;
			
		} catch (Exception e) {
			System.out.println("아무에게도 좋아요 받지 않았음.");
			System.out.println(e);
			return null;
		}
	}

	@Override
	public List<Info> getLikeUsers(String myUsername) {
		System.out.println("[InteractionServiceImpl][getLikeUsers]");
		/*
		 * my_username : myUsername
		 * from_to : from
		 * type : like
		 */
		
		try {
			
			HashMap<String, Object> cv = new HashMap<String, Object>();
			cv.put("my_username", myUsername);
			cv.put("from_to", "to");
			cv.put("type", "like");
			
			DriverConfigLoader loader = dbService.getConnection();
			List<Interaction> likes = dbService.findAllByColumnValues(loader, Interaction.class, cv);
			
			System.out.println("likes" + likes.toString());
			
			List<Info> likedUsers = new ArrayList<Info>();
			for (Interaction like : likes) {
				List<Info> infos = dbService.findAllByColumnValue(loader, Info.class, "username", like.getOpponent_username());
				try {
					Info info =  infos.get(0);
					List<String> imageDatas = recommendService.getS3Photos(info);
					info.setPhoto_base64(imageDatas.get(0));
					likedUsers.add(info);
				} catch (Exception e) {
					System.out.println("상대 유저가 사라짐");
					System.out.println(e);
				}
			}
			
			return likedUsers;
			
		} catch (Exception e) {
			System.out.println("아무에게도 좋아요를 주지 않았음.");
			System.out.println(e);
			return null;
		}
		
	}

}