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
<html lang="en">
<head>
<meta charset="utf-8">
<title>Makaan - Real Estate HTML Template</title>
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
.info-front {
	margin-bottom: 40px;
}

input {
	border: none; /* 상단, 좌우, 우측 테두리 제거 */
	border-bottom: 1px solid pink; /* 1px 두께의 검은색 밑줄 스타일 적용 */
	outline: none; /* 포커스 스타일 제거 */
}

.form-select {
	border: none;
}

.info-front {
	margin-bottom: 40px;
}

input {
	border: none;
	border-bottom: 1px solid pink;
	outline: none;
}

.form-select {
	border: none;
}

@media ( max-width : 768px) {
	/* 작은 화면에 대한 스타일 조정 */
	.info-front {
		margin-bottom: 20px;
	}
	input, select {
		width: 100%;
	}
}

#imageForm1 {
	display: inline-block;
	border: 2px solid #ddd;
	padding: 20px;
	border-radius: 10px;
}

#uploadInput {
	display: none;
}

.uploadButton {
	background-color: pink;
	color: white;
	padding: 5px 15px;
	text-align: center;
	text-decoration: none;
	display: inline-block;
	font-size: 16px;
	margin: 4px 2px;
	cursor: pointer;
	border-radius: 5px;
	border: none;
}

div.gallery {
	border: 1px solid white;
	border-radius: 5px;
}

div.gallery:hover {
	border: 1px solid #777;
}

div.gallery img {
	width: 100%;
	height: auto;
}

div.desc {
	padding: 15px;
	text-align: center;
}

* {
	box-sizing: border-box;
}

.responsive {
	padding: 0 6px;
	float: left;
	width: 24.99999%;
}

@media only screen and (max-width: 700px) {
	.responsive {
		width: 49.99999%;
		margin: 6px 0;
	}
}

@media only screen and (max-width: 500px) {
	.responsive {
		width: 100%;
	}
}

.clearfix:after {
	content: "";
	display: table;
	clear: both;
}

#move {
	color: graytext;
	text-align: right;
	margin-top: 10px;
	margin-bottom: 10px;
}

.myButton {
	box-shadow: inset 0px 1px 0px 0px #ffffff;
	background: linear-gradient(to bottom, #ededed 5%, #dfdfdf 100%);
	background-color: #ededed;
	border-radius: 6px;
	border: 1px solid #dcdcdc;
	display: inline-block;
	cursor: pointer;
	color: #777777;
	font-family: Trebuchet MS;
	font-size: 15px;
	font-weight: bold;
	padding: 6px 24px;
	text-decoration: none;
	text-shadow: 0px 1px 0px #ffffff;
}

.myButton:hover {
	background: linear-gradient(to bottom, #dfdfdf 5%, #ededed 100%);
	background-color: #dfdfdf;
}

.myButton:active {
	position: relative;
	top: 1px;
}
</style>
</head>
<body>
	<div class="container-xxl bg-white p-0">
		<jsp:include page="header.jsp"></jsp:include>
		<!-- Navbar End -->


		<!-- Header Start -->
		<br> <br>
		<div class="container">
			<div class="row">
				<div class="col-12 text-center">
					<h2>4개의 사진을 업로드 해주세요</h2>
					<br> <br> <br>
					<div class="card" style="border: none;">
						<div class="card-body mt-3">
							<div class="row">
								<!-- 사진 업로드  -->
								<c:forEach items="${imageDatas}" var="imageData" varStatus="i">
									<div class="responsive">
										<div class="gallery">
											<img src="data:image/jpeg;base64,${imageData}" alt="S3 Image"
												class="rounded" style="width: 300px; height: 350px; width: 100%; cursor: pointer;"
												onclick="openFileInput(${i.count})">
											<form action="${cpath}/fileUpload" method="post"
												enctype="multipart/form-data" id="imageForm${i.count}">
												<input type="hidden" name="${_csrf.parameterName}"
													value="${_csrf.token}" /> <input type="file"
													id="photo${i.count}" name="file" accept="image/*"
													style="width: 100%; visibility: hidden;"
													onchange="uploadOnChange(this)"> <input
													type="hidden" id="photoNum" name="photoNum"
													value="${i.count}">
												<%--<button type="submit" class="myButton" id="uploadButton${i.count} style="display:none;">upload</button> --%>
											</form>
										</div>
									</div>
								</c:forEach>
							</div>
							<br> <br> <br> <br> <br>
						</div>
						<div class="row" style="margin-left: 678px;">
							<div class="col-sm-10">
								<h3 id="move">추가 정보 입력 페이지로 이동</h3>
							</div>
							<div class="col-sm-2">
								<a href="/update" class="btn btn-lg btn-lg-square"
									style="transform: translate(-1px, 7px); background-color: pink; width: 40px; height: 40px;">
									<i class="bi bi-chevron-right" style="color: white"></i>
								</a>
							</div>
						</div>
						<div></div>
						<!-- div 컨테이너  -->
						<!-- 정보 입력 끝!!!!!!!!!!!!!!!!!!!!!!!!  -->
						<br> <br> <br>
						<!-- Header End -->


						<!-- Back to Top -->
						<a href="#"
							class="btn btn-lg btn-primary btn-lg-square back-to-top"><i
							class="bi bi-arrow-up"></i></a>
					</div>
				</div>
			</div>
		</div>
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
   function uploadOnChange(input) {
       if (input.files && input.files[0]) {
           // 파일이 선택되면 자동으로 form submit
          input.parentNode.submit();
       }
   }
     
    function openFileInput(count) {
        document.getElementById('photo' + count).click();
    }

    function displayFileName(input) {
        var fileName = input.files[0].name;
        // 여기에서 파일 이름을 표시하거나 추가적인 작업을 수행할 수 있습니다.
        console.log(fileName);
    }
    
    
   </script>
</body>
</html>