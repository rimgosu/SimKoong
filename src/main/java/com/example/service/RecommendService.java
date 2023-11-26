package com.example.service;
import java.util.List;
import java.util.UUID;

import com.example.entity.Info;


public interface RecommendService {

	Info getRecommendUsers(String username);

	List<String> getS3Photos(Info recommendUser);

	void saveLikeInteraction(String myUsername, String oppUsername, String like_dislike);

	Boolean isCheckLikeMe(String myUsername, String oppUserName);

	UUID saveMatching(String myUsername, String oppUserName);

	Info getOppInfo(String oppUserName);

}
