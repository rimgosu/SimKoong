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
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.0/css/all.min.css" rel="stylesheet">
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
    
    <link href="https://fonts.googleapis.com/css2?family=Nanum+Pen+Script&display=swap" rel="stylesheet">
    
    
</head>

<body>
    <div class="container-xxl bg-white p-0">
        <jsp:include page="../header.jsp"></jsp:include>
        
        
        <!-- 채팅방 보여주기 기능  -->
        
		<section style="background-color: #ffffff;">
	
		<c:if test="${empty chatRoomNotifications }">
		
		<div class="container">
				<div id="randomImage" style="display: flex; justify-content: center; align-items: center; flex-direction: column;">
					<img src="img/x/x3.png" style="width: 60%; display: block; ">
					<p style="color: #ff8cb9; font-size: 70px; margin-top: 20px; font-family: 'Nanum Pen Script';">채팅이 없습니다</p>
				</div>
			</div>
		
		</c:if>
		<c:if test="${not empty chatRoomNotifications }">
		
		<div class="container py-5">
		
		    <div class="row">
		
		      <div class="col-md-6 col-lg-5 col-xl-4 mb-4 mb-md-0">
		
		        <div class="card" style="height: 626px; border-color: #999999; box-shadow: 2px 2px 2px rgba(128, 128, 128, 0.2);">
		          <div class="card-body">
		
		            <ul id="chatRoomList" class="list-unstyled mb-0" style="height: 700px;">
		              
		              <c:forEach var="chatRoomNotification" items="${chatRoomNotifications}" varStatus="status">
		              		<c:if test="${chatRoomNotification.notification_count == 0}">
						    	<li class="p-2 border-bottom chatRoomItem" >
						    </c:if>
						    <c:if test="${chatRoomNotification.notification_count != 0}">
						    	<li class="p-2 border-bottom chatRoomItem" style="background-color: #eee;">
						    </c:if>
						        <a href="#!" class="chat-link d-flex justify-content-between" data-room-uuid="${chatRoomNotification.type_uuid}">
						            <div class="d-flex flex-row">
						                <img style="width:60px ; height: 60px;" src="data:image/jpeg;base64,${chatRoomNotification.photo_base64}" alt="avatar"
						                    class="rounded-circle d-flex align-self-center me-3 shadow-1-strong" width="60">
						                <div class="pt-1">
						                    <p class="fw-bold mb-0">${chatRoomNotification.nickname}</p>
						                    <p class="small text-muted">${chatRoomNotification.last_chatting}</p>
						                </div>
						            </div>
						            <div class="pt-1 chatRoomTime">
						                <span id="timeAgo" style="color: #6c757d !important;">${chatRoomNotification.relative_time}</span>
						                <c:if test="${chatRoomNotification.notification_count != 0}">
						                    <span class="badge bg-danger float-end">${chatRoomNotification.notification_count}</span>
						                </c:if>
						            </div>
						        </a>
						    </li>
						</c:forEach>

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
		
		</c:if>
		
		  
		</section>
		<!-- 채팅방 보여주기 기능 끝 -->

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
                                <img style="width:60px;height:60px;" src="data:image/jpeg;base64,\${chat.photo_base64}" alt="avatar" class="rounded-circle d-flex align-self-start me-3 shadow-1-strong" width="60">
                                <div class="card">
                                    <div class="card-header d-flex justify-content-between p-3">
                                        <p class="fw-bold mb-0">\${chat.nickname}</p>
                                        <p class="text-muted small mb-0"><i class="far fa-clock"></i>\${chat.relative_time}</p>
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
                                <div class="card">
                                    <div class="card-header d-flex justify-content-between p-3">
                                        <p class="fw-bold mb-0">\${chat.nickname}</p>
                                        <p class="text-muted small mb-0"><i class="far fa-clock"></i>\${chat.relative_time}</p>
                                    </div>
                                    <div class="card-body">
                                        <p class="mb-0">\${chat.chat_content}</p>
                                    </div>
                                </div>
                                <img style="width:60px;height:60px;margin-left:16px;margin-right:0px;" src="data:image/jpeg;base64,\${chat.photo_base64}" alt="avatar" class="rounded-circle d-flex align-self-start me-3 shadow-1-strong" width="60">
                            </li>`;
                    }
                });

                // 입력창
                sendHtml += `
						    <form class="form-inline">       
						        <li class="bg-white mb-3" style="border-radius: 15px;">
						            <div class="form-outline" style="width: 100%; position: relative; overflow: hidden;">
						                <textarea placeholder="Message.." class="form-control" id="chat_content" rows="1" style="border-radius:12px; resize: none; line-height: 45px; border-color: #999999; max-height: 200px; overflow: hidden; line-height: 1.4; padding-top: 20px; padding-bottom: 20px;"></textarea>
						                <button type="submit" id="send" class="btn btn-info btn-rounded float-end" style="border-radius:7px; position: absolute; right: 10px; bottom: 10px; z-index: 100; background-color:#FFFFFF; border-color:#999999; width: 40px; height: 40px; padding-left: 10px;">
						                    <i style="color:#767676;" class="far fa-paper-plane"></i>
						                </button>
						            </div>
						        </li>
						    </form>
						    `;



                $('#chatting-ul').html(chattingListHtml);
                $('#send-ul').html(sendHtml);

                var chattingUl = $('#chatting-ul');
                chattingUl.scrollTop(chattingUl.prop('scrollHeight'));
                
                $('html, body').animate({
                    scrollTop: $('#send').offset().top
                }, 'fast');

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
        const chat = JSON.parse(greeting.body);
        // 필요한 데이터를 추출하여 사용
        // 예: chat.chat_uuid, chat.chat_content 등
        showGreeting(chat); // 또는 필요에 따라 다른 데이터를 사용
    });
    stompClient.subscribe('/topic/typing', (typingInfo) => {
        showTypingStatus(JSON.parse(typingInfo.body));
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
	
	const textarea = document.getElementById('chat_content');
    const text = textarea.value;
    const formattedText = text.replace(/\n/g, '<br>'); 
	
    stompClient.publish({
        destination: "/app/hello",
        body: JSON.stringify({
        	'chat_content': formattedText,
        	'room_uuid' : roomUuid,
        	'chat_chatter' : '${mvo.username}'
        })
    });
    
    /// textarea 내용 초기화
    $('#chat_content').val('');
    
}

function showGreeting(chat) {
    var htmlContent;
    
    // mvo.username과 chat.chat_chatter가 일치하는 경우
    if ('${mvo.username}' === chat.chat_chatter) {
        htmlContent = `
            <li class="d-flex justify-content-between mb-4">
            <img style="width:60px;height:60px;" src="data:image/jpeg;base64,\${chat.photo_base64}" alt="avatar" class="rounded-circle d-flex align-self-start me-3 shadow-1-strong" width="60">
            <div class="card">
                <div class="card-header d-flex justify-content-between p-3">
                    <p class="fw-bold mb-0">\${chat.nickname}</p>
                    <p class="text-muted small mb-0"><i class="far fa-clock"></i>\${chat.relative_time}</p>
                </div>
                <div class="card-body">
                    <p class="mb-0">\${chat.chat_content}</p>
                </div>
            </div>
        </li>`;
    } else {
        // mvo.username과 chat.chat_chatter가 일치하지 않는 경우
    	htmlContent = `
            <li class="d-flex justify-content-between mb-4">
            <div class="card">
                <div class="card-header d-flex justify-content-between p-3">
                    <p class="fw-bold mb-0">\${chat.nickname}</p>
                    <p class="text-muted small mb-0"><i class="far fa-clock"></i>\${chat.relative_time}</p>
                </div>
                <div class="card-body">
                    <p class="mb-0">\${chat.chat_content}</p>
                </div>
            </div>
            <img style="width:60px;height:60px;margin-left:16px;margin-right:0px;" src="data:image/jpeg;base64,\${chat.photo_base64}" alt="avatar" class="rounded-circle d-flex align-self-start me-3 shadow-1-strong" width="60">
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



