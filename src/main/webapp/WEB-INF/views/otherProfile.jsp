<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="cpath" value="${pageContext.request.contextPath}" />
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<sec:authentication property="principal" var="mvo" />

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
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link href="https://fonts.googleapis.com/icon?family=Material+Icons"
	rel="stylesheet">

<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>


<style>
body {
	color: #6F8BA4;
	margin-top: 20px;
}

.section {
	position: relative;
	height: 600px;
}

.gray-bg {
	background-color: #f5f5f5;
}

img {
	max-width: 80%;
	align-items: center;
	text-align: center;
}

img {
	display: flex; vertical-align : middle;
	border-style: none;
	align-items: center;
	vertical-align: middle;
}
/* About Me 
	---------------------*/
.about-text h3 {
	font-size: 45px;
	font-weight: 700;
	margin: 0 0 6px;
}

@media ( max-width : 767px) {
	.about-text h3 {
		font-size: 35px;
	}
}

.about-text h6 {
	font-weight: 600;
	margin-bottom: 15px;
}

@media ( max-width : 767px) {
	.about-text h6 {
		font-size: 18px;
	}
}

.about-text p {
	font-size: 18px;
	max-width: 450px;
}

.about-text p mark {
	font-weight: 600;
	color: #20247b;
}

.about-list {
	padding-top: 10px;
}

.about-list .media {
	padding: 10px 0;
}

.about-list label {
	color: #20247b;
	font-weight: 600;
	width: 90px;
	margin: 0;
	position: relative;
}

/* .about-list label:after {
	content: "";
	position: absolute;
	top: 0;
	bottom: 0;
	right: 11px;
	width: 1px;
	height: 12px;
	background: #20247b;
	-moz-transform: rotate(15deg);
	-o-transform: rotate(15deg);
	-ms-transform: rotate(15deg);
	-webkit-transform: rotate(15deg);
	transform: rotate(15deg);
	margin: auto;
	opacity: 0.5;
}
 */
.about-list p {
	margin: 0;
	margin-top: 7%;
	font-size: 15px;
}

@media ( max-width : 991px) {
	.about-avatar {
		margin: 0 auto 50px;
		display: flex;
		justify-content: center;
		align-items: center;
	}
}

.counter {
	position: relative;
	height: 100px;
}

.about-section .counter {
	padding: 22px 20px;
	background: #ffffff;
	border-radius: 10px;
	box-shadow: 0 0 30px rgba(31, 45, 61, 0.125);
}

.about-section .counter .count-data {
	margin-top: 10px;
	margin-bottom: 40px;
}

.about-section .counter .count {
	font-weight: 700;
	color: #20247b;
	margin: 0 0 5px;
}

.about-section .counter p {
	font-weight: 600;
	margin: 0;
}

div#center {
	margin-top: 70px;
}

mark {
	background-image: linear-gradient(rgba(252, 83, 86, 0.6),
		rgba(252, 83, 86, 0.6));
	background-size: 100% 3px;
	background-repeat: no-repeat;
	background-position: 0 bottom;
	background-color: transparent;
	padding: 0;
	color: currentColor;
}

div#left {
	align-items: center;
	margin: 0 auto 50px;
}

.theme-color {
	color: #ff9a9e;
}

.dark-color {
	color: #546e7a;
}

.slider-container {
	display: flex;
	align-items: center;
	justify-content: center;
	height: 60%;
	width: 60%;
}

.slider {
	width: 100%;
	max-width: 300px;
	height: 400px;
	text-align: center;
	border-radius: 20px;
	overflow: hidden;
	position: relative;
}

.slides {
	display: flex;
	position: relative;
	width: 100%;
	height: 400px;
}

.slide {
	justify-content: center;
	align-items: center;
	flex-shrink: 0;
	width: 300px;
	height: 400px;
	margin-right: 0px;
	box-sizing: border-box;
	background: #f5f5f5;
	transform-origin: center center;
	transform: scale(1);
}

.slide__text {
	font-size: 40px;
	font-family: sans-serif;
}

.slide a {
	background: none;
	border: none;
}




a.slide__prev, a.slider::before {
	/* 왼쪽 화살표 실제기능 구현 영역 */
	transform: rotate(135deg);
	-webkit-transform: rotate(135deg);
	top: 55%;
	left: 15%;
}

a.slide__next, a.slider::after {
	/* 오른쪽 화살표 실제기능 구현 영역 */
	
	top: 55%;
	right: 15%;
}

a.slider::before, a.slider::after, a.slide__prev, a.slide__next {
	/* 기능 구현 화살표 */
	display: inline-block;
	position: absolute;
	top: 50%;
	width: 30px;
	height: 30px;
	border: solid black; 
	border-radius: 50%;
	background-color: white;
	text-align: center;
	line-height: 30px;
	padding: 3px;
	box-sizing: border-box;
}

.slider::before, .slider::after {
	content: "";
	z-index: 1;
	background: none;
	pointer-events: none;
}

#card-body-top {
	height: 600px;
}

.image-box {
	display: flex;
	justify-content: center;
	align-items: center;
	height: 400px;
	width: 300px;
}

