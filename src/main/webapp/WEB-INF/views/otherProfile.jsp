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
<html lang="en" style="background: white;">
<head>
<meta charset="utf-8">
<title>Babe</title>
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
<style>
body {
	margin-top: 20px;
	background-color: #f2f6fc;
	color: #69707a;
}

.img-account-profile {
	height: 10rem;
}

.rounded-circle {
	border-radius: 50% !important;
}

.card {
	box-shadow: 0 0.15rem 1.75rem 0 rgb(33 40 50/ 15%);
}

.card .card-header {
	font-weight: 500;
}

.card-header:first-child {
	border-radius: 0.35rem 0.35rem 0 0;
}

.card-header {
	padding: 1rem 1.35rem;
	margin-bottom: 0;
	background-color: rgba(33, 40, 50, 0.03);
	border-bottom: 1px solid rgba(33, 40, 50, 0.125);
}

.form-control, .dataTable-input {
	display: block;
	width: 100%;
	padding: 0.875rem 1.125rem;
	font-size: 0.875rem;
	font-weight: 400;
	line-height: 1;
	color: #69707a;
	background-color: #fff;
	background-clip: padding-box;
	border: 1px solid #c5ccd6;
	-webkit-appearance: none;
	-moz-appearance: none;
	appearance: none;
	border-radius: 0.35rem;
	transition: border-color 0.15s ease-in-out, box-shadow 0.15s ease-in-out;
}

.nav-borders .nav-link.active {
	color: #0061f2;
	border-bottom-color: #0061f2;
}

.nav-borders .nav-link {
	color: #69707a;
	border-bottom-width: 0.125rem;
	border-bottom-style: solid;
	border-bottom-color: transparent;
	padding-top: 0.5rem;
	padding-bottom: 0.5rem;
	padding-left: 0;
	padding-right: 0;
	margin-left: 1rem;
	margin-right: 1rem;
}

.slider-container {
	display: flex;
	position: relative;
	left: 30px;
	height: 70%;
	width: 80%;
}

.slider {
	width: 100%;
	height: 100%;
	text-align: center;
	border-radius: 20px;
	overflow: hidden;
	position: relative;
}

.slides {
	display: flex;
	position: relative;
	width: 100%;
	height: 100%;
}

.slide {
	justify-content: center;
	align-items: center;
	flex-shrink: 0;
	width: 300px;
	margin-right: 0px;
	box-sizing: border-box;
	background: #fff2ed;
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
	position: absolute;
	width: 40%;
	height: 100%;
	top: 0;
	left: 0;
	opacity: 0; /* 화면에는 보이지 않지만 요소는 있음 */
	z-index: 1;
}

a.slide__next, a.slider::after {
	position: absolute;
	width: 40%;
	height: 100%;
	top: 0;
	right: 0;
	opacity: 0; /* 화면에는 보이지 않지만 요소는 있음 */
	z-index: 1;
}

.slider::before, .slider::after {
	content: "";
	z-index: 1;
	background: none;
}

.image-box {
	display: flex;
	justify-content: center;
	align-items: center;
	height: 100%;
	width: 100%;
}

.image-box img {
	width: 100%; /* 이미지를 부모 요소에 꽉 채웁니다. */
	height: 100%; /* 이미지를 부모 요소에 꽉 채웁니다. */
	vertical-align: middle;
}

.nickname {
	font-size: 30px;
	font-weight: bold;
}

