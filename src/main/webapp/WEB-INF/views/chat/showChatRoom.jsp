<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="cpath" value="${pageContext.request.contextPath}" />
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
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
    <link href="https://fonts.googleapis.com/css2?family=Heebo:wght@400;500;600&family=Inter:wght@700;800&display=swap" rel="stylesheet">
    
    <!-- Icon Font Stylesheet -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.0/css/all.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css" rel="stylesheet">

    <!-- Libraries Stylesheet -->
    <link href="lib/animate/animate.min.css" rel="stylesheet">
    <link href="lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">

    <!-- Customized Bootstrap Stylesheet -->
    <link href="css/bootstrap.min.css" rel="stylesheet">

    <!-- Template Stylesheet -->
    <link href="css/style.css" rel="stylesheet">
    
    <!-- 채팅관련 모듈 불러오기 -->
    <link href="css/chat.css" rel="stylesheet">
    
    
    <script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@stomp/stompjs@7.0.0/bundles/stomp.umd.min.js"></script>
    <!-- 채팅관련 모듈 불러오기 끝 -->
    
</head>

<body>
    <div class="container-xxl bg-white p-0">
        <jsp:include page="../header.jsp"></jsp:include>
        <!-- 채팅방 보여주기 기능  -->
        
        
		<section style="background-color: #eee;">
		  <div class="container py-5">
		
		    <div class="row">
		
		      <div class="col-md-6 col-lg-5 col-xl-4 mb-4 mb-md-0">
		
		        <h5 class="font-weight-bold mb-3 text-center text-lg-start">Member</h5>
		
		        <div class="card">
		          <div class="card-body">
		
		            <ul id="chatRoomList" class="list-unstyled mb-0" style="max-height: 700px;">
		              
		              <c:forEach var="chatRoomNotification" items="${chatRoomNotifications}" varStatus="status">
		              		<c:if test="${chatRoomNotification.notification_count == 0}">
						    	<li class="p-2 border-bottom chatRoomItem" >
						    </c:if>
						    <c:if test="${chatRoomNotification.notification_count != 0}">
						    	<li class="p-2 border-bottom chatRoomItem" style="background-color: #eee;">
						    </c:if>
						        <a href="#!" class="chat-link d-flex justify-content-between" data-room-uuid="${chatRoomNotification.type_uuid}">
						            <div class="d-flex flex-row">
						                <img src="https://mdbcdn.b-cdn.net/img/Photos/Avatars/avatar-8.webp" alt="avatar"
						                    class="rounded-circle d-flex align-self-center me-3 shadow-1-strong" width="60">
						                <div class="pt-1">
						                    <p class="fw-bold mb-0">${chatRoomNotification.opponent_username}</p>
						                    <p class="small text-muted">Hello, Are you there?</p>
						                </div>
						            </div>
						            <div class="pt-1 chatRoomTime">
						                <span id="timeAgo"></span>
						                <c:if test="${chatRoomNotification.notification_count != 0}">
						                    <span class="badge bg-danger float-end">${chatRoomNotification.notification_count}</span>
						                </c:if>
						            </div>
						        </a>
						    </li>
						</c:forEach>

		              
		              
		              
		              
		              
		              
		              <li class="p-2 border-bottom">
		                <a href="#!" class="d-flex justify-content-between">
		                  <div class="d-flex flex-row">
		                    <img src="https://mdbcdn.b-cdn.net/img/Photos/Avatars/avatar-1.webp" alt="avatar"
		                      class="rounded-circle d-flex align-self-center me-3 shadow-1-strong" width="60">
		                    <div class="pt-1">
		                      <p class="fw-bold mb-0">Danny Smith</p>
		                      <p class="small text-muted">Lorem ipsum dolor sit.</p>
		                    </div>
		                  </div>
		                  <div class="pt-1">
		                    <p class="small text-muted mb-1">5 mins ago</p>
		                  </div>
		                </a>
		              </li>
		              <li class="p-2 border-bottom">
		                <a href="#!" class="d-flex justify-content-between">
		                  <div class="d-flex flex-row">
		                    <img src="https://mdbcdn.b-cdn.net/img/Photos/Avatars/avatar-2.webp" alt="avatar"
		                      class="rounded-circle d-flex align-self-center me-3 shadow-1-strong" width="60">
		                    <div class="pt-1">
		                      <p class="fw-bold mb-0">Alex Steward</p>
		                      <p class="small text-muted">Lorem ipsum dolor sit.</p>
		                    </div>
		                  </div>
		                  <div class="pt-1">
		                    <p class="small text-muted mb-1">Yesterday</p>
		                  </div>
		                </a>
		              </li>
		              <li class="p-2 border-bottom">
		                <a href="#!" class="d-flex justify-content-between">
		                  <div class="d-flex flex-row">
		                    <img src="https://mdbcdn.b-cdn.net/img/Photos/Avatars/avatar-3.webp" alt="avatar"
		                      class="rounded-circle d-flex align-self-center me-3 shadow-1-strong" width="60">
		                    <div class="pt-1">
		                      <p class="fw-bold mb-0">Ashley Olsen</p>
		                      <p class="small text-muted">Lorem ipsum dolor sit.</p>
		                    </div>
		                  </div>
		                  <div class="pt-1">
		                    <p class="small text-muted mb-1">Yesterday</p>
		                  </div>
		                </a>
		              </li>
		              <li class="p-2 border-bottom">
		                <a href="#!" class="d-flex justify-content-between">
		                  <div class="d-flex flex-row">
		                    <img src="https://mdbcdn.b-cdn.net/img/Photos/Avatars/avatar-4.webp" alt="avatar"
		                      class="rounded-circle d-flex align-self-center me-3 shadow-1-strong" width="60">
		                    <div class="pt-1">
		                      <p class="fw-bold mb-0">Kate Moss</p>
		                      <p class="small text-muted">Lorem ipsum dolor sit.</p>
		                    </div>
		                  </div>
		                  <div class="pt-1">
		                    <p class="small text-muted mb-1">Yesterday</p>
		                  </div>
		                </a>
		              </li>
		              <li class="p-2 border-bottom">
		                <a href="#!" class="d-flex justify-content-between">
		                  <div class="d-flex flex-row">
		                    <img src="https://mdbcdn.b-cdn.net/img/Photos/Avatars/avatar-5.webp" alt="avatar"
		                      class="rounded-circle d-flex align-self-center me-3 shadow-1-strong" width="60">
		                    <div class="pt-1">
		                      <p class="fw-bold mb-0">Lara Croft</p>
		                      <p class="small text-muted">Lorem ipsum dolor sit.</p>
		                    </div>
		                  </div>
		                  <div class="pt-1">
		                    <p class="small text-muted mb-1">Yesterday</p>
		                  </div>
		                </a>
		              </li>
		              <li class="p-2">
		                <a href="#!" class="d-flex justify-content-between">
		                  <div class="d-flex flex-row">
		                    <img src="https://mdbcdn.b-cdn.net/img/Photos/Avatars/avatar-6.webp" alt="avatar"
		                      class="rounded-circle d-flex align-self-center me-3 shadow-1-strong" width="60">
		                    <div class="pt-1">
		                      <p class="fw-bold mb-0">Brad Pitt</p>
		                      <p class="small text-muted">Lorem ipsum dolor sit.</p>
		                    </div>
		                  </div>
		                  <div class="pt-1">
		                    <p class="small text-muted mb-1">5 mins ago</p>
		                    <span class="text-muted float-end"><i class="fas fa-check" aria-hidden="true"></i></span>
		                  </div>
		                </a>
		              </li>
		            </ul>
		
		          </div>
		        </div>
		
		      </div>
		
		      <div class="col-md-6 col-lg-7 col-xl-8">
		
		        <ul class="list-unstyled" id="chatting-ul"></ul>
		        <ul class="list-unstyled" id="send-ul"></ul>
		
		      </div>
		
		    </div>
		
		  </div>
		</section>
        
        
        
        
        <!-- 채팅방 보여주기 기능 끝 -->
        
        <div class="container-fluid bg-dark text-white-50 footer pt-5 mt-5 wow fadeIn" data-wow-delay="0.1s">
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
							
							<!--/*** This template is free as long as you keep the footer author’s credit link/attribution link/backlink. If you'd like to use the template without the footer author’s credit link/attribution link/backlink, you can purchase the Credit Removal License from "https://htmlcodex.com/credit-removal". Thank you for your support. ***/-->
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
        </div>
        <!-- Footer End -->


        <!-- Back to Top -->
        <a href="#" class="btn btn-lg btn-primary btn-lg-square back-to-top"><i class="bi bi-arrow-up"></i></a>
    </div>

    <!-- JavaScript Libraries -->
    <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="lib/wow/wow.min.js"></script>
    <script src="lib/easing/easing.min.js"></script>
    <script src="lib/waypoints/waypoints.min.js"></script>
    <script src="lib/owlcarousel/owl.carousel.min.js"></script>

    <!-- Template Javascript -->
    <script src="js/main.js"></script>
    
