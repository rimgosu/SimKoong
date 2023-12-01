<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix ="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix ="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:set var="cpath" value="${pageContext.request.contextPath}" />    
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<sec:authentication property="principal" var="mvo_" />
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
    <link href="https://fonts.googleapis.com/css2?family=Heebo:wght@400;500;600&family=Inter:wght@700;800&display=swap" rel="stylesheet">
    
    <!-- Icon Font Stylesheet -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.0/css/all.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css" rel="stylesheet">
    
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
    <style>
      body{margin-top:20px;
      background-color:#f2f6fc;
      color:#69707a;
      }
      .img-account-profile {
          height: 10rem;
      }
      .rounded-circle {
          border-radius: 50% !important;
      }
      .card {
          box-shadow: 0 0.15rem 1.75rem 0 #eddae1;
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
          background-color: #fff5f9;
          border-bottom: #fff5f9;
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
      
      .form-check-input:checked {
         background-color: #ff82b2;
         border-color: #ff82b2;
      }
      
      .form-range::-webkit-slider-thumb {
        background-color: #ff82b2; /* 원하는 색상으로 변경하세요 */
      }
      
      .form-range::-moz-range-thumb {
        background-color: #ff82b2; /* 원하는 색상으로 변경하세요 */
      }
      
      .form-range::-ms-thumb {
        background-color: #ff82b2; /* 원하는 색상으로 변경하세요 */
      }
      
      .col-md-6 input:focus {
         outline: none !important; border-color: #d6a8e9; box-shadow: 0 0 10px #eddae1;
      }
      
      input:focus {
          outline: 1px solid #ced4da;
      }
      
      .col-md-12 textarea:focus {
         outline: none !important; border-color: #d6a8e9; box-shadow: 0 0 10px #eddae1;
      }      
       
    </style>
</head>
<body style="background: white;">
    <div class="container-xxl bg-white p-0">
        <jsp:include page="header.jsp"></jsp:include>
        <!-- Navbar End -->


        <!-- Header Start -->
        <br>
        <br>
         <%-- <form action ="${cpath}/update" method="post"> --%>
            <!-- <div class="container">
                <div class="row">
                    <div class="col-12 text-center">
                          <h2>Profile</h2>
                    </div>
                  </div> -->
                  <div class="container">
    <div class="main-body">
          <!-- Breadcrumb -->
<!--           <nav aria-label="breadcrumb" class="main-breadcrumb">
            <ol class="breadcrumb">
              <li class="breadcrumb-item"><a href="index.html">Home</a></li>
              <li class="breadcrumb-item"><a href="javascript:void(0)">User</a></li>
              <li class="breadcrumb-item active" aria-current="page">User Profile</li>
            </ol>
          </nav> -->
          <!-- /Breadcrumb -->
    
<div class="container-xl px-4 mt-4">
    <!-- Account page navigation-->
<!--     <nav class="nav nav-borders">
        <a class="nav-link active ms-0" href="https://www.bootdey.com/snippets/view/bs5-edit-profile-account-details" target="__blank">Profile</a>
        <a class="nav-link" href="https://www.bootdey.com/snippets/view/bs5-profile-billing-page" target="__blank">Billing</a>
        <a class="nav-link" href="https://www.bootdey.com/snippets/view/bs5-profile-security-page" target="__blank">Security</a>
        <a class="nav-link" href="https://www.bootdey.com/snippets/view/bs5-edit-notifications-page"  target="__blank">Notifications</a>
    </nav> --><!-- 
    <hr class="mt-0 mb-4"> -->
    <div class="row">
        <div class="col-xl-4">
            <!-- Profile picture card-->
            <div class="card mb-4 mb-xl-0">
                <div class="card-header">프로필</div>
                <div class="card-body text-center">
                    <!-- Profile picture image-->
                    <%-- <img class="img-account-profile rounded-circle mb-2" src="data:image/jpeg;base64,${imageDatas[0]}" alt="" > --%>
                    <img class="img-account-profile mb-2" src="data:image/jpeg;base64,${imageDatas[0]}"  alt="" style="border-radius: 10px;">
                    <!-- Profile picture help block-->
                     <h5><input class="" id="nickname" name="nickname" type="text" placeholder="Nick" value="${mvo.nickname}" style="text-align: center; border: none; border-radius: 3px; color: #444444;"></h5>
                    <%-- <a href="/location" id="photoLink"> ${mvo.address[0].replace('[','')} </a> --%>
               <c:if test="${empty mvo_session }">
                          <a href="/location" id="photoLink">현재 위치 설정</a>
                       </c:if>
                       <c:if test="${not empty mvo_session }">
                          <a href="/location" id="photoLink">${mvo_session.address[0].replace('[','')}</a>
                           <c:if test="${empty mvo_session.address}">
                              <a href="/location" id="photoLink">현재 위치 설정</a>
                          </c:if>
                      </c:if>
                    
                   
                    <!-- Profile picture upload button-->
                    <!-- <!-- <button class="btn btn-primary" type="button"></button> -->
                </div>
            </div>
         <br>

            <div class="card mb-4 mb-xl-0">
               <div class="card-header">추천 설정</div>
                <div class="card-body" style="display: flex; flex-direction: column; gap: 10px;">
                    <div class="small font-italic text-muted mb-4">
                       <form action="/filterUpdate" method="POST">
                          <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                          <label class="small mb-1" for="inputGender">성별</label>
                             <table class="">
                                <tr class="something">
                                   <td width="50%">
                                      <div class="form-check w-5"  >
                                    <c:choose>
                                        <c:when test="${filter.gender == '남성'}">
                                            <input class="form-check-input" type="radio" name="gender" id="male" value="남성" checked>
                                        </c:when>
                                        <c:otherwise>
                                            <input class="form-check-input" type="radio" name="gender" id="male" value="남성">
                                        </c:otherwise>
                                    </c:choose>
                                   <label class="form-check-label" for="flexRadioDefault1">
                                     <span>남성</span>  
                                   </label>
                                 </div>
                                 
                                   </td>
                                   
                                   <td width="50%" >
                                      <div class="form-check">
                                      <c:choose>
                                        <c:when test="${filter.gender == '여성'}">
                                            <input class="form-check-input" type="radio" name="gender" id="female" value="여성" checked>
                                        </c:when>
                                        <c:otherwise>
                                            <input class="form-check-input" type="radio" name="gender" id="female" value="여성" >
                                        </c:otherwise>
                                    </c:choose>
                                   <label class="form-check-label" for="flexRadioDefault1">
                                     <span>여성</span>
                                   </label>
                                 </div>
                                   </td>
                                </tr>
                             </table>
                             
                             
                     <label class="large mb-1" for="inputDistance"> 거리 </label> <span id="distanceRangeValue" style="float: right;">${filter.maximum_distance} km</span>
                      
                      <input name="maximum_distance" type="range" class="form-range"  id="distanceRange" min="0" value="${filter.maximum_distance}" max="500" oninput="document.getElementById('distanceRangeValue').innerHTML=this.value + ' km';">
                      
                     
                     <div class="range-slider" style="display: flex; flex-direction: column; gap: 10px;">
                        <label class="large mb-1" for="inputUsername"> 최소 연령 <span id="MinimumRangeValue" style="float: right;">${filter.age_range.get(0)} 세</span></label>

                         <input name="lower" type="range" class="form-range" id="lower" min="0" max="100" step="1" value="${filter.age_range.get(0)}">
                         <label class="large mb-1" for="inputUsername"> 최대 연령 <span id="MaximumRangeValue" style="float: right;">${filter.age_range.get(1)} 세</span></label>
                         <input name="upper" type="range" class="form-range" id="upper" min="0" max="100" style="margin-bottom: 7px;" step="1" value="${filter.age_range.get(1)}">
                         
                     </div>
                     <button id="saveChangesButton" class="btn btn-primary" style="float: right; transform: translate(0px, 24px); background-color: #ffbad5; border-color: #ffbad5;" type="submit">저장</button>
                     
                  </form>
                  <script type="text/javascript">
                     let lowerSlider = document.getElementById("lower");
                     let upperSlider = document.getElementById("upper");
                     
                     //let output = document.getElementById("MinimumRangeValue");
   
                     function updateSliderValue() {
                         if (parseInt(lowerSlider.value) > parseInt(upperSlider.value)) {
                             let temp = lowerSlider.value;
                             lowerSlider.value = upperSlider.value;
                             upperSlider.value = temp;
                         }
                         
                         document.getElementById('MinimumRangeValue').innerHTML=lowerSlider.value + " years old";
                         document.getElementById('MaximumRangeValue').innerHTML=upperSlider.value + " years old";;
   
                         //output.innerHTML = `${lowerSlider.value} ~ ${upperSlider.value}`;
                     }
   
                     lowerSlider.oninput = function() {
                         updateSliderValue();
                     };
   
                     upperSlider.oninput = function() {
                         updateSliderValue();
                     };
                     
                  
                  </script>
                    </div>
                </div>
            </div>
        </div>
         <div class="col-xl-8">
            <!-- Account details card-->
            <div class="card mb-4">
                <div class="card-header"> 계정 정보</div>
                <div class="card-body">
                    <form>
                        <!-- Form Group (username)-->
                        <%-- <div class="row gx-3 mb-3">
                           <div class="col-md-6">
                               <label class="small mb-1" for="inputUsername">닉네임</label>
                               <input class="form-control" id="inputUsername" type="text" placeholder="Enter your username" value="${mvo.nickname}">
                           </div>
                           <div class="col-md-6">
                                <label class="small mb-1" for="inputFirstName">성별</label>
                                <input class="form-control" id="inputFirstName" type="text" placeholder="" value="${mvo.sex}">
                            </div>
                        </div> --%>
                        <!-- Form Row-->
                        <!-- <div class="row gx-3 mb-3"> -->
                            <!-- Form Group (first name)-->
<%--                             <div class="col-md-6">
                                <label class="small mb-1" for="inputFirstName">나이</label>
                                <input class="form-control" id="inputFirstName" name="age" type="number" placeholder="" value="${mvo.age}">
                            </div>
                            <!-- Form Group (last name)-->
                            <div class="col-md-6">
                                <label class="small mb-1" for="inputOrgName">주소</label>
                                <input class="form-control" id="inputOrgName" name="address" type="text" placeholder="" value="${mvo.address.get(0)}">
                            </div>
                        </div> --%>
                        <!-- Form Row        -->
                        <div class="row gx-3 mb-3">
                            <!-- Form Group (organization name)-->
                            <div class="col-md-6">
                                <label class="small mb-1" for="inputFirstName">나이</label>
                                <input class="form-control" id="inputFirstName" name="age" type="number" placeholder="" value="${mvo.age}" style="background-color: white;" readonly="readonly">
                            </div>
                            <div class="col-md-6">
                                <label class="small mb-1" for="inputFirstName">성별</label>
                                <input class="form-control" id="inputFirstName" type="text" placeholder="" value="${mvo.sex}" style="background-color: white;" readonly="readonly">
                            </div>
                        </div>
                            <!-- Form Group (location)-->
                        <div class="row gx-3 mb-3">    
                            <div class="col-md-6">
                                <label class="small mb-1" for="inputLastName">전화번호</label>
                                <input class="form-control" id="inputLastName" name="phone" type="tel" placeholder="" value="${mvo.phone}" style="background-color: white;" readonly="readonly">
                            </div>
                            <div class="col-md-6">
                                <label class="small mb-1" for="inputLocation">관심사</label>
                                <input class="form-control" id="inputLocation" name="interest" type="text" placeholder="" value="${mvo.interest}" style="background-color: white;" readonly="readonly">
                            </div>
                        </div>
                        <!-- Form Group (email address)-->
                        <div class="row gx-3 mb-3">
                           <div class="col-md-6">
                               <label class="small mb-1" for="inputEmailAddress">MBTI</label>
                               <input class="form-control" id="inputEmailAddress" name="mbti" type="text" placeholder="" value="${mvo.mbti}" style="background-color: white;" readonly="readonly">
                           </div>
                            <div class="col-md-6">
                                <label class="small mb-1" for="inputPhone">학력</label>
                                <input class="form-control" id="inputPhone" name="school" type="text" placeholder="" value="${mvo.school}" style="background-color: white;" readonly="readonly">
                            </div>
                        </div>
                        
                        <!-- Form Row-->
                        <div class="row gx-3 mb-3">
                            <!-- Form Group (phone number)-->
                            <div class="col-md-6">
                                <label class="small mb-1" for="inputPhone">운동</label>
                                <input class="form-control" id="inputPhone" name="sport" type="text" placeholder="" value="${mvo.sport}" style="background-color: white;" readonly="readonly">
                            </div>
                            <!-- Form Group (birthday)-->
                            <div class="col-md-6">
                                <label class="small mb-1" for="inputBirthday">흡연</label>
                                <input class="form-control" id="inputBirthday" type="text" name="smoking" placeholder="" value="${mvo.smoking}" style="background-color: white;" readonly="readonly">
                            </div>
                        </div>
                        <div class="row gx-3 mb-3">
                            <!-- Form Group (phone number)-->
                            <div class="col-md-6">
                                <label class="small mb-1" for="inputPhone">음주</label>
                                <input class="form-control" id="inputPhone" type="text" placeholder="" value="${mvo.drinking}" style="background-color: white;" readonly="readonly">
                            </div>
                            <!-- Form Group (birthday)-->
                            <div class="col-md-6">
                                <label class="small mb-1" for="inputBirthday">직업</label>
                                <input class="form-control" id="inputBirthday" type="text" name="job" placeholder="" value="${mvo.job}" style="background-color: white;" readonly="readonly">
                            </div>
                        </div>
                        <div class="col-md-12">
                           <label class="small mb-1" for="inputBirthday">자기 소개</label>
                           <textarea rows="5" class="form-control" readonly="readonly" style=" background-color: white; resize: none; outline: none; width: 100%; max-width: 100%; height: auto;">${mvo.aboutme}</textarea>
                        </div>
                        <!-- Save changes button-->
                        <br>
                        <button id="saveChangesBtn" class="btn btn-primary" style="float: right; font-weight: bold; background-color: #ffbad5; border-color: #ffbad5;" type="button">수정</button>
                        
                    </form>
                    
                </div>
            </div>
        </div>
    </div>
    

</div>
</div>
        <!-- Header End -->


        <!-- Back to Top -->
        <a href="#" class="btn btn-lg btn-primary btn-lg-square back-to-top" style="background: pink; border-color: pink;"><i class="bi bi-arrow-up"></i></a>
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
    // 버튼 엘리먼트 가져오기
    var saveChangesBtn = document.getElementById('saveChangesBtn');

    // 버튼 클릭 이벤트에 대한 리스너 추가
    saveChangesBtn.addEventListener('click', function() {
        // 페이지 이동
        window.location.href = '/update';
    });
       
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