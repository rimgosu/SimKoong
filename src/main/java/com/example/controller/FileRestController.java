package com.example.controller;

import java.net.URL;
import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.amazonaws.AmazonServiceException;
import com.amazonaws.HttpMethod;
import com.amazonaws.services.s3.AmazonS3;
import com.amazonaws.services.s3.model.GeneratePresignedUrlRequest;

@RestController
public class FileRestController {

	@Autowired
    private AmazonS3 s3client;

    // 사전 서명된 URL 생성
    @GetMapping("/generatePresignedUrl")
    public ResponseEntity<String> generatePresignedUrl(@RequestParam("fileName") String fileName) {
        try {
            // 파일 이름으로 버킷 내 객체 키 생성
            String objectKey = "uploads/" + fileName;

            // 사전 서명된 URL 생성
            Date expiration = new Date();
            long expTimeMillis = expiration.getTime();
            expTimeMillis += 1000 * 60 * 60; // 1시간 후 만료
            expiration.setTime(expTimeMillis);

            GeneratePresignedUrlRequest generatePresignedUrlRequest =
                    new GeneratePresignedUrlRequest("simkoong-s3", objectKey)
                            .withMethod(HttpMethod.PUT)
                            .withExpiration(expiration);

            URL url = s3client.generatePresignedUrl(generatePresignedUrlRequest);

            return ResponseEntity.ok(url.toString());
        } catch (AmazonServiceException e) {
            e.printStackTrace();
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Error generating URL");
        }
    }
	
	
}
