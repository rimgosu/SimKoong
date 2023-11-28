package com.example.service;

import java.util.List;

import com.example.entity.Info;

public interface InteractionService {

	List<Info> getMatchedUsers(String myUsername);

	List<Info> getLikedUsers(String myUsername);

	List<Info> getLikeUsers(String myUsername);

}
