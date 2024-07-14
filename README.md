![image](https://github.com/rimgosu/simkoong/assets/120752098/ddf88b71-4315-4f10-9c22-24a13ce39bf5)

# simkoong

## 1. 개요
- 선호 이미지 기반 추천 시스템을 바탕으로 한 **소개팅 웹 서비스**입니다.
- 인공지능사관학교 4기 Spring 특화반, 심쿵 조의 **Spring 프로젝트**입니다.

## 2. 주요 기능
### 1. 상대 추천 기능
- 현재 가입한 회원을 불러와 좋아요를 누를 수 있습니다.
![상대추천기능](https://github.com/user-attachments/assets/fbeeb145-b7a1-4c45-bd54-bb80d83b3860)


### 2. 상대 회원 조회 기능
- 매칭된 회원을 조회할 수 있습니다.
- 받은 좋아요를 확인할 수 있습니다.
- 보낸 좋아요를 확인할 수 있습니다.
- 카드를 클릭하여 원하는 회원을 더 상세하게 조회할 수 있습니다.

![상대조회기능시간줄여서 (2)](https://github.com/user-attachments/assets/eeffd968-3078-4084-bf33-798239bca897)

### 3. 매칭 기능
- 서로 좋아요를 누르면 매칭이 이루어집니다.

![매칭기능입니다 (1)](https://github.com/user-attachments/assets/7fd439a7-ae31-4736-810a-3d7c2668f7b6)


### 4. 채팅 기능
- 매칭이 이루어진 유저끼리 실시간 채팅을 할 수 있습니다.

![채팅기능](https://github.com/user-attachments/assets/18266feb-9bc4-44a4-af3f-e34e640d09ad)


- 읽지 않은 메시지 수 만큼 알림 기능이 있습니다.

![image](https://github.com/user-attachments/assets/12ebe629-b041-4d44-9f76-6a283fb46b6d)


## 3. 기술
Spring Boot / Maven / JSP / Cassandra / AWS Keyspace / AWS S3 / Spring WebSocket / Spring Security

- Spring Boot, Maven, JSP로 개발하였습니다.
- 선호 이미지 백터를 빠르게 계산하기 위해, Cassandra 데이터 베이스를 사용하였습니다.
- Spring WebSocket을 사용하여 실시간 채팅을 구현하였습니다.
- Spring Security를 사용하여 인증 기능을 구현하였습니다.

### 1. 프로젝트 아키텍쳐
![스크린샷 2024-07-15 010622](https://github.com/user-attachments/assets/2bb5867d-3000-442e-9501-11db97d73ea4)

### 2. AWS Keyspace
- AWS 서비스인 Keyspace를 사용하여 팀원이 공통적으로 개발하기 편한 환경을 조성하였습니다.
- 총 8개의 테이블을 살계하였습니다.

![image](https://github.com/user-attachments/assets/0d5e3032-e394-466b-a662-ce9f43856dec)

### 3. Cassandra CQL 함수 정리
- Keyspace와 통신하고 싶을 때, 매번 DriverConfigLoader를 불러오고, CQL 문법을 사용하는 것을 단순화하기 위해 기본 함수를 구현하였습니다.
- save, findAll, findAllByColumnValue, updateByColumnValues 등의 함수를 구현하였습니다.

```java
public interface DBService {
	
  public DriverConfigLoader getConnection();
  <T> void save(DriverConfigLoader loader, Class<T> entityClass, T entity);
  public <T> List<T> findAll(DriverConfigLoader loader, Class<T> classType);
  <T> List<T> findAllByColumnValue(DriverConfigLoader loader, Class<T> classType, String columnName, Object value);
  <T> List<T> findAllByColumnValues(DriverConfigLoader loader, Class<T> classType,
      Map<String, Object> columnValues);
  <T> void updateByColumnValues(DriverConfigLoader loader, Class<T> classType, 
            Map<String, Object> updateValues, Map<String, Object> whereConditions);
  public <T> void setFieldValue(Field field, T entity, Row row) throws IllegalAccessException;
}
```

- 여기서, save 함수를 확인해보면, 다음과 같이 구현되어있습니다.
- 제네릭 함수를 통해 member keyspace에 존재하는 테이블 전부에 적용 가능하게끔 구현하였습니다.
```java
@Override
public <T> void save(DriverConfigLoader loader, Class<T> entityClass, T entity) {
    System.out.println("[DBServiceImpl][save]");
    TableColumnsValues.Result<T> result = TableColumnsValues.extractData(entityClass, entity);
    CqlSession session = CassandraSessionManager.getSession(loader);
    try {

        String columns = String.join(", ", result.columnNames);
        String placeholders = String.join(", ", Collections.nCopies(result.columnNames.length, "?"));
        String cql = String.format("INSERT INTO %s (%s) VALUES (%s)", "member."+result.tableName, columns, placeholders);

        System.out.println("[cql:]" + cql);

        PreparedStatement preparedStatement = session.prepare(cql);
        Object[] boundValues = convertToAppropriateType(result.values);
        session.execute(preparedStatement.bind(boundValues));
    } catch (Exception e) {
        System.out.println("save Error: " + e);
    }
}
```

- 함수는 다음과 같이 사용할 수 있습니다.
![image](https://github.com/user-attachments/assets/4f68d02a-d1a8-4a15-8e09-128f497ee647)

### 4. WebSocket을 활용한 실시간 채팅 구현
- 채팅 탭을 클릭하면 자동으로 웹소켓(ws://localhost:8081)로 접속합니다.

![웹소켓설명](https://github.com/user-attachments/assets/a44a2c2e-9f8d-4241-a2ba-2e15f1a6187a)

- MessageMapping과 SendTo 어노테이션을 사용하여 자바 코드에서 웹소켓으로 실시간 채팅 기능을 구현하였습니다.
```java
@Controller
public class GreetingController {
	
	@Autowired
	ChatService chatService;

	/*
	 * "/app/hello" : 클라이언트 -> 서버 메시지 받음.
	 * "/topic/greetings" : 서버 -> 구독하는 모든 클라이언트에게 전송.
	 */
	
	@MessageMapping("/hello")
	@SendTo("/topic/greetings")
	public ChattingNotification greeting(Chatting chatting) throws Exception {
		chatService.insertChatting(chatting);
		ChattingNotification chattingNotification = chatService.getChattingNotification(chatting);
		Thread.sleep(1000);
		return chattingNotification;
	}
	
	@MessageMapping("/typing")
	@SendTo("/topic/typingStatus")
	public TypingNotification sendTypingStatus(TypingNotification notification) {
	    return notification;
	}
}
```

## 4. 팀원 소개
| 이름     | 역할                    | 담당 업무                                                         |
| -------- | ----------------------- | ---------------------------------------------------------------- |
| 전준     | 팀장                    | 인공지능 개발, 선호 이미지 기반 추천 인공지능 기능 개발           |
| 변지협   | 백엔드 기능 개발        | Cassandra 테이블 설계, 채팅, 다른 회원 조회, 추천 시스템 기능 개발 |
| 서보경   | 회원가입 및 로그인      | 프로필 수정 기능, s3 업로드 기능 개발                             |
| 오주현   | 프론트엔드 기능 개발    | 회원가입 프론트엔드 기능 개발                                     |
| 김미소   | 인공지능 개발           | 선호 이미지 기반 추천 인공지능 기능 개발                          |

## 5. 레거시 코드
- https://github.com/rimgosu/FinalProject_web
