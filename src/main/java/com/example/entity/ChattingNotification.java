package com.example.entity;

import java.time.Instant;
import java.util.UUID;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class ChattingNotification{
	
	private UUID chat_uuid;
	private UUID room_uuid;
	private String chat_chatter;
	private Instant chatted_at;
	private String chat_content;
	private String chat_emoticon;
	private Boolean read_status;
	
    private String photo_base64;
    private String nickname;
    private String relative_time;

    
}