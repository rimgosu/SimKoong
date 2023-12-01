package com.example.service;

import org.springframework.web.multipart.MultipartFile;

public interface FileService {

	public void handleFileUpload(MultipartFile file, int photoNum, String username);

}