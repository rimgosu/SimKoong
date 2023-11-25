# 베이스 이미지 지정 (Java 17)
FROM openjdk:17-oracle

# JAR 파일 복사
COPY target/demo-0.0.9-SNAPSHOT.war myapp.war

# 애플리케이션 실행
ENTRYPOINT ["java","-jar","/myapp.war"]