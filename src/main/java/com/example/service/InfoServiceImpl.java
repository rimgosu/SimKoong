package com.example.service;

import java.nio.file.Path;
import java.nio.file.Paths;
import java.time.Instant;
import java.util.Collections;
import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.datastax.oss.driver.api.core.CqlSession;
import com.datastax.oss.driver.api.core.config.DriverConfigLoader;

import com.datastax.oss.driver.api.core.cql.PreparedStatement;
import com.datastax.oss.driver.api.core.cql.ResultSet;
import com.datastax.oss.driver.api.core.cql.Row;
import com.example.entity.Info;


@Service
public class InfoServiceImpl implements InfoService {
	//로그인
	@Autowired
	DBService dbservice;

	@Override
	public Info login(Info m) {
		Path configPath = Paths.get("/keys/keyspace/application.conf");
		DriverConfigLoader loader = DriverConfigLoader.fromPath(configPath);
		String username = m.getUsername();
		String password = m.getPassword();

		try (CqlSession session = CqlSession.builder().withConfigLoader(loader).build()) {

			String cql = "select username, password from member.info where username =? ";
			PreparedStatement preparedStatement = session.prepare(cql);
			ResultSet resultSet = session.execute(preparedStatement.bind(username));

			String username_db = null;
			String password_db = null;

			// Process the results
			for (Row row : resultSet) {
				// Access the columns in the result set using row.getXXX() methods
				username_db = row.getString("username");
				password_db = row.getString("password");
			}

			if (username_db.equals(username) && password_db.equals(password)) {
				System.out.println("로그인 완료");
				return m;
			} else {
				System.out.println("실패");
				System.out.println(username_db);
				System.out.println(password_db);
				return m;
			}

		}
	}
	
	// 회원가입 후, 추가정보 넣는 메서드
	@Override
	public Info InsertInfoAdditional(Info m, String username_session) {
		// TODO Auto-generated method stub
		Path configPath = Paths.get("/keys/keyspace/application.conf");
		DriverConfigLoader loader = DriverConfigLoader.fromPath(configPath);
		
		try (CqlSession session = CqlSession.builder().withConfigLoader(loader).build()) {

			String cql = """
					update member.info
					set age =?,phone=?,address=?,interest=?,mbti=?,
					    sport=?,smoking=?,drinking=?,job=?,school=?,
					    role=?,aboutme=?
					where username = ?;
					""";
			PreparedStatement preparedStatement = session.prepare(cql);

			session.execute(preparedStatement.bind(m.getAge(), m.getPhone(), m.getAddress(),
					m.getInterest(), m.getMbti(), m.getSport(), m.getSmoking(), m.getDrinking(),
					m.getJob(), m.getSchool(), m.getRole(), m.getAboutme(),username_session));
			System.out.println(m);

		}
		return m;
	}
	
	// 데이터베이스에 사진 있는지 확인하는 메서드
	@Override
	public  Map<Integer, String> selectMemPhoto(String username_session) {
		Path configPath = Paths.get("/keys/keyspace/application.conf");
		DriverConfigLoader loader = DriverConfigLoader.fromPath(configPath);
		
		//DB에서 받아오는 photo를 담아올 photomap 변수 선언 및 초기화
		Map<Integer, String> photoMap = new HashMap<>(); 
		
		try (CqlSession session = CqlSession.builder().withConfigLoader(loader).build()) {
			String cql = "select photo from member.info where username =? ";
			PreparedStatement preparedStatement = session.prepare(cql);
			ResultSet resultSet = session.execute(preparedStatement.bind(username_session));
			for(Row row : resultSet) {
				photoMap = row.getMap("photo", Integer.class, String.class);
				if(photoMap!=null) {
					photoMap.putAll(photoMap);
				}
			}
			} catch (Exception e) {
				e.printStackTrace(); 
				return Collections.emptyMap(); // 비어있는 photoMap 반환
			}
		return photoMap;
	}

	//사진 업로드 기능 구현
	@Override
	public void fileUpload(Map<Integer, String> additionalFile, String username_session) {
		
		System.out.println("Service : fileUpload");
		
		Path configPath = Paths.get("/keys/keyspace/application.conf");
		DriverConfigLoader loader = DriverConfigLoader.fromPath(configPath);
		
		try (CqlSession session = CqlSession.builder().withConfigLoader(loader).build()) {

			String cql = """
					update member.info
					set photo=?
					where username = ?;
					""";
			PreparedStatement preparedStatement = session.prepare(cql);
			session.execute(preparedStatement.bind(additionalFile,username_session));
		}
	}
		
		
	//전체 데이터 불러올 수 있음.(세션 값 있어야함)
	@Override
	public Info SelectInfo(String username_session) {
		Path configPath = Paths.get("/keys/keyspace/application.conf");
		DriverConfigLoader loader = DriverConfigLoader.fromPath(configPath);
		
		try (CqlSession session = CqlSession.builder().withConfigLoader(loader).build()) {
			System.out.println("SelectInfo 서비스에 들어왔음.");
			String cql = "SELECT * FROM member.info WHERE username = ?";
			PreparedStatement preparedStatement = session.prepare(cql);
			ResultSet resultSet = session.execute(preparedStatement.bind(username_session));
			
			if (resultSet.one() != null) {
				System.out.println("SelectInfo 서비스에 row에 들어왔음.");
				Row row = resultSet.one();
				Info m = new Info();
				m.setUsername(row.getString("username"));
				m.setPassword(row.getString("password"));
				m.setNickname(row.getString("nickname"));
				m.setPhone(row.getString("phone"));
				m.setAge(row.getInt("age"));
				m.setInterest(row.getString("interest"));
				m.setMbti(row.getString("mbti"));
				m.setSport(row.getString("sport"));
				m.setDrinking(row.getString("drinking"));
				m.setSmoking(row.getString("smoking"));
				m.setJob(row.getString("job"));
				m.setSchool(row.getString("school"));
				m.setAboutme(row.getString("aboutme"));
				return m;
				} else {
					// 적절한 예외 처리 또는 null 반환
					return null;
					}
			} catch (Exception e) {
			// 예외 처리 로직
			return null;
			}
	}

	
	
	


	@Override
	public void InsertInfo(String nickname, String username, String password) {

		Map<Integer, String> files = new HashMap<>();
		files.put(1, "s3://simkoong-s3/simkoong.jpg");
		files.put(2, "s3://simkoong-s3/simkoong.jpg");
		files.put(3, "s3://simkoong-s3/simkoong.jpg");
		files.put(4, "s3://simkoong-s3/simkoong.jpg");
		
		Info info = new Info();
		info.setNickname(nickname);
		info.setUsername(username);
		info.setPassword(password);
		info.setPhoto(files);
		info.setRegister_date(Instant.now());
		info.setStatus(true);
		info.setIsFirst(true);
		
		
		
		
		DriverConfigLoader loader = dbservice.getConnection();
		
		dbservice.save(loader, Info.class, info);
		
		
    }


}
         
