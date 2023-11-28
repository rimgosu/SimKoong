package com.example.controller;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.codec.binary.Base64;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.amazonaws.services.s3.AmazonS3;
import com.amazonaws.services.s3.model.PutObjectRequest;
import com.amazonaws.services.s3.model.S3Object;
import com.amazonaws.services.s3.model.S3ObjectInputStream;
import com.amazonaws.util.IOUtils;
import com.datastax.oss.driver.api.core.config.DriverConfigLoader;
import com.example.aws.EC2Migration;
import com.example.entity.AddressData;
import com.example.entity.Info;
import com.example.service.DBService;
import com.example.service.InfoService;
import com.example.service.RecommendService;

import net.coobird.thumbnailator.Thumbnails;

@Controller
public class MainController {

	@Autowired
	private InfoService infoService;
	@Autowired
	private DBService dbService;
	@Autowired // 사진 업로드할때 필요
	private AmazonS3 s3client;
	@Autowired
	PasswordEncoder passwordEncoder;
	@Autowired
	RecommendService recommendService;

	@GetMapping("/fileUploadTest")
	public String fileUploadTest() {
		System.out.println("[MainController][/fileUploadTest]");
		return "fileUploadTest";
	}

	@GetMapping("/")
	public String showMainPage() {
		System.out.println("main으로 들어왔음.");
		return "redirect:login";
	}

	@GetMapping("/home")
	public String showMainPage2() {
		System.out.println("[MainController][/index]");
		return "recommend";
	}

	@GetMapping("/index2")
	public String showMainPage3() {
		System.out.println("[MainController][/index2]");
		return "recommend";
	}

	@GetMapping("/like")
	public String showLikePage() {
		System.out.println("좋아요로 들어왔음.");
		return "like";
	}

	@GetMapping("/login")
	public String showLoginPage() {
		System.out.println("로그인으로 들어왔음.");
		return "login";
	}

	@PostMapping("/login")
	public String showLoginPage(Info info, HttpSession session) {
		System.out.println("로그인 페이지로 들어왔음" + info.toString());

		Map<String, Object> columnValues = new HashMap<>();
		columnValues.put("username", info.getUsername());
		columnValues.put("password", info.getPassword());

		DriverConfigLoader loader = dbService.getConnection();
		List<Info> listInfo = dbService.findAllByColumnValues(loader, Info.class, columnValues);

		if (listInfo.size() == 0) {
			return "redirect:/index";
		} else {
			session.setAttribute("mvo", listInfo.get(0));
			System.out.println(listInfo.get(0));
			return "redirect:/recommend";
		}

	}

	@GetMapping("/logout")
	public String logout(HttpSession session) {
		session.invalidate();
		return "redirect:/index";
	}

	@GetMapping("/join")
	public String showJoinPage() {
		System.out.println("회원가입 들어옴.");
		return "join";
	}

	@PostMapping("/join")
	public String showJoinPage(@RequestParam("nickname") String nickname, @RequestParam("username") String username,
			@RequestParam("password") String password) {

		System.out.println("[MainController][/join]");

		infoService.InsertInfo(nickname, username, passwordEncoder.encode(password));
		DriverConfigLoader loader = dbService.getConnection(); // db연결
		Map<String, Object> columnValues = new HashMap<>();
		columnValues.put("username", username);
		List<Info> listInfo = dbService.findAllByColumnValues(loader, Info.class, columnValues);

		if (listInfo.size() == 0) {
			return "redirect:join";
		} else {
			return "redirect:/login";
		}
	}

	@GetMapping("/photoUpload") // 사진 업로드 하는 페이지로 이동
	public String showInfoPage(Model model) {
		System.out.println("사진입력으로 들어왔음.");
		// 사진 출력되는 곳

		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		String username = authentication.getName();
		DriverConfigLoader loader = dbService.getConnection();
		List<Info> infos = dbService.findAllByColumnValue(loader, Info.class, "username", username);
		Info userInfo = (Info) infos.get(0);

		Map<Integer, String> photoMap = userInfo.getPhoto();
		List<String> imageDatas = new ArrayList<>();
		// aws에서 가져오기
		String bucketName = "simkoong-s3";
		String base64Encoded = null;
		if (photoMap != null) {
			for (int i = 1; i <= 4; i++) {
				String imagePath = photoMap.get(i);
				if (imagePath != null) {
					File file = new File(imagePath);
					String fileName = file.getName();
					System.out.println(fileName);
					try {
						S3Object s3object = s3client.getObject(bucketName, fileName);
						S3ObjectInputStream inputStream = s3object.getObjectContent();
						byte[] bytes = IOUtils.toByteArray(inputStream);
						base64Encoded = Base64.encodeBase64String(bytes);
						imageDatas.add(base64Encoded);
					} catch (Exception e) {
						// 파일이 존재하지 않을 때 빈 이미지 추가
						base64Encoded = ""; // 빈 문자열 또는 기본 이미지 URL 설정
						imageDatas.add(base64Encoded);
					}
				}
			}
		}
		model.addAttribute("imageDatas", imageDatas);
		model.addAttribute("imageData", base64Encoded);
		return "photoUpload";
	}

