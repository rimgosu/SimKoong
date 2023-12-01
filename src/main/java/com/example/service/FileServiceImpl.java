package com.example.service;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.imageio.ImageIO;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.amazonaws.services.s3.AmazonS3;
import com.amazonaws.services.s3.model.PutObjectRequest;
import com.datastax.oss.driver.api.core.config.DriverConfigLoader;
import com.example.aws.EC2Migration;
import com.example.entity.Info;

import net.coobird.thumbnailator.Thumbnails;

@Service
public class FileServiceImpl implements FileService {

	@Autowired
	private DBService dbService;

	@Autowired // 사진 업로드할때 필요
	private AmazonS3 s3client;

	@Autowired
	private RecommendService recommendService;

	@Override
	public void handleFileUpload(MultipartFile file, int photoNum, String username) {
		try {
			Info info = getUserInfo(username);
			if (file.isEmpty()) {
				throw new IllegalArgumentException("파일이 비어 있습니다.");
			}

			File localFile = saveFileLocally(file, username, photoNum);
			File resizedFile = resizeImage(localFile);
			
			String uploadedFilePath = uploadToS3(resizedFile, username, photoNum);
			updateDatabaseWithPhoto(info, photoNum, uploadedFilePath, username);
		} catch (IOException e) {
			e.printStackTrace();
			// 적절한 예외 처리 추가
		}
	}

	private Info getUserInfo(String username) {
		DriverConfigLoader loader = dbService.getConnection();
		List<Info> infos = dbService.findAllByColumnValue(loader, Info.class, "username", username);
		return infos.isEmpty() ? null : infos.get(0);
	}

	private File saveFileLocally(MultipartFile file, String username, int photoNum) throws IOException {
		String FileName = username +"_0" + photoNum;
		EC2Migration ec2Migration = new EC2Migration();
		String localPath = ec2Migration.getFileDirectory();
		String localFilePath = localPath + FileName;
		File dest = new File(localFilePath);
		file.transferTo(dest);
		return dest;
	}

	private File resizeImage(File file) throws IOException {
		BufferedImage originalImage = ImageIO.read(file);
		BufferedImage resizedImage = Thumbnails.of(originalImage).size(640, 360).outputFormat("jpg").asBufferedImage();
		ImageIO.write(resizedImage, "jpg", file);
		return file;
	}

	private String uploadToS3(File file, String username, int photoNum) {
		String FileName = username +"_0" + photoNum;
		
		String bucketName = "simkoong-s3";
		String uploadedFilePath = "s3://simkoong-s3/" + FileName;
		s3client.putObject(new PutObjectRequest(bucketName, FileName, file));
		return uploadedFilePath;
	}

	private void updateDatabaseWithPhoto(Info info, int photoNum, String uploadedFilePath, String username) {
		Map<Integer, String> photo = info.getPhoto();
		photo.put(photoNum, uploadedFilePath);

		Map<String, Object> whereUpdate = new HashMap<>();
		Map<String, Object> updateValue = new HashMap<>();
		List<String> photos_base64 = recommendService.getS3Photos(info);

		whereUpdate.put("username", username);
		updateValue.put("photo", photo);
		updateValue.put("photo_base64", photos_base64.get(0));

		DriverConfigLoader loader = dbService.getConnection();
		dbService.updateByColumnValues(loader, Info.class, updateValue, whereUpdate);
	}
}
