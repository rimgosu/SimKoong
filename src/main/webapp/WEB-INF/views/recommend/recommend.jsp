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

<style type="text/css">
	
</style>


</head>

<body style="background: white;">
	<div class="container-xxl bg-white p-0">
		<jsp:include page="../header.jsp"></jsp:include>
		<!-- Navbar End -->

		<!-- 추천 카드 시작 -->
		<div class="container">
			<div style="display: flex; justify-content: center;">
				<div class="col-md-4 like-area droppable" style="align-items: center; justify-content: center; display: flex;">
					<!-- <i class="far fa-heart"></i> -->
				</div>
				<!-- <img src="https://en.js.cx/clipart/soccer-gate.svg" id="gate" class="droppable" style="width: 100%; width: 100px; height: auto;"> -->
				<div class="col-md-4" style="margin : 0; padding: 0">
					<div class="profile-card-2"  id="ball">
						<img src="data:image/jpeg;base64,${imageDatas[0]}" class="img img-responsive">
						<div class="profile-name">${recommendUser.nickname}</div>
						<div class="profile-username">${recommendUser.username}</div>
						<div class="profile-icons">
							<!-- 하트부분 -->
							<a id="heart" style="position: absolute; right: 30px; z-index: 2000;" href="/recommendLike?oppUserName=${recommendUser.username}"><i class="fa fa-heart"></i></a>
							<a href="/recommendDislike?oppUserName=${recommendUser.username}"><i class="fa fa-times"></i></a>
						</div>
					</div>
					<div class="img-space"></div>
				</div>
				<div class="col-md-4 dislike-area droppable" style="align-items: center; justify-content: center; display: flex;">
					
				</div>
				<!-- <img src="https://en.js.cx/clipart/soccer-gate.svg" id="gate" class="droppable" style="width: 100%; width: 100px; height: auto;"> -->
			</div>
		</div>
		<!-- 추천 카드 끝 -->

		
		
		<!-- footer 시작 -->
		<!-- <div class="container-fluid bg-dark text-white-50 footer pt-5 mt-5 wow fadeIn" data-wow-delay="0.1s">
            <div class="container py-5">
                <div class="row g-5">
                    <div class="col-lg-3 col-md-6">
                        <h5 class="text-white mb-4">Get In Touch</h5>
                        <p class="mb-2"><i class="fa fa-map-marker-alt me-3"></i>123 Street, New York, USA</p>
                        <p class="mb-2"><i class="fa fa-phone-alt me-3"></i>+012 345 67890</p>
                        <p class="mb-2"><i class="fa fa-envelope me-3"></i>info@example.com</p>
                        <div class="d-flex pt-2">
                            <a class="btn btn-outline-light btn-social" href=""><i class="fab fa-twitter"></i></a>
                            <a class="btn btn-outline-light btn-social" href=""><i class="fab fa-facebook-f"></i></a>
                            <a class="btn btn-outline-light btn-social" href=""><i class="fab fa-youtube"></i></a>
                            <a class="btn btn-outline-light btn-social" href=""><i class="fab fa-linkedin-in"></i></a>
                        </div>
                    </div>
                    <div class="col-lg-3 col-md-6">
                        <h5 class="text-white mb-4">Quick Links</h5>
                        <a class="btn btn-link text-white-50" href="">About Us</a>
                        <a class="btn btn-link text-white-50" href="">Contact Us</a>
                        <a class="btn btn-link text-white-50" href="">Our Services</a>
                        <a class="btn btn-link text-white-50" href="">Privacy Policy</a>
                        <a class="btn btn-link text-white-50" href="">Terms & Condition</a>
                    </div>
                    <div class="col-lg-3 col-md-6">
                        <h5 class="text-white mb-4">Photo Gallery</h5>
                        <div class="row g-2 pt-2">
                            <div class="col-4">
                                <img class="img-fluid rounded bg-light p-1" src="img/property-1.jpg" alt="">
                            </div>
                            <div class="col-4">
                                <img class="img-fluid rounded bg-light p-1" src="img/property-2.jpg" alt="">
                            </div>
                            <div class="col-4">
                                <img class="img-fluid rounded bg-light p-1" src="img/property-3.jpg" alt="">
                            </div>
                            <div class="col-4">
                                <img class="img-fluid rounded bg-light p-1" src="img/property-4.jpg" alt="">
                            </div>
                            <div class="col-4">
                                <img class="img-fluid rounded bg-light p-1" src="img/property-5.jpg" alt="">
                            </div>
                            <div class="col-4">
                                <img class="img-fluid rounded bg-light p-1" src="img/property-6.jpg" alt="">
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-3 col-md-6">
                        <h5 class="text-white mb-4">Newsletter</h5>
                        <p>Dolor amet sit justo amet elitr clita ipsum elitr est.</p>
                        <div class="position-relative mx-auto" style="max-width: 400px;">
                            <input class="form-control bg-transparent w-100 py-3 ps-4 pe-5" type="text" placeholder="Your email">
                            <button type="button" class="btn btn-primary py-2 position-absolute top-0 end-0 mt-2 me-2">SignUp</button>
                        </div>          
                    </div>
                </div>
            </div>
            <div class="container">
                <div class="copyright">
                    <div class="row">
                        <div class="col-md-6 text-center text-md-start mb-3 mb-md-0">
                            &copy; <a class="border-bottom" href="#">Your Site Name</a>, All Right Reserved. 
							
							/*** This template is free as long as you keep the footer author’s credit link/attribution link/backlink. If you'd like to use the template without the footer author’s credit link/attribution link/backlink, you can purchase the Credit Removal License from "https://htmlcodex.com/credit-removal". Thank you for your support. ***/
							Designed By <a class="border-bottom" href="https://htmlcodex.com">HTML Codex</a>
                        </div>
                        <div class="col-md-6 text-center text-md-end">
                            <div class="footer-menu">
                                <a href="">Home</a>
                                <a href="">Cookies</a>
                                <a href="">Help</a>
                                <a href="">FQAs</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div> -->
        <!-- Footer End -->

		<!-- Back to Top -->
		<!-- <a href="#" class="btn btn-lg btn-primary btn-lg-square back-to-top"><i
			class="bi bi-arrow-up"></i></a>
	</div> -->

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
	
	$(document).ready(function(){
	});
	
	
    var startX, startY, endX, endY; // 시작 및 종료 좌표 변수
    var minStartX = 60, maxStartX = 1130, minStartY = 88, maxStartY = 574;
    var minEndX = 0, maxEndX = 715, minEndY = 0, maxEndY = 894;

    // 마우스를 클릭했을 때 호출되는 함수
    document.addEventListener("mousedown", function(event) {
        // 이미지를 클릭한 경우 이벤트 전파를 중지하여 드래그를 방지
         if (event.target.id === "profileCard") {
            event.preventDefault();
        } 

        startX = event.clientX; // 첫 클릭한 x 좌표
        startY = event.clientY; // 첫 클릭한 y 좌표
    });

    // 마우스를 뗐을 때 호출되는 함수
    document.addEventListener("mouseup", function(event) {
        endX = event.clientX; // 마지막으로 뗀 x 좌표
        endY = event.clientY; // 마지막으로 뗀 y 좌표
        
        console.log("첫 클릭 위치: (" + startX + ", " + startY + ")");
        console.log("마지막 클릭 위치: (" + endX + ", " + endY + ")");

        // 첫 클릭한 위치와 마지막으로 뗀 위치가 주어진 범위에 속하는지 확인
         if (startX >= minStartX && startX <= maxStartX && startY >= minStartY && startY <= maxStartY &&
            endX >= minEndX && endX <= maxEndX && endY >= minEndY && endY <= maxEndY) {
            // 조건을 충족하면 좋아요 추가 기능을 수행
            addLikeToUser('${recommendUser.username}');
        }else if ((startX - endX) <= 40 && startY == endY) {
        	showUserProfile('${recommendUser.username}');
        }
        
    });

    // 좋아요를 추가하는 함수
    function addLikeToUser(username) {
        // 여기에 좋아요를 추가하는 로직을 구현
        // 예를 들면, 서버에 AJAX 요청을 보내거나 관련 데이터를 업데이트하는 등의 작업을 수행
        console.log('${recommendUser.username}에게 좋아요를 추가합니다.');
        /* location.reload(); */
    }
    
    function showUserProfile(username) {
        // 여기에 좋아요를 추가하는 로직을 구현
        // 예를 들면, 서버에 AJAX 요청을 보내거나 관련 데이터를 업데이트하는 등의 작업을 수행
        console.log('${recommendUser.username}의 정보를 봅니다.');
        /* location.reload(); */
    }
    
    let currentDroppable = null;
    let originalPosition = { x: 0, y: 0 };

    ball.onmousedown = function (event) {
        // 이미지 엘리먼트 가져오기
        var imgElement = document.querySelector('.img');

        // 이미지의 폭과 높이 가져오기
        var imgWidth = imgElement.width;
        var imgHeight = imgElement.height;

        // 새로운 div 엘리먼트 생성
        var divElement = document.createElement('div');

        // div에 스타일을 적용하여 이미지 크기로 설정
        divElement.style.width = imgWidth + 'px';
        divElement.style.height = imgHeight + 'px';

        // .col-md-4 클래스를 가진 부모 엘리먼트 가져오기
        var colElement = document.querySelector('.img-space');
        colElement.innerText = '';

        // 생성된 div를 .col-md-4 클래스를 가진 엘리먼트에 추가
        colElement.appendChild(divElement);
		
        var likeArea = document.querySelector('.like-area');

        // 하트 이모티콘을 포함하는 새로운 div 엘리먼트 생성
        var heartElement = document.createElement('div');
        heartElement.className = 'heart';
        heartElement.innerHTML = '❤️'; // 하트 이모티콘 추가

        // 생성된 하트를 like-area 클래스를 가진 엘리먼트에 추가
        likeArea.appendChild(heartElement);
        
        var dislikeArea = document.querySelector('.dislike-area');

        // 하트 이모티콘을 포함하는 새로운 div 엘리먼트 생성
        var xElement = document.createElement('div');
        xElement.className = 'x-icon';
        xElement.innerHTML = '❌'; // 하트 이모티콘 추가

        // 생성된 하트를 like-area 클래스를 가진 엘리먼트에 추가
        dislikeArea.appendChild(xElement);
        
        // 이전 위치 저장
        originalPosition.x = ball.getBoundingClientRect().left;
        originalPosition.y = ball.getBoundingClientRect().top;

        let shiftX = event.clientX - ball.getBoundingClientRect().left;
        let shiftY = event.clientY - ball.getBoundingClientRect().top;
        
       	ball.style.position = 'absolute';
        ball.style.zIndex = 1000;
        /* document.body.append(ball); */

        moveAt(event.pageX, event.pageY);

        function moveAt(pageX, pageY) {
            ball.style.left = pageX - shiftX + 'px';
            ball.style.top = pageY - shiftY + 'px';
        }

        function onMouseMove(event) {
            moveAt(event.pageX, event.pageY);

            ball.hidden = true;
            let elemBelow = document.elementFromPoint(event.clientX, event.clientY);
            ball.hidden = false;

            if (!elemBelow) return;

            let droppableBelow = elemBelow.closest('.droppable');
            if (currentDroppable !== droppableBelow) {
                if (currentDroppable) {
                    leaveDroppable(currentDroppable);
                }
                currentDroppable = droppableBelow;
                if (currentDroppable) {
                    enterDroppable(currentDroppable);
                }
            }
        }

        document.addEventListener('mousemove', onMouseMove);

        ball.onmouseup = function () {
            document.removeEventListener('mousemove', onMouseMove);
            ball.onmouseup = null;
            likeArea.removeChild(heartElement);
            dislikeArea.removeChild(xElement);
            // 마우스를 뗄 때, 원래 위치로 이동
            ball.style.left = originalPosition.x + 'px';
            ball.style.top = originalPosition.y - 10 + 'px';

            // currentDroppable 초기화
            if (currentDroppable) {
                if (currentDroppable.classList.contains('like-area')) {
                    // 좋아요 영역에 들어왔을 때의 처리
                    // 여기에 좋아요를 추가하는 로직을 추가하세요.
                	window.location.href = "/recommendLike?oppUserName=${recommendUser.username}";
                } else if (currentDroppable.classList.contains('dislike-area')) {
                    // 싫어요 영역에 들어왔을 때의 처리
                    // 여기에 싫어요를 추가하는 로직을 추가하세요.
                	window.location.href = "/recommendDislike?oppUserName=${recommendUser.username}";                	
                }

                
                leaveDroppable(currentDroppable);
                currentDroppable = null;
            }
            
            colElement.innerHTML = '';
            
        };
    };

    function enterDroppable(elem) {
        if (elem.classList.contains('like-area')) {
        	elem.style.background = 'pink';
        } else if (elem.classList.contains('dislike-area')) {
        	elem.style.background = 'gray';
        }
        
    }

    function leaveDroppable(elem) {
        elem.style.background = '';
    }

    ball.ondragstart = function () {
        return false;
    };
	
	</script>

</body>

</html>