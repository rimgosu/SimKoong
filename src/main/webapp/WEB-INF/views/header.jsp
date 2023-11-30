<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="cpath" value="${pageContext.request.contextPath}" />
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<sec:authentication property="principal" var="mvo" />


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	
	
	<!-- Spinner Start -->
	<div id="spinner"
		class="show bg-white position-fixed translate-middle w-100 vh-100 top-50 start-50 d-flex align-items-center justify-content-center">
		<div class="spinner-border text-primary"
			style="width: 3rem; height: 3rem;" role="status">
			<span class="sr-only">Loading...</span>
		</div>
	</div>
	<!-- Spinner End -->


	<!-- Navbar Start -->
	<div class="container-fluid nav-bar bg-transparent">
		<nav class="navbar navbar-expand-lg bg-white navbar-light py-0 px-4">
			<a href="recommend"
				class="navbar-brand d-flex align-items-center text-center">
				<div class="p-2 me-2">
					<img class="img-fluid" src="img/logo.png" alt="Icon"
						style="width: 100%; height: 30px;">
				</div>
				<h1 class="m-0 marko">SIM KOONG</h1>
			</a>
			<button type="button" class="navbar-toggler"
				data-bs-toggle="collapse" data-bs-target="#navbarCollapse">
				<span class="navbar-toggler-icon"></span>
			</button>
			<div class="collapse navbar-collapse" id="navbarCollapse">
				<div class="navbar-nav ms-auto">
					<a href="recommend" class="nav-item nav-link">RECOMMEND</a>
					<a href="interaction" class="nav-item nav-link">INTERACTIONS</a>
					<a href="showChatRoom?chatRoomUuid=" class="nav-item nav-link">CHAT</a>
					
					<div class="nav-item dropdown">
						<a href="#" class="nav-link dropdown-toggle"
							data-bs-toggle="dropdown">Profile</a>
						<div class="dropdown-menu rounded-0 m-0">
							<a href="photoUpload" class="dropdown-item">프로필 사진 수정</a> 
							<a href="${cpath}/profile" class="dropdown-item">프로필 정보 수정</a>
							<a href="${cpath}/logout" class="dropdown-item">LOGOUT</a>
							
						</div>
					</div>

				</div>
				
			</div>
		</nav>
	</div>

</body>
</html>