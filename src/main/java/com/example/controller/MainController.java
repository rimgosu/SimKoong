package com.example.controller;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import com.example.entity.Info;
import com.example.service.DBService;
import com.example.service.InfoService;
import com.amazonaws.services.s3.AmazonS3;
import com.amazonaws.services.s3.model.PutObjectRequest;
import com.datastax.oss.driver.api.core.config.DriverConfigLoader;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
public class MainController {

	@Autowired
	private InfoService infoService;
	@Autowired
	private DBService dbService;
	@Autowired //사진 업로드할때 필요
	private AmazonS3 s3client;
	
	@GetMapping("/")
	public String showMainPage() {
		System.out.println("main으로 들어왔음.");
		return "index";
	}
	
	@GetMapping("/index")
	public String showMainPage2() {
		System.out.println("[MainController][/index]");
		return "index";
	}
	
	@GetMapping("/index2")
	public String showMainPage3() {
		System.out.println("[MainController][/index2]");
		return "index2";
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

		if ( listInfo.size() == 0 ) {
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
		infoService.InsertInfo(nickname, username, password);
		return "redirect:/index";
	}

	@GetMapping("/info") //사진 출력필요함.
	public String showInfoPage(HttpSession session, Model model) {
		System.out.println("정보입력으로 들어왔음.");
		//사진 출력되는 곳
		 Info userInfo =(Info) session.getAttribute("mvo");
		  Map<Integer, String> photoMap = userInfo.getPhoto();
		  List<String> fileNames = new ArrayList<>();
		  String imagePath = null;
		  String fileName = null;
		  if (photoMap != null) {
			  for(int i=1;i<=4; i++) {
				  imagePath = photoMap.get(i);
				  File file  = new File(imagePath);
				  fileName = file.getName();
				  fileNames.add(fileName);				  
			  }			    
			} else {
				System.out.println("없음");
			    // sessionPhoto가 null일 때 처리할 코드를 여기에 추가하세요
			}
		model.addAttribute("fileNames", fileNames);
		model.addAttribute(fileName);
		return "info";
	}

	@PostMapping("/info")
	public String showInfoPage(Info info, HttpSession session, HttpServletRequest request) {
		String username_session = ((Info) session.getAttribute("mvo")).getUsername();
		infoService.InsertInfoAdditional(info, username_session);
		return "redirect:/index";

	}

	//파일 업로드
	@PostMapping("/fileUpload")
	public String fileUpload(Info info, @RequestParam("file") MultipartFile file, @RequestParam("photoNum") int photoNum, HttpSession session, HttpServletRequest request) {
		System.out.println(file);
		String username_session = ((Info) session.getAttribute("mvo")).getUsername();
		System.out.println(username_session);
		String originalFilename = null;			
		String uploadedFilePath_aws = null;			
		try {
			String uploadedFilePath = null;
			// 업로드된 파일 처리
			if (!file.isEmpty()) {
				originalFilename = file.getOriginalFilename();
				// 파일 저장 경로 및 이름 설정
				System.out.println(originalFilename);
				String filePath_aws = "s3://simkoong-s3/" + originalFilename; 
				String filePath = request.getServletContext().getRealPath("/" + originalFilename);
				System.out.println(filePath);
				File dest = new File(filePath);
				
				System.out.println(dest);
				// 파일 저장
				file.transferTo(dest);
				// 파일 경로에서 역슬래시 바꾸는 곳.
				System.out.println(dest);
				filePath = filePath.replace("\\\\", "/");
				uploadedFilePath = filePath.replace("\\", "/");
				
				filePath_aws = filePath_aws.replace("\\\\", "/");
				uploadedFilePath_aws = filePath_aws.replace("\\", "/");

			}		
			//AWS S3 관련 코드
				File fileForS3 = new File(uploadedFilePath);
				String bucketName = "simkoong-s3";
				String fileName=originalFilename;
				s3client.putObject(new PutObjectRequest(bucketName, fileName, fileForS3));
			
			// listinfo 정보 전체 가져오기
			Map<String, Object> columnValues = new HashMap<>();
			columnValues.put("username", username_session);
			
			DriverConfigLoader loader = dbService.getConnection();
			List<Info> listInfo = dbService.findAllByColumnValues(loader, Info.class, columnValues);
			
			// 업데이트할 정보를 Map형식의 photo에 넣기.
			Map<Integer, String> photo = listInfo.get(0).getPhoto();
			photo.put(photoNum, uploadedFilePath_aws);
			
			
			// 어디를 업데이트할지, 값은 뭔지를 설정하기
			Map<String, Object> whereUpdate = new HashMap<>();
			Map<String, Object> updateValue = new HashMap<>();
			
			whereUpdate.put("username", username_session);
			updateValue.put("photo", photo);
			
			// 업데이트 진행
			dbService.updateByColumnValues(loader, Info.class, updateValue, whereUpdate);			
			session.setAttribute("mvo", dbService.findAllByColumnValues(loader, Info.class, columnValues).get(0));

		} catch (IOException e) {
			e.printStackTrace();
		}
		
//		infoService.fileUpload(additionalFile, username_session);
		return "redirect:/info";
	}


	@GetMapping("/profile")
	public String showProfilePage(Model model, HttpSession session) {
		System.out.println("마이페이지로 들어왔음.");
		//사진 출력되는 곳
		 Info userInfo =(Info) session.getAttribute("mvo");
		  Map<Integer, String> photoMap = userInfo.getPhoto();
		  String imagePath = null;
		  String fileName = null;
		  if (photoMap != null) {
				  imagePath = photoMap.get(1);
				  File file  = new File(imagePath);
				  fileName = file.getName();	

			} else {
				System.out.println("없음");
			    // sessionPhoto가 null일 때 처리할 코드를 여기에 추가하세요
			}
		model.addAttribute("fileName", fileName);
		return "profile";
	}

	@GetMapping("/update")
	public String showUpdatePage() {
		System.out.println("수정페이지로 들어왔음.");
		return "update";
	}
	@PostMapping("/update")
	public String update(Info info, HttpSession session) {
		String username_session =((Info) session.getAttribute("mvo")).getUsername();
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
		updateValue.put("address", info.getAddress());
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
		session.setAttribute("mvo", dbService.findAllByColumnValues(loader, Info.class, columnValues).get(0));
		return "redirect:/profile";
	}

	@GetMapping("/test")
	public String showTestPage() {
		System.out.println("테스트페이지로 들어옴.");
		return "test";
	}
	
	@GetMapping("/sendlike")
	public String showSendLikePage() {
		System.out.println("보낸좋아요로 들어왔음.");
		return "sendlike";
	}

}