<script>
/****************************
[채팅 클릭][채팅 보여주기] 시작
*****************************/

var roomUuid;
$(document).ready(function() {
    $('.chat-link').click(function(e) {
        e.preventDefault();
        roomUuid = $(this).data('room-uuid');
        getChatting(roomUuid);
    });

    // ${chatRoomUuid}가 null이 아닌 경우 AJAX 호출
    if ('${chatRoomUuid}' !== '') {
        roomUuid = '${chatRoomUuid}';
        getChatting(roomUuid);
    }

    // AJAX 호출을 수행하는 별도의 함수
    function getChatting(roomUuid) {
        $.ajax({
            url: '/GetChatting',
            type: 'GET',
            data: { room_uuid: roomUuid },
            success: function(chattings) {
                var chattingListHtml = '';
                var sendHtml = '';
                chattings.forEach(function(chat) {
                    if('${mvo.username}' === chat.chat_chatter) {
                        // 사용자 이름이 같은 경우, 왼쪽에 이미지를 위치시킴
                        chattingListHtml += `
                            <li class="d-flex justify-content-between mb-4">
                                <img src="https://mdbcdn.b-cdn.net/img/Photos/Avatars/avatar-6.webp" alt="avatar" class="rounded-circle d-flex align-self-start me-3 shadow-1-strong" width="60">
                                <div class="card">
                                    <div class="card-header d-flex justify-content-between p-3">
                                        <p class="fw-bold mb-0">\${chat.chat_chatter}</p>
                                        <p class="text-muted small mb-0"><i class="far fa-clock"></i>\${new Date(chat.chatted_at).toLocaleString()}</p>
                                    </div>
                                    <div class="card-body">
                                        <p class="mb-0">\${chat.chat_content}</p>
                                    </div>
                                </div>
                            </li>`;
                    } else {
                        // 사용자 이름이 다른 경우, 오른쪽에 이미지를 위치시킴
                        chattingListHtml += `
                            <li class="d-flex justify-content-between mb-4">
                                <div class="card w-100">
                                    <div class="card-header d-flex justify-content-between p-3">
                                        <p class="fw-bold mb-0">\${chat.chat_chatter}</p>
                                        <p class="text-muted small mb-0"><i class="far fa-clock"></i>\${new Date(chat.chatted_at).toLocaleString()}</p>
                                    </div>
                                    <div class="card-body">
                                        <p class="mb-0">\${chat.chat_content}</p>
                                    </div>
                                </div>
                                <img src="https://mdbcdn.b-cdn.net/img/Photos/Avatars/avatar-5.webp" alt="avatar" class="rounded-circle d-flex align-self-start ms-3 shadow-1-strong" width="60">
                            </li>`;
                    }
                });

                // 입력창
                sendHtml += `
                    <form class="form-inline">       
                        <li class="bg-white mb-3" style="border-radius: 15px;">
                            <div class="form-outline" style="width: 100%;">
                                <textarea class="form-control" id="chat_content" rows="4"></textarea>
                            </div>
                        </li>
                        `;

                // send 버튼
                sendHtml += `
                        <button type="submit" id="send" class="btn btn-info btn-rounded float-end">Send</button>
                    </form>
                    `;

                $('#chatting-ul').html(chattingListHtml);
                $('#send-ul').html(sendHtml);

                var chattingUl = $('#chatting-ul');
                chattingUl.scrollTop(chattingUl.prop('scrollHeight'));

            },

            error: function(error) {
                console.error(error);
            }
        });
    }
});


