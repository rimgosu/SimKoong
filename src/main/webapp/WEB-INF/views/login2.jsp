<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>

<h1>하이</h1>
<form action="/perform_login" method="post">
    <input type="hidden" name="_csrf" value="${_csrf.token}" />
    <!-- 로그인 입력 필드 -->
</form>

</body>
</html>