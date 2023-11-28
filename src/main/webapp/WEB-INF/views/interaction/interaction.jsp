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

<!-- 채팅관련 모듈 불러오기 -->
<link href="css/interaction.css" rel="stylesheet">


<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/@stomp/stompjs@7.0.0/bundles/stomp.umd.min.js"></script>


</head>

<body style="background: #FFFFFF;">
	<div class="container-xxl bg-white p-0">
		<jsp:include page="../header.jsp"></jsp:include>
		<!-- 매칭 정보 확인 -->
		<section id="team" class="pb-5">
			<div class="container">
				<h5 class="section-title h1">You've Matched!</h5>
				<div class="row">
					<!-- Team member -->

					<c:forEach var="matchedUser" items="${matchedUsers}"
						varStatus="status">
						<div class="col-xs-12 col-sm-6 col-md-4">
							<div class="image-flip"
								ontouchstart="this.classList.toggle('hover');">
								<div class="mainflip">
									<div class="frontside" style="overflow: hidden;">
										<div class="card">
											<img class="img-fluid"
												src="data:image/jpeg;base64,${matchedUser.photo_base64}"
												alt="card image">
										</div>
									</div>
									<div class="backside">
										<div class="card">
											<div class="card-body text-center mt-4">
												<h4 class="card-title">Sunlimetech</h4>
												<p class="card-text">This is basic card with image on
													top, title, description and button.This is basic card with
													image on top, title, description and button.This is basic
													card with image on top, title, description and button.</p>
												<ul class="list-inline">
													<li class="list-inline-item"><a
														class="social-icon text-xs-center" target="_blank"
														href="#"> <i class="fa fa-facebook"></i>
													</a></li>
													<li class="list-inline-item"><a
														class="social-icon text-xs-center" target="_blank"
														href="#"> <i class="fa fa-twitter"></i>
													</a></li>
													<li class="list-inline-item"><a
														class="social-icon text-xs-center" target="_blank"
														href="#"> <i class="fa fa-skype"></i>
													</a></li>
													<li class="list-inline-item"><a
														class="social-icon text-xs-center" target="_blank"
														href="#"> <i class="fa fa-google"></i>
													</a></li>
												</ul>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</c:forEach>


				</div>
			</div>
		</section>
		<!-- 받은 좋아요 확인 -->
		<section id="team" class="pb-5">
			<div class="container">
				<h5 class="section-title h1">Received likes</h5>
				<div class="row">
					<!-- Team member -->

					<c:forEach var="likedUser" items="${likedUsers}" varStatus="status">
						<div class="col-xs-12 col-sm-6 col-md-4">
							<div class="image-flip"
								ontouchstart="this.classList.toggle('hover');">
								<div class="mainflip">
									<div class="frontside" style="overflow: hidden;">
										<div class="card">
											<img class="img-fluid"
												src="data:image/jpeg;base64,${likedUser.photo_base64}"
												alt="card image">
										</div>
									</div>
									<div class="backside">
										<div class="card">
											<div class="card-body text-center mt-4">
												<h4 class="card-title">Sunlimetech</h4>
												<div style="background-color: #00c851; margin: 5 5 5 5"
													class="chip chip-md success-color white-text  example z-depth-2 mr-0">
													<i class="fas fa-tags "></i> &nbsp;&nbsp;Web Design <i
														class="close white-text fas fa-times"></i>
												</div>
												<div style="background-color: #00c851; margin: 5 5 5 5"
													class="chip chip-md success-color white-text  example z-depth-2 mr-0">
													<i class="fas fa-tags "></i> &nbsp;&nbsp;Web Design <i
														class="close white-text fas fa-times"></i>
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</c:forEach>


				</div>
			</div>
		</section>


		<!-- 보낸 좋아요 확인 -->
		<section id="team" class="pb-5">
			<div class="container">
				<h5 class="section-title h1">sent likes</h5>
				<div class="row">
					<!-- Team member -->

					<c:forEach var="likeUser" items="${likeUsers}" varStatus="status">
						<div class="col-xs-12 col-sm-6 col-md-4">
							<div class="image-flip"
								ontouchstart="this.classList.toggle('hover');">
								<div class="mainflip">
									<div class="frontside" style="overflow: hidden;">
										<div class="card">
											<img class="img-fluid"
												src="data:image/jpeg;base64,${likeUser.photo_base64}"
												alt="card image">
										</div>
									</div>
									<div class="backside">
										<div class="card">
											<div class="card-body text-center mt-4"
												style="text-align: left; overflow-y: auto;">
												<h4 class="card-title">${likeUser.nickname}</h4>
												<p class="card-text">${likeUser.aboutme}</p>


												<c:if test="${not empty likeUser.address}">
													<div style="background-color: #007bff;"
														class="chip chip-md success-color white-text  example z-depth-2 mr-0">
														<i class="fas fa-home"></i> 
														&nbsp;&nbsp;${likeUser.address[0]}
													</div>
													<div style="width: 5px; display: inline;">&nbsp;</div>
												</c:if>
												<c:if test="${not empty likeUser.age}">
													<div style="background-color: #6610f2;"
														class="chip chip-md success-color white-text  example z-depth-2 mr-0">
														<i class="fas fa-birthday-cake"></i> 
														&nbsp;&nbsp;${likeUser.age}
													</div>
													<div style="width: 5px; display: inline;">&nbsp;</div>
												</c:if>
												<c:if test="${not empty likeUser.drinking}">
													<div style="background-color: #6f42c1;"
														class="chip chip-md success-color white-text  example z-depth-2 mr-0">
														<i class="fas fa-beer"></i> 
														&nbsp;&nbsp;${likeUser.drinking}
													</div>
													<div style="width: 5px; display: inline;">&nbsp;</div>
												</c:if>
												<c:if test="${not empty likeUser.interest}">
													<div style="background-color: #e83e8c;"
														class="chip chip-md success-color white-text  example z-depth-2 mr-0">
														<i class="fas fa-book"></i> 
														&nbsp;&nbsp;${likeUser.interest}
													</div>
													<div style="width: 5px; display: inline;">&nbsp;</div>
												</c:if>
												<c:if test="${not empty likeUser.job}">
													<div style="background-color: #dc3545;"
														class="chip chip-md success-color white-text  example z-depth-2 mr-0">
														<i class="fas fa-laptop-code"></i> 
														&nbsp;&nbsp;${likeUser.job}
													</div>
													<div style="width: 5px; display: inline;">&nbsp;</div>
												</c:if>
												<c:if test="${not empty likeUser.mbti}">
													<div style="background-color: #fd7e14;"
														class="chip chip-md success-color white-text  example z-depth-2 mr-0">
														<i class="fas fa-chess"></i> 
														&nbsp;&nbsp;${likeUser.mbti}
													</div>
													<div style="width: 5px; display: inline;">&nbsp;</div>
												</c:if>
												<c:if test="${not empty likeUser.school}">
													<div style="background-color: #28a745;"
														class="chip chip-md success-color white-text  example z-depth-2 mr-0">
														<i class="fas fa-school"></i> 
														&nbsp;&nbsp;${likeUser.school}
													</div>
													<div style="width: 5px; display: inline;">&nbsp;</div>
												</c:if>
												<c:if test="${not empty likeUser.sex}">
													<div style="background-color: #20c997;"
														class="chip chip-md success-color white-text  example z-depth-2 mr-0">
														<i class="fas fa-male"></i> 
														&nbsp;&nbsp;${likeUser.sex}
													</div>
													<div style="width: 5px; display: inline;">&nbsp;</div>
												</c:if>
												<c:if test="${not empty likeUser.smoking}">
													<div style="background-color: #17a2b8;"
														class="chip chip-md success-color white-text  example z-depth-2 mr-0">
														<i class="fas fa-smoking"></i> 
														&nbsp;&nbsp;${likeUser.smoking}
													</div>
													<div style="width: 5px; display: inline;">&nbsp;</div>
												</c:if>
												<c:if test="${not empty likeUser.sport}">
													<div style="background-color: #6c757d;"
														class="chip chip-md success-color white-text  example z-depth-2 mr-0">
														<i class="fas fa-futbol"></i> 
														&nbsp;&nbsp;${likeUser.sport}
													</div>
													<div style="width: 5px; display: inline;">&nbsp;</div>
												</c:if>
												

											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</c:forEach>


				</div>
			</div>
		</section>


		<!-- Back to Top -->
		<a href="#" class="btn btn-lg btn-primary btn-lg-square back-to-top"><i
			class="bi bi-arrow-up"></i></a>

		<!-- footer start -->
		<div
			class="container-fluid bg-dark text-white-50 footer pt-5 mt-5 wow fadeIn"
			data-wow-delay="0.1s">
			<div class="container py-5">
				<div class="row g-5">
					<div class="col-lg-3 col-md-6">
						<h5 class="text-white mb-4">Get In Touch</h5>
						<p class="mb-2">
							<i class="fa fa-map-marker-alt me-3"></i>123 Street, New York,
							USA
						</p>
						<p class="mb-2">
							<i class="fa fa-phone-alt me-3"></i>+012 345 67890
						</p>
						<p class="mb-2">
							<i class="fa fa-envelope me-3"></i>info@example.com
						</p>
						<div class="d-flex pt-2">
							<a class="btn btn-outline-light btn-social" href=""><i
								class="fab fa-twitter"></i></a> <a
								class="btn btn-outline-light btn-social" href=""><i
								class="fab fa-facebook-f"></i></a> <a
								class="btn btn-outline-light btn-social" href=""><i
								class="fab fa-youtube"></i></a> <a
								class="btn btn-outline-light btn-social" href=""><i
								class="fab fa-linkedin-in"></i></a>
						</div>
					</div>
					<div class="col-lg-3 col-md-6">
						<h5 class="text-white mb-4">Quick Links</h5>
						<a class="btn btn-link text-white-50" href="">About Us</a> <a
							class="btn btn-link text-white-50" href="">Contact Us</a> <a
							class="btn btn-link text-white-50" href="">Our Services</a> <a
							class="btn btn-link text-white-50" href="">Privacy Policy</a> <a
							class="btn btn-link text-white-50" href="">Terms & Condition</a>
					</div>
					<div class="col-lg-3 col-md-6">
						<h5 class="text-white mb-4">Photo Gallery</h5>
						<div class="row g-2 pt-2">
							<div class="col-4">
								<img class="img-fluid rounded bg-light p-1"
									src="img/property-1.jpg" alt="">
							</div>
							<div class="col-4">
								<img class="img-fluid rounded bg-light p-1"
									src="img/property-2.jpg" alt="">
							</div>
							<div class="col-4">
								<img class="img-fluid rounded bg-light p-1"
									src="img/property-3.jpg" alt="">
							</div>
							<div class="col-4">
								<img class="img-fluid rounded bg-light p-1"
									src="img/property-4.jpg" alt="">
							</div>
							<div class="col-4">
								<img class="img-fluid rounded bg-light p-1"
									src="img/property-5.jpg" alt="">
							</div>
							<div class="col-4">
								<img class="img-fluid rounded bg-light p-1"
									src="img/property-6.jpg" alt="">
							</div>
						</div>
					</div>
					<div class="col-lg-3 col-md-6">
						<h5 class="text-white mb-4">Newsletter</h5>
						<p>Dolor amet sit justo amet elitr clita ipsum elitr est.</p>
						<div class="position-relative mx-auto" style="max-width: 400px;">
							<input class="form-control bg-transparent w-100 py-3 ps-4 pe-5"
								type="text" placeholder="Your email">
							<button type="button"
								class="btn btn-primary py-2 position-absolute top-0 end-0 mt-2 me-2">SignUp</button>
						</div>
					</div>
				</div>
			</div>
			<div class="container">
				<div class="copyright">
					<div class="row">
						<div class="col-md-6 text-center text-md-start mb-3 mb-md-0">
							&copy; <a class="border-bottom" href="#">Your Site Name</a>, All
							Right Reserved.

							<!--/*** This template is free as long as you keep the footer author’s credit link/attribution link/backlink. If you'd like to use the template without the footer author’s credit link/attribution link/backlink, you can purchase the Credit Removal License from "https://htmlcodex.com/credit-removal". Thank you for your support. ***/-->
							Designed By <a class="border-bottom" href="https://htmlcodex.com">HTML
								Codex</a>
						</div>
						<div class="col-md-6 text-center text-md-end">
							<div class="footer-menu">
								<a href="">Home</a> <a href="">Cookies</a> <a href="">Help</a> <a
									href="">FQAs</a>
							</div>
						</div>
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

	<script type="text/javascript">
		//스크롤 이벤트 핸들러
		window.onscroll = function() {
			// 페이지 끝에 도달했는지 확인
			if (window.innerHeight + window.pageYOffset >= document.body.offsetHeight) {
				// AJAX 호출을 통해 새로운 콘텐츠 로드 (여기서는 예시로 setTimeout을 사용합니다)
				setTimeout(
						function() {
							// 새로운 콘텐츠 블록 추가
							$('#additional-content')
									.append(
											'<div class="row">'
													+ '<div class="col-md-4"><div class="content-block">추가 내용</div></div>'
													+ '<div class="col-md-4"><div class="content-block">추가 내용</div></div>'
													+ '<div class="col-md-4"><div class="content-block">추가 내용</div></div>'
													+ '</div>');
						}, 500); // 0.5초 딜레이 후 콘텐츠 추가
			}
		};
	</script>


</body>

</html>