/****************************
	[채팅 클릭][채팅 보여주기] 끝
*****************************/






/****************************
	[웹소켓] 시작
*****************************/
$(document).ready(function() {
    connect(); // 페이지 로드 시 WebSocket 연결을 시작합니다.
});

host_address = '${hostAddress}'
var username = '@Session["username"]';

const stompClient = new StompJs.Client({
    brokerURL: `ws://\${host_address}:8081/gs-guide-websocket`
});

stompClient.onConnect = (frame) => {
    setConnected(true);
    console.log('Connected: ' + frame);
    stompClient.subscribe('/topic/greetings', (greeting) => {
        const chattingData = JSON.parse(greeting.body);
        // 필요한 데이터를 추출하여 사용
        // 예: chattingData.chat_uuid, chattingData.chat_content 등
        showGreeting(chattingData); // 또는 필요에 따라 다른 데이터를 사용
    });
};

stompClient.onWebSocketError = (error) => {
    console.error('Error with websocket', error);
};

stompClient.onStompError = (frame) => {
    console.error('Broker reported error: ' + frame.headers['message']);
    console.error('Additional details: ' + frame.body);
};

function setConnected(connected) {
    $("#connect").prop("disabled", connected);
    $("#disconnect").prop("disabled", !connected);
    if (connected) {
        $("#conversation").show();
    }
    else {
        $("#conversation").hide();
    }
    $("#greetings").html("");
}

