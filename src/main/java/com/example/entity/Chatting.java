package com.example.entity;

import java.util.UUID;
import java.time.Instant;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class Chatting {
	
	private UUID chat_uuid;
	private UUID room_uuid;
	private String chat_chatter;
	private Instant chatted_at;
	private String chat_content;
	private String chat_emoticon;
	private Boolean read_status;
	
}