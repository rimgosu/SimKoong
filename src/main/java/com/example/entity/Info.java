package com.example.entity;

import java.util.List;
import java.util.Map;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

import java.time.Instant;

@Data
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class Info {
    private String username;
    private String password;
    private String nickname;
    private String phone;
    private int age;
    private String interest;
    private String mbti;
    private String sport;
    private String drinking;
    private String smoking;
    private String job;
    private String school;
    private String aboutme;
    private Instant register_date;
    private String sex;
    private Boolean status;
    private Boolean isFirst;
    private String photo_base64;
    private List<String> photos_base64;
    private List<String> role;
    private List<String> address;
    private Map<Integer, String> photo;

}
