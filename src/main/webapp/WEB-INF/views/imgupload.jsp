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

#uploadButton {
   background-color: pink;
   color: white;
   padding: 10px 20px;
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
  border: 1px solid #ccc;
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

</style>
</head>
<body>
 <div class="container-xxl bg-white p-0"> 
	<div class="cards-list">
      <jsp:include page="header.jsp"></jsp:include>
      <!-- Navbar End -->
      

      <!-- Header Start -->
      <br> <br>
      <div class="container">
         <div class="row">
            <div class="col-12 text-center">
               <h2>사진 업로드</h2>
               <br> <br> <br> <br>
               <div class="card">
                  <div class="card-body mt-3" >
                     <div class="row">
                     <!-- 사진 업로드  -->
                     <c:forEach items="${fileNames}" var="fileName" varStatus="i" >    
                        <div class="responsive">
                           <div class="gallery"> 
                           <img src="${fileName}" alt="Admin" class="rounded" width="150">
                                 <form action="${cpath}/fileUpload" method="post" enctype="multipart/form-data" id="imageForm${i.count}" >                                    
                                    <input type="file" id="photo${i.count}" name="file" accept="image/*">
                                    <input type ="hidden" id="photoNum" name="photoNum" value="${i.count}">
                                    <button type="submit" id="uploadButton${i.count}">업로드</button>
                                 </form>   
                              </div>
                           </div>               
                     </c:forEach>
                     </div>
                     <br> <br> <br>                     
                  </div>
                  <div>
                     
                  </div>
                  <!-- div 컨테이너  -->
                  <!-- 정보 입력 끝!!!!!!!!!!!!!!!!!!!!!!!!  -->
                  <br> <br> <br>
                  <!-- Header End -->


                  <!-- Back to Top -->
                  <a href="#"
                     class="btn btn-lg btn-primary btn-lg-square back-to-top"><i
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
                  function checkFormAndSubmit() {
                     checkForm();

                     var isSubmitEnabled = !document
                           .getElementById("submitBtn").disabled;

                     if (isSubmitEnabled) {
                        // 이동할 페이지의 URL을 여기에 입력해줘
                        window.location.href = "index";
                     }
                  }

                  function checkForm() {
                     var age = document.getElementById("age").value;
                     var phone = document.getElementById("phone").value;
                     var address = document.getElementById("address").value;
                     var interest = document.getElementById("interest").value;
                     var mbti = document.getElementById("mbti").value;
                     var sport = document.getElementById("sport").options[document
                           .getElementById("sport").selectedIndex].value;
                     var smoking = document.getElementById("smoking").options[document
                           .getElementById("smoking").selectedIndex].value;
                     var drinking = document.getElementById("drinking").options[document
                           .getElementById("drinking").selectedIndex].value;
                     var job = document.getElementById("job").value;
                     var school = document.getElementById("school").value;
                     var role = document.getElementById("role").options[document
                           .getElementById("role").selectedIndex].value;
                     var aboutme = document.getElementById("aboutme").value;

                     if (age && phone && address && interest && mbti
                           && sport !== "none" && smoking && drinking
                           && job && school && role !== "none"
                           && aboutme) {
                        document.getElementById("submitBtn").disabled = false;
                     } else {
                        document.getElementById("submitBtn").disabled = true;
                     }
                  }

                  function uploadImage() {
                     var input = document.getElementById('photo');
                     var file = fileInput.files[0];

                     //선택된 파일이 존재하면 FormData객체 생성 후, 해당 객체에 파일 추가
                     if (file) {
                        var formData = new FormData(document
                              .getElementById('infoForm'));
                        formData.append('file', file);
                        // 여기에서 서버로 Ajax 요청을 보내거나, form.submit()을 사용하여 제출할 수 있습니다.
                        // 예를 들어, jQuery를 사용하여 Ajax 요청을 보내는 경우
                        $.ajax({
                           type : "post",
                           url : '${cpath}/info',
                           data : formData,
                           processData : false, // FormData를 직렬화
                           contentType : false, //컨텐츠 타입 설정 X
                           success : function(response) {
                              // 성공 시 동작
                              alert("Success");
                           },
                           error : function(error) {
                              // 에러 시 동작
                              alert("Error");
                           }
                        });
                     } else {
                        alert("Please select a file.")
                     }
                  }
               </script>
</body>
</html>