function connect() {
    stompClient.activate();
}

function disconnect() {
    stompClient.deactivate();
    setConnected(false);
    console.log("Disconnected");
}

function sendName() {
    stompClient.publish({
        destination: "/app/hello",
        body: JSON.stringify({
        	'chat_content': $("#chat_content").val(),
        	'room_uuid' : roomUuid,
        	'chat_chatter' : '${mvo.username}'
        })
    });
    
    /// textarea 내용 초기화
    $('#chat_content').val('');
}

function showGreeting(chattingData) {
    var htmlContent;
    
    // mvo.username과 chattingData.chat_chatter가 일치하는 경우
    if ('${mvo.username}' === chattingData.chat_chatter) {
        htmlContent = `
        <li class="d-flex justify-content-between mb-4">
            <img src="https://mdbcdn.b-cdn.net/img/Photos/Avatars/avatar-6.webp" alt="avatar" class="rounded-circle d-flex align-self-start me-3 shadow-1-strong" width="60">
            <div class="card">
                <div class="card-header d-flex justify-content-between p-3">
                    <p class="fw-bold mb-0">\${chattingData.chat_chatter}</p>
                    <p class="text-muted small mb-0"><i class="far fa-clock"></i>\${new Date().toLocaleString()}</p>
                </div>
                <div class="card-body">
                    <p class="mb-0">\${chattingData.chat_content}</p>
                </div>
            </div>
        </li>
        `;
    } else {
        // mvo.username과 chattingData.chat_chatter가 일치하지 않는 경우
    	htmlContent = `
        <li class="d-flex justify-content-between mb-4">
            <div class="card w-100">
                <div class="card-header d-flex justify-content-between p-3">
                    <p class="fw-bold mb-0">\${chattingData.chat_chatter}</p>
                    <p class="text-muted small mb-0"><i class="far fa-clock"></i>\${new Date().toLocaleString()}</p>
                </div>
                <div class="card-body">
                    <p class="mb-0">\${chattingData.chat_content}</p>
                </div>
            </div>
            <img src="https://mdbcdn.b-cdn.net/img/Photos/Avatars/avatar-5.webp" alt="avatar" class="rounded-circle d-flex align-self-start ms-3 shadow-1-strong" width="60">
        </li>`;
    }

    $('#chatting-ul').append(htmlContent);

    // 스크롤을 최하단으로 이동
    var chattingUl = $('#chatting-ul');
    chattingUl.scrollTop(chattingUl.prop('scrollHeight'));
    
}


// #send 누르면 sendName() 함수 실행
$(document).on('submit', 'form', function(e) {
    e.preventDefault();
});

$(document).on('click', '#send', function() {
    sendName();
});

/****************************
	[웹소켓] 끝
*****************************/



/****************************
	[채팅방 클릭시 ]
*****************************/
document.addEventListener("DOMContentLoaded", function() {
    // 모든 채팅 링크에 이벤트 리스너 추가
    document.querySelectorAll('.chat-link').forEach(function(link) {
        link.addEventListener('click', function() {
            // 부모 <li> 요소 선택
            var li = this.closest('.chatRoomItem');

            // <li> 요소의 스타일 변경
            if (li) {
                li.style.backgroundColor = '';
            }

            // 알림 배지 요소 찾기 및 내용 변경
            var badge = li.querySelector('.badge');
            if (badge) {
                badge.textContent = '';
            }
        });
    });
});



</script>
    
</body>

</html>

