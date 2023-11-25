<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:set var="cpath" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html lang="en" style="background: white;">

<head>
<meta charset="utf-8">
<title>SimKoong</title>
<meta content="width=device-width, initial-scale=1.0" name="viewport">
<meta content="" name="keywords">
<meta content="" name="description">

<!-- Favicon -->
<link href="img/favicon.ico" rel="icon">

<!-- Google Web Fonts -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link
	href="https://fonts.googleapis.com/css2?family=Heebo:wght@400;500;600&family=Inter:wght@700;800&display=swap"
	rel="stylesheet">

<!-- Icon Font Stylesheet -->
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.0/css/all.min.css"
	rel="stylesheet">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css"
	rel="stylesheet">

<!-- Libraries Stylesheet -->
<link href="lib/animate/animate.min.css" rel="stylesheet">
<link href="lib/owlcarousel/assets/owl.carousel.min.css"
	rel="stylesheet">

<!-- Customized Bootstrap Stylesheet -->
<link href="css/bootstrap.min.css" rel="stylesheet">

<!-- Template Stylesheet -->
<link href="css/style.css" rel="stylesheet">

<!-- 카드 관련 css -->
<link href="css/card.css" rel="stylesheet">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">

<!-- 매칭 neon css -->
<link href="css/neon.css" rel="stylesheet">

</head>

<body style="background: white;">

	<video autoplay muted loop id="myVideo">
	  <source src="video/background2.mp4" type="video/mp4">
	</video>

	<div class="container-xxl bg-white p-0"><%-- 
		<jsp:include page="../header.jsp"></jsp:include> --%>
		<!-- Navbar End -->

		<!-- 추천 카드 시작 -->
		<div class="container">
    <div style="display: flex; justify-content: center; align-items: center; height: 100%;">
        <div class="col-md-4" style="display: flex; justify-content: center; align-items: center; height: 100%;">
            <div class="profile-card-2 matching-box">
                <span></span>
                <span></span>
                <span></span>
                <span></span>
                <div class="image-container" style="position: relative;">
                    <img src="data:image/jpeg;base64,${imageDatas[0]}" class="img img-responsive">
                    <a href="/recommend" style="position: absolute; top: 10px; right: 10px;"><i class="fa fa-times"></i></a>
                </div>
                <div class="profile-name">${oppInfo.nickname}</div>
                <div class="profile-icons">
                    <a style="display: block; font-size: 20px;" href="/createChatting?oppUserName=${oppInfo.username}"><i class="fa fa-comment"></i>Chat</a>
                </div>
            </div>
        </div>
    </div>
</div>
		<!-- 추천 카드 끝 -->
		
	</div>

	<!-- JavaScript Libraries -->
	<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
	<script src="lib/wow/wow.min.js"></script>
	<script src="lib/easing/easing.min.js"></script>
	<script src="lib/waypoints/waypoints.min.js"></script>
	<script src="lib/owlcarousel/owl.carousel.min.js"></script>

	<!-- Template Javascript -->
	<script src="js/main.js"></script>

	<script>
		
	</script>

</body>

</html>