.age {
	font-size: 18px;
	font-weight: bold;
}
</style>
</head>
<body style="background: white;">
	<div class="container-xxl bg-white p-0">
		<jsp:include page="header.jsp"></jsp:include>
		<br> <br>
		<div class="container">
			<div class="main-body">
				<div class="container-xl px-4 mt-4">
					<div class="row">
						<div class="col-xl-4">
							<div class="card mb-4 mb-xl-0" style="height: 91%;">
								<!-- <div class="card-header">Profile Picture</div> -->
								<div class="card-body text-center" style="margin-top: 40px;">
									<!-- Profile picture image-->
									<div class="slider-container">
										<div class="slider">
											<div class="slides">
												<c:forEach items="${imageDatas}" var="imageData"
													varStatus="i">
													<div id="slides__${i.count}" class="slide">
														<div class="image-box" style="height: 100%;">
															<img class="img-account-profile mb-2"
																src="data:image/jpeg;base64,${imageData}" alt="S3 Image"
																title="">
														</div>
														<c:choose>
															<c:when test="${i.count eq 1}">
																<!-- i가 1일때는 이전버튼 :4, 다음버튼은 2  -->
																<a id="slide__prev" class="slide__prev"
																	href="#slides__4" title="prev"></a>
																<a id="slide__next" class="slide__next"
																	href="#slides__2" title="Next"><i
																	class='fas fa-caret-right'
																	style='margin-top: -10px; color: black; font-size: 36px'></i></a>
															</c:when>
															<c:when test="${i.count eq 4}">
																<!-- i가 4일때는 이전버튼 :3, 다음버튼은 1  -->
																<a id="slide__prev" class="slide__prev"
																	href="#slides__3" title="prev"></a>
																<a id="slide__next" class="slide__next"
																	href="#slides__1" title="Next"></a>
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
									<br>
									<div class="row">
										<div class="col-xl">
											<span class="nickname">${recommendUser.nickname}, </span><span
												class="age">${recommendUser.age}</span> <br> <span
												style="text-align: left;">${recommendUser.address[0].replace('[','')}</span>
										</div>
										<div class="col-xl">
											<div class="small font-italic text-muted mb-4"
												style="margin-bottom: 50px; left: 50px;">
												<a id="heart"
													style="position: absolute; z-index: 2000; font-size: 50px; left: 55%; color: #ff8cb9;"
													href="/recommendLike?oppUserName=${recommendUser.username}"><i
													class="fa fa-heart"></i></a> <a
													href="/recommendDislike?oppUserName=${recommendUser.username}"
													style="position: absolute; bottom: 7.5%; z-index: 2000; font-size: 59px; color: #747d8c;"><i
													class="fa fa-times"></i></a>
											</div>
										</div>

									</div>


								</div>
							</div>
							<br>
						</div>
						<!-- Header End -->
						<div class="col-xl-8">
							<!-- Account details card-->
							<div class="card mb-4" style="height: 91%;">
								<!--    <div class="card-header">Account Details</div> -->
								<div class="card-body" style="margin-top: 30px;">
									<form>
										<div class="row gx-3 mb-3">
											<!-- Form Row-->
											<div class="col-md-6">
												<label class="small mb-1">Gender</label> <input
													class="form-control" type="text" placeholder="-- 비공개 --"
													value="${recommendUser.sex}">
											</div>
											<div class="col-md-6">
												<label class="small mb-1">Job</label> <input
													class="form-control" type="text" placeholder="--입력 안 됨--"
													value="${recommendUser.job}">
											</div>
										</div>
										<div class="row gx-3 mb-3">
											<div class="col-md-6">
												<label class="small mb-1">Education</label> <input
													class="form-control" type="text" placeholder="--입력 안 됨--"
													value="${recommendUser.school}">
											</div>
											<div class="col-md-6">
												<label class="small mb-1">Interest</label> <input
													class="form-control" type="text" placeholder="--입력 안 됨--"
													value="${recommendUser.interest}">
											</div>
										</div>


										<div class="row gx-3 mb-3">
											<div class="col-md-6">
												<label class="small mb-1">MBTI</label> <input
													class="form-control" type="text" placeholder="--입력 안 됨--"
													value="${recommendUser.mbti}">
											</div>
											<div class="col-md-6">
												<label class="small mb-1">Drink</label> <input
													class="form-control" type="text" placeholder="--입력 안 됨--"
													value="${recommendUser.drinking}">

											</div>
										</div>
										<div class="row gx-3 mb-3">
											<div class="col-md-6">
												<label class="small mb-1">Sport</label> <input
													class="form-control" type="text" placeholder="--입력 안 됨--"
													value="${recommendUser.sport}">
											</div>
											<!-- Form Group (birthday)-->
											<div class="col-md-6">
												<label class="small mb-1">Smoke</label> <input
													class="form-control" type="text" placeholder="--입력 안 됨--"
													value="${recommendUser.smoking}">
											</div>
										</div>
										<div class="col-md-12">
											<label class="small mb-1" for="inputBirthday">자기 소개</label>
											<textarea rows="5" class="form-control" readonly="readonly"
												style="background-color: white; resize: none; outline: none; width: 100%; max-width: 100%; height: auto;">${mvo.aboutme}</textarea>
										</div>
								</div>
								<br>
								<!-- Save changes button-->
								<!--    <button class="btn btn-primary" type="button">Save
                              changes</button> -->
								</form>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>

		<a href="#" class="btn btn-lg btn-primary btn-lg-square back-to-top"
			style="background: pink; border-color: pink;"><i
			class="bi bi-arrow-up"></i></a>
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
       
       function uploadImage() {
            const input = document.getElementById('uploadInput');
            const file = input.files[0];

            if (file) {
              const formData = new FormData();
              formData.append('image', file);

              // 서버로 데이터 전송
              fetch('/upload-endpoint', {
                method: 'POST',
                body: formData,
              })
              .then(response => response.json())
              .then(data => {
                console.log('Upload successful:', data);
              })
              .catch(error => {
                console.error('Error uploading image:', error);
              });
            }
          }
       
   </script>
</body>
</html>