// 타이핑 중이라면 상대방에게 입력중이라고 메시지 보내기
var isTyping = false;

$(document).on('input', '#chat_content', function() {
    var currentStatus = $(this).val().length > 0;
    if (currentStatus !== isTyping) {
        isTyping = currentStatus;
        sendTypingStatus(isTyping);
    }
});

function sendTypingStatus(typing) {
    stompClient.publish({
        destination: "/app/typing",
        body: JSON.stringify({ username: '${mvo.username}', isTyping: typing })
    });
}

function showTypingStatus(typingInfo) {
    if (typingInfo.isTyping) {
        // 사용자가 입력 중인 경우 UI에 표시 (예: "사용자가 입력 중입니다" 메시지 추가)
        console.log('사용자가 입력중입니다.');
    } else {
        // 사용자가 입력을 중단한 경우 UI에서 해당 메시지 제거
    	console.log('사용자가 입력중이 아닙니다.');
    }
}

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

/****************************
	[textarea 글 쓰고 Enter 누르면 글 보내기]
	[shift+enter 누르면 줄바꿈함] 
*****************************/
$(document).on('keydown', '#chat_content', function(e) {
    if (e.key === 'Enter' && !e.shiftKey) {
        e.preventDefault();
        sendName();
    } else if (e.key === 'Enter' && e.shiftKey) {
        // Enter만 눌렀을 때 (Shift + Enter는 제외)
    	setTimeout(adjustHeight.bind(this), 0); 
        
    }
});

function adjustHeight() {
    this.style.height = 'auto';
    this.style.height = this.scrollHeight + 'px';
  }

$(document).on('input', '#chat_content', adjustHeight); // 입력할 때마다 크기 조절


</script>
    
</body>

</html>