.image-box img {
	width: 100%; /* 이미지를 부모 요소에 꽉 채웁니다. */
	height: 100%; /* 이미지를 부모 요소에 꽉 채웁니다. */
	vertical-align: middle;
}
</style>
</head>
<body style="background: white;">
	<div id="container" class="container-xxl bg-white p-0">
		<jsp:include page="header.jsp"></jsp:include>
		<div class="container">
			<section class="section about-section gray-bg" id="about">
				<div class="row align-items-center flex-row-reverse"
					style="margin-top: 0px;">
					<div class="row" id="center">
						<div class="col-lg-6" id="left">
							<div class="about-avatar" style="align-items: center;">
								<div class="slider-container">
									<div class="slider">
										<div class="slides">
											<c:forEach items="${imageDatas}" var="imageData"
												varStatus="i">
												<div id="slides__${i.count}" class="slide">
													<div class="image-box">
														<img src="data:image/jpeg;base64,${imageData}"
															alt="S3 Image" title="">
													</div>
													<c:choose>
														<c:when test="${i.count eq 1}">
															<!-- i가 1일때는 이전버튼 :4, 다음버튼은 2  -->
															<a id="slide__prev" class="slide__prev" href="#slides__4"
																title="prev"></a>
															<a id="slide__next" class="slide__next" href="#slides__2"
																title="Next"><i class='fas fa-caret-right' style=' margin-top:-10px; color:black;font-size:36px'></i></a>
														</c:when>
														<c:when test="${i.count eq 4}">
															<!-- i가 4일때는 이전버튼 :3, 다음버튼은 1  -->
															<a id="slide__prev" class="slide__prev" href="#slides__3"
																title="prev"></a>
															<a id="slide__next" class="slide__next" href="#slides__1"
																title="Next"></a>
														</c:when>
														<c:otherwise>
															<a id="slide__prev" class="slide__prev"
																href="#slides__${i.count-1}" title="prev"></a>
															<a id="slide__next" class="slide__next"
																href="#slides__${i.count+1}" title="Next"></a>
														</c:otherwise>
													</c:choose>
												</div>
											</c:forEach>

										</div>
									</div>

								</div>
							</div>
						</div>

						<div class="col-lg-6">
							<div class="about-text go-to">
								<h3 class="dark-color">${recommendUser.nickname},${recommendUser.age}</h3>
								<h6 class="theme-color lead">
									<span class="glyphicon">&#xe139;</span> ${recommendUser.job}
								</h6>

								<p>${recommendUser.aboutme}</p>
								<div class="row about-list">
									<div class="col-md-6">
										<%-- <div class="media">											
											<label><i class="material-icons">&#xe7e9;</i> 성별</label>
											<p>${ }</p>
										</div> --%>
										<div class="media">
											<label><i class="material-icons">&#xe7fd;</i> MBTI</label>
											<p>${recommendUser.mbti}</p>
										</div>
										<div class="media">
											<label><span class="glyphicon glyphicon-map-marker"></span>
												거주 지역</label>
											<p>${recommendUser.address[0].replace('[','')}</p>
										</div>

									</div>

									<div class="col-md-6">
										<div class="media">
											<label><i class="material-icons">school</i> 학력</label>
											<p>${recommendUser.school}</p>
										</div>
										<div class="media">
											<label><i style='font-size: 24px' class='fas'>&#xf86d;</i>
												관심사</label> <br>
											<p>${recommendUser.interest}</p>

										</div>

									</div>
								</div>
							</div>
						</div>
					</div>
					<br> <br> <br>
					<div class="counter">
						<div class="row">
							<div class="col-6 col-lg-4">
								<div class="count-data text-center">
									<h6 class="count h2" data-to="500" data-speed="500">
										<i class='fas fa-dumbbell' style='font-size: 24px'></i> 운동 선호
									</h6>
									<p class="m-0px font-w-600">${recommendUser.sport}</p>
								</div>
							</div>
							<div class="col-6 col-lg-4">
								<div class="count-data text-center">
									<h6 class="count h2" data-to="150" data-speed="150">
										<i class='fas fa-wine-glass-alt' style='font-size: 36px'></i>
										음주 여부
									</h6>
									<p class="m-0px font-w-600">${recommendUser.drinking}</p>
								</div>
							</div>
							<div class="col-6 col-lg-4">
								<div class="count-data text-center">
									<h6 class="count h2" data-to="850" data-speed="850">
										<i class='fas fa-smoking' style='font-size: 24px'></i> 흡연 여부
									</h6>
									<p class="m-0px font-w-600">${recommendUser.smoking }</p>
								</div>
							</div>

						</div>
					</div>
				</div>
			</section>
		</div>

	</div>

	<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
	<script src="lib/wow/wow.min.js"></script>
	<script src="lib/easing/easing.min.js"></script>
	<script src="lib/waypoints/waypoints.min.js"></script>
	<script src="lib/owlcarousel/owl.carousel.min.js"></script>

	<!-- Template Javascript -->
	<script src="js/main.js"></script>


</body>
</html>