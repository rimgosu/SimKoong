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
import com.example.entity.Filter;
import com.example.entity.Info;
import com.example.security.CustomUser;
import com.example.service.DBService;
import com.example.service.FileService;
import com.example.service.FilterService;
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
	@Autowired
	private FilterService filterService;
	@Autowired
    private FileService fileService;

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

		filterService.joinFilter(username);

		if (listInfo.size() == 0) {
			return "redirect:join";
		} else {
			return "redirect:/login";
		}
	}

	@GetMapping("/photoUpload") // 사진 업로드 하는 페이지로 이동
	public String showInfoPage(Model model) {
		System.out.println("[MainController][/photoUpload]");
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
		System.out.println("[MainController][/fileUpload]");
        
        String username = SecurityContextHolder.getContext().getAuthentication().getName();
        fileService.handleFileUpload(file, photoNum, username);
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
		System.out.println("[infos : ]" + infos.toString());
		Info userInfo = (Info) infos.get(0);
		List<Filter> filters = dbService.findAllByColumnValue(loader, Filter.class, "username", username);
		System.out.println("[filters : ]" + filters.toString());
		Filter userFilter = filters.get(0);

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
		model.addAttribute("mvo", userInfo);
		model.addAttribute("filter", userFilter);
		return "profile";
	}

	@GetMapping("/update")
	public String showUpdatePage(Info info, Model model, HttpSession session) {
		System.out.println("수정페이지로 들어왔음.");

		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		String username = authentication.getName();
		DriverConfigLoader loader = dbService.getConnection();
		List<Info> infos = dbService.findAllByColumnValue(loader, Info.class, "username", username);
		Info userInfo = (Info) infos.get(0);
		session.setAttribute("mvo_session", userInfo);

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
		updateValue.put("sport", info.getSport());
		updateValue.put("smoking", info.getSmoking());
		updateValue.put("drinking", info.getDrinking());
		updateValue.put("job", info.getJob());
		updateValue.put("school", info.getSchool());
		updateValue.put("aboutme", info.getAboutme());
		updateValue.put("sex", info.getSex());
		updateValue.put("isFirst", false);

		// 업데이트 진행
		dbService.updateByColumnValues(loader, Info.class, updateValue, whereUpdate);
		
		// isFirst 값 업데이트
		// 현재 인증된 사용자가 CustomUser 타입인지 확인
		if (authentication.getPrincipal() instanceof CustomUser) {
		    CustomUser customUser = (CustomUser) authentication.getPrincipal();
		    customUser.setIsFirst(false);
		}
		
		return "redirect:/profile";
	}

	@GetMapping("/location")
	public String locationPage() {
		System.out.println("위치 정보 확인");
		return "location";
	}

	@PostMapping("/location")
	public ResponseEntity<String> receiveAddress(@RequestBody AddressData addressData, Info info, HttpSession session,
			Model model) {
		System.out.println("[MainController][/location]");
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		String username_session = authentication.getName();
		DriverConfigLoader loader = dbService.getConnection();
		Map<String, Object> columnValues = new HashMap<>();
		columnValues.put("username", username_session);
		List<Info> listInfo = dbService.findAllByColumnValues(loader, Info.class, columnValues);

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