	@PostMapping("/photoUpload") // 사진 업로드 하는 페이지에서 index로 이동함.
	public String showInfoPage(Info info, HttpServletRequest request) {
		System.out.println("[MainController][/photoUpload]");

		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		String username_session = authentication.getName();
		infoService.InsertInfoAdditional(info, username_session);
		return "redirect:/index";

	}

	@PostMapping("/fileUpload")
	public String fileUpload(@RequestParam("file") MultipartFile file, @RequestParam("photoNum") int photoNum,
			HttpServletRequest request) {
		// ... [기존 코드 유지] ...
		System.out.println("[MainController][/fileUpload]");

		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		String username_session = authentication.getName();

		DriverConfigLoader loader = dbService.getConnection();
		List<Info> infos = dbService.findAllByColumnValue(loader, Info.class, "username", username_session);
		Info info = infos.get(0);

		String originalFilename = null;
		String uploadedFilePath_aws = null;
		try {
			// 고정된 로컬 경로 설정
			EC2Migration ec2Migration = new EC2Migration();
			
			String localPath = ec2Migration.getFileDirectory();
			String uploadedFilePath = null;

			// 업로드된 파일 처리
			if (!file.isEmpty()) {
				originalFilename = file.getOriginalFilename();
				// 고정된 로컬 경로와 원본 파일 이름을 조합
				String localFilePath = localPath + originalFilename;
				File dest = new File(localFilePath);

				// 파일 저장
				file.transferTo(dest);

				// 이미지 리사이징
				BufferedImage originalImage = ImageIO.read(dest);
				BufferedImage resizedImage = Thumbnails.of(originalImage).size(640, 360) // 원하는 이미지 크기로 리사이징
						.outputFormat("jpg") // 출력 포맷 설정
						.asBufferedImage();

				// 리사이징된 이미지를 새 파일로 저장
				File resizedFile = new File(localFilePath); // 같은 경로에 저장
				ImageIO.write(resizedImage, "jpg", resizedFile);

				// AWS S3 업로드를 위한 경로 설정
				uploadedFilePath = localFilePath.replace("\\\\", "/");
				uploadedFilePath_aws = "s3://simkoong-s3/" + originalFilename;

			}

			// ... [AWS S3 업로드 및 데이터베이스 업데이트 로직] ...
			// AWS S3 관련 코드
			File fileForS3 = new File(uploadedFilePath);
			String bucketName = "simkoong-s3";
			String fileName = originalFilename;

			System.out.println("[bucketName : ]" + bucketName);
			System.out.println("[fileName : ]" + fileName);
			System.out.println("[fileName : ]" + fileForS3);

			s3client.putObject(new PutObjectRequest(bucketName, fileName, fileForS3));

			// listinfo 정보 전체 가져오기
			Map<String, Object> columnValues = new HashMap<>();
			columnValues.put("username", username_session);

			List<Info> listInfo = dbService.findAllByColumnValues(loader, Info.class, columnValues);

			// 업데이트할 정보를 Map형식의 photo에 넣기.
			Map<Integer, String> photo = listInfo.get(0).getPhoto();
			photo.put(photoNum, uploadedFilePath_aws);

			// 어디를 업데이트할지, 값은 뭔지를 설정하기
			Map<String, Object> whereUpdate = new HashMap<>();
			Map<String, Object> updateValue = new HashMap<>();

			List<String> photos_base64 = recommendService.getS3Photos(info);

			whereUpdate.put("username", username_session);
			updateValue.put("photo", photo);
			updateValue.put("photo_base64", photos_base64.get(0));

			// 업데이트 진행
			dbService.updateByColumnValues(loader, Info.class, updateValue, whereUpdate);
		} catch (IOException e) {
			e.printStackTrace();
		}

		// ... [기존 코드 유지] ...
		return "redirect:/photoUpload";
	}

	@GetMapping("/profile")
	public String showProfilePage(Model model) {
		System.out.println("[MainController][/profile]");
		// 사진 출력되는 곳

		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		String username = authentication.getName();
		DriverConfigLoader loader = dbService.getConnection();
		List<Info> infos = dbService.findAllByColumnValue(loader, Info.class, "username", username);
		Info userInfo = (Info) infos.get(0);

		Map<Integer, String> photoMap = userInfo.getPhoto();
		List<String> imageDatas = new ArrayList<>();
		String bucketName = "simkoong-s3";
		String base64Encoded = null;
		if (photoMap != null) {
			for (int i = 1; i <= 4; i++) {
				String imagePath = photoMap.get(i);
				if (imagePath != null) {
					File file = new File(imagePath);
					String fileName = file.getName();
					try {
						S3Object s3object = s3client.getObject(bucketName, fileName);
						S3ObjectInputStream inputStream = s3object.getObjectContent();
						byte[] bytes = IOUtils.toByteArray(inputStream);
						base64Encoded = Base64.encodeBase64String(bytes);
						imageDatas.add(base64Encoded);
					} catch (Exception e) {
						// 파일이 존재하지 않을 때 빈 이미지 추가
						base64Encoded = ""; // 빈 문자열 또는 기본 이미지 URL 설정
						imageDatas.add(base64Encoded);
					}
				}
			}
		}
		model.addAttribute("imageDatas", imageDatas);
		return "profile";
	}

