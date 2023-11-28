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
<title>BABE</title>
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
	/* line-height: 1; */
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

input:focus {
	outline: 1px solid #ced4da;
}
</style>
</head>
<body style="background: white;">
	<div class="container-xxl bg-white p-0">
		<jsp:include page="header.jsp"></jsp:include>
		<!-- Navbar End -->

		<!-- Header Start -->
		<br> <br>
		<div class="container-xl px-4 mt-4">
			<!-- < class="mt-0 mb-4"> -->
			<form action="${cpath}/update" method="post">
				<input type="hidden" name="_csrf" value="${_csrf.token}" />
				<div class="row">
					<div class="col-xl-4">
						<!-- Profile picture card-->
						<div class="card mb-4 mb-xl-0">
							<div class="card-header">Profile Picture</div>
							<div class="card-body text-center">
								<!-- Profile picture image-->
								<a href="/photoUpload" id="photoLink"> <img
									class="img-account-profile mb-2"
									src="data:image/jpeg;base64,${imageDatas[0]}" alt=""
									style="border-radius: 10px;">
								</a>
								<!-- Profile picture help block-->
								<div class="small font-italic text-muted mb-4"></div>
								<!-- Profile picture upload button-->

								<h5>
									<input class="" id="nickname" name="nickname" type="text"
										placeholder="Nick" value="${mvo.nickname}"
										style="text-align: center; border: none; border-radius: 3px;">
								</h5>

								<c:if test="${empty mvo_session }">
									<a href="/location" id="photoLink">현재 위치 설정</a>
								</c:if>
								<c:if test="${not empty mvo_session }">
									<a href="/location" id="photoLink">${mvo_session.address[0].replace('[','')}</a>
								    <c:if test="${empty mvo_session.address}">
								    	<a href="/location" id="photoLink">현재 위치 설정</a>
									</c:if>
								</c:if>
							</div>
						</div>
						<br>
						<div class="card mb-4 mb-xl-0" style="height: 234px;">
							<div class="card-header text-center">About me</div>
							<div class="card-body">
								<div class="small font-italic text-muted mb-4">
									<textarea rows="7" cols="48" name="aboutme"
										style="border: none; resize: none; outline: none; width: 100%;"
										placeholder="내용을 입력하세요">${mvo.aboutme}</textarea>
								</div>
							</div>
						</div>
					</div>
					<div class="col-xl-8">
						<!-- Account details card-->
						<div class="card mb-4">
							<div class="card-header">Account Details</div>
							<div class="card-body">

								<!-- Form Group (username)-->
								<div class="row gx-3 mb-3">
									<div class="col-md-6">
										<label class="small mb-1" for="inputFirstName">Age</label> <input
											class="form-control" id="age" name="age" type="number"
											placeholder="Enter your age" value="${mvo.age}" required>
									</div>
									<div class="col-md-6">
										<label class="small mb-1" for="inputFirstName">Gender</label>
										<select class="form-control" id="sex" name="sex"
											style="background-color: white;" required>
											<option th:selected="${mvo.sex == '남성'}" value="남성"  value="남성">남성</option>
											<option th:selected="${mvo.sex == '여성'}" value="여성" value="여성">여성</option>
										</select>
									</div>
								</div>
								<!-- Form Row-->
								<div class="row gx-3 mb-3">
									<!-- Form Group (first name)-->
									<div class="col-md-6">
										<label class="small mb-1" for="inputLastName">Phone</label>
										 <input class="form-control" id="phone" name="phone" type="tel" placeholder="Enter your last name" value="${mvo.phone}"
											required>
									</div>
									<!-- Form Group (last name)-->
									<div class="col-md-6">
										<label class="small mb-1" for="inputLocation">Interest</label>
										<input class="form-control" id="interest" name="interest"
											type="text" placeholder="Enter your location"
											value="${mvo.interest}" required>
									</div>
								</div>
								<!-- Form Group (email address)-->
								<div class="row gx-3 mb-3">
									<div class="col-md-6">
										<label class="small mb-1" for="inputEmailAddress">MBTI</label>
										<select class="form-control" id="mbti" name="mbti"
											style="background-color: white;" required>
											<option value="${mvo.mbti}" selected hidden>${mvo.mbti}</option>
											<optgroup label="E">
												<option value="ESTP">ESTP</option>
												<option value="ESFP">ESFP</option>
												<option value="ESFJ">ESFJ</option>
												<option value="ESFJ">ESFJ</option>
												<option value="ENTP">ENTP</option>
												<option value="ENTJ">ENTJ</option>
												<option value="ENFP">ENFP</option>
												<option value="ENFJ">ENFJ</option>
											</optgroup>
											<optgroup label="I">
												<option value="ISFP">ISFP</option>
												<option value="ISFJ">ISFJ</option>
												<option value="ISTP">ISTP</option>
												<option value="ISTJ">ISTJ</option>
												<option value="INTP">INTP</option>
												<option value="INTJ">INTJ</option>
												<option value="INFP">INFP</option>
												<option value="INFJ">INFJ</option>
											</optgroup>
										</select>
									</div>
									<div class="col-md-6">
										<label class="small mb-1" for="inputPhone">Education</label> <select
											class="form-control" id="school" name="school"
											style="background-color: white;" required>
											<option value="${mvo.school}" selected hidden>${mvo.school}</option>
											<option value="박사">박사</option>
											<option value="석사">석사</option>
											<option value="대학교 졸업">대학교 졸업</option>
											<option value="대학교 재학">대학교 재학</option>
											<option value="전문대 졸업">전문대 졸업</option>
											<option value="전문대 재학">전문대 재학</option>
											<option value="고등학교">고등학교</option>
											<option value="중학교">중학교</option>
											<option value="기타">기타</option>
											<option value="비공개">비공개</option>
										</select>
									</div>
								</div>

								<!-- Form Row-->
								<div class="row gx-3 mb-3">
									<!-- Form Group (phone number)-->
									<div class="col-md-6">
										<label class="small mb-1" for="inputPhone">Sport</label> <select
											class="form-control" id="sport" name="sport"
											style="background-color: white;" required>
											<option value="${mvo.sport}" selected hidden>${mvo.sport}</option>
											<option value="운동 선호">운동 선호</option>
											<option value="운동 비선호">운동 비선호</option>
										</select>
									</div>
									<!-- Form Group (birthday)-->
									<div class="col-md-6">
										<label class="small mb-1" for="inputBirthday">Smoke</label> <select
											class="form-control" id="smoking" name="smoking"
											style="background-color: white;" required>
											<option value="${mvo.smoking}" selected hidden>${mvo.smoking}</option>
											<option value="예">예</option>
											<option value="아니오">아니오</option>
										</select>
									</div>
								</div>
								<div class="row gx-3 mb-3">
									<!-- Form Group (phone number)-->
									<div class="col-md-6">
										<label class="small mb-1" for="inputPhone">Drink</label> <select
											class="form-control" id="drinking" name="drinking"
											style="background-color: white;" required>
											<option value="${mvo.drinking}" selected hidden>${mvo.drinking}</option>
											<option value="예">예</option>
											<option value="아니오">아니오</option>
										</select>
									</div>
									<!-- Form Group (birthday)-->
									<div class="col-md-6">
										<label class="small mb-1" for="inputBirthday">Job</label> <input
											class="form-control" id="job" type="text" name="job"
											placeholder="Enter your birthday" value="${mvo.job}" style=""
											required>
									</div>
								</div>
								<!-- Save changes button-->
								<!-- <button class="btn btn-primary" style="float: right; border-color: pink; background-color: pink;" type="button">Save changes</button> -->
								<input type="submit" class="btn btn-info"
									style="float: right; border-color: pink; background-color: pink; color: white;"
									type="button" value="Save changes">
							</div>
						</div>
					</div>
				</div>

			</form>
		</div>
	</div>
	<!-- Header End -->


	<!-- Back to Top -->
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
             
     /* // JavaScript 코드
       window.onload = function () {
         // 페이지가 로드될 때 실행되는 함수

         // input 요소 가져오기
         var inputElement = document.getElementById('inputUsername');

         // 닉네임 길이 가져오기
         var nicknameLength = "${mvo.nickname}".length;

         // 입력 태그의 길이 설정
         inputElement.setAttribute('size', nicknameLength);
       };  */
       
       
   </script>

</body>
</html>