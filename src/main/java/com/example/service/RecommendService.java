package com.example.service;
import java.util.List;
import java.util.UUID;

import com.example.entity.Info;


public interface RecommendService {

	Info getRecommendUsers(Info info);

	List<String> getS3Photos(Info recommendUser);

	void saveLikeInteraction(String myUsername, String oppUsername, String like_dislike);

	Boolean isCheckLikeMe(Info info, String oppUserName);

	UUID saveMatching(Info info, String oppUserName);

	Info getOppInfo(String oppUserName);

}