	@GetMapping("/update")
	public String showUpdatePage(Info info, Model model) {
		System.out.println("[MainController][@GetMapping/update]");

		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		String username = authentication.getName();
		DriverConfigLoader loader = dbService.getConnection();
		List<Info> infos = dbService.findAllByColumnValue(loader, Info.class, "username", username);
		Info userInfo = (Info) infos.get(0);

		Map<Integer, String> photoMap = userInfo.getPhoto();
		List<String> imageDatas = new ArrayList<>();
		String bucketName = "simkoong-s3";
		String base64Encoded = null;
		if (photoMap != null) {
			for (int i = 1; i <= 4; i++) {
				String imagePath = photoMap.get(i);
				if (imagePath != null) {
					File file = new File(imagePath);
					String fileName = file.getName();

					try {
						S3Object s3object = s3client.getObject(bucketName, fileName);
						S3ObjectInputStream inputStream = s3object.getObjectContent();
						byte[] bytes = IOUtils.toByteArray(inputStream);
						base64Encoded = Base64.encodeBase64String(bytes);
						imageDatas.add(base64Encoded);
					} catch (Exception e) {
						// 파일이 존재하지 않을 때 빈 이미지 추가
						base64Encoded = ""; // 빈 문자열 또는 기본 이미지 URL 설정
						imageDatas.add(base64Encoded);
					}
				}
			}
		}
		model.addAttribute("imageDatas", imageDatas);
		return "update";
	}

	@PostMapping("/update")
	public String update(Info info) {
		System.out.println("[MainController][@PostMapping/update]");

		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();

		String username_session = authentication.getName();
		DriverConfigLoader loader = dbService.getConnection();
		Map<String, Object> columnValues = new HashMap<>();
		columnValues.put("username", username_session);

		// 어디를 업데이트할지, 값은 뭔지를 설정하기
		Map<String, Object> whereUpdate = new HashMap<>();
		Map<String, Object> updateValue = new HashMap<>();

		whereUpdate.put("username", username_session);
		updateValue.put("nickname", info.getNickname());
		updateValue.put("age", info.getAge());
		updateValue.put("phone", info.getPhone());
		/* updateValue.put("address", info.getAddress()); */
		updateValue.put("interest", info.getInterest());
		updateValue.put("mbti", info.getMbti());
		updateValue.put("sport", info.getMbti());
		updateValue.put("smoking", info.getSmoking());
		updateValue.put("drinking", info.getDrinking());
		updateValue.put("job", info.getJob());
		updateValue.put("school", info.getSchool());
		updateValue.put("aboutme", info.getAboutme());

		// 업데이트 진행
		dbService.updateByColumnValues(loader, Info.class, updateValue, whereUpdate);
		return "redirect:/profile";
	}

	@GetMapping("/location")
	public String locationPage() {
		System.out.println("[MainController][@GetMapping/location]");
		return "location";
	}

	@PostMapping("/location")
	public ResponseEntity<String> receiveAddress(@RequestBody AddressData addressData, Info info, HttpSession session) {
		System.out.println("[MainController][@PostMapping/location]");
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		String username_session = authentication.getName();
		DriverConfigLoader loader = dbService.getConnection();
		Map<String, Object> columnValues = new HashMap<>();
		columnValues.put("username", username_session);

		Map<String, Object> whereUpdate = new HashMap<>();
		Map<String, Object> updateValue = new HashMap<>();

		String roadAddress = addressData.getRoadAddress();
		String cityName = addressData.getCityName();
		String latitude = addressData.getLatitude();
		String longitude = addressData.getLongitude();
		// 예시로 받은 데이터를 콘솔에 출력해보겠습니다.
		System.out.println("도로명 주소: " + roadAddress);
		System.out.println("도시명: " + cityName);
		System.out.println("경도 " + latitude);
		System.out.println("위도 " + longitude);

		List<String> addressList = new ArrayList<>();
		addressList.add(roadAddress);
		addressList.add(latitude);
		addressList.add(longitude);

		whereUpdate.put("username", username_session);
		updateValue.put("address", addressList);

		dbService.updateByColumnValues(loader, Info.class, updateValue, whereUpdate);

		List<Info> infos = dbService.findAllByColumnValue(loader, Info.class, "username", username_session);
		session.setAttribute("mvo_session", infos.get(0));

		// 클라이언트에게 JSON 형태로 응답을 보냅니다.
		String response = "{\"message\": \"주소 정보를 성공적으로 받았습니다.\"}";
		return ResponseEntity.ok(response);
	}

}
