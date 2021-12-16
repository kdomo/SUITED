<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css"
	integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm"
	crossorigin="anonymous">
<script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
<title>상품 등록</title>
<style>

.container {
	text-align: center;
}
textarea{
    width: 800px;
    height: 500px;
    resize: none;
}
.row{padding : 20px;}
</style>
</head>
<body>
<c:if test="${product_code eq '있음'}">
    <script>
        alert("이미 존재하는 상품 코드입니다.");
    </script>
</c:if>
<nav class="navber">
		<div class="row nav-items d-flex justify-content-center">
			<div class="col-2 col-xl-2 navi-logo">
				<a href="${pageContext.request.contextPath }/"><img
					src="../imgs/logo.png" width="80px"></a>
			</div>
			<c:choose>
				<c:when test="${empty loginSession}">
				<div class="col-xl-4 col-5 navi-menu"></div>
				</c:when>
				<c:when test="${!empty loginSession}">
					<div class="col-xl-3 col-5 navi-menu"></div>
				</c:when>
			</c:choose>
			
			<div class="col-xl-1 d-none d-xl-block navi-menu">
				<a href="${pageContext.request.contextPath }/toSurvey.srv">영양제추천</a>
			</div>
			<div class="col-xl-1 d-none d-xl-block navi-menu">
				<a href="${pageContext.request.contextPath }/toProduct.pro?currentPage=1">제품보기</a>
			</div>
			<div class="col-xl-1 d-none d-xl-block navi-menu">
				<a href="${pageContext.request.contextPath}/toAllReview.co">고객리뷰</a>
			</div>
			<div class="col-xl-1 d-none d-xl-block navi-menu">
				<a href="${pageContext.request.contextPath}/toInquiry.in?currentPage=1">고객센터</a>
			</div>
			<c:choose>
				<c:when test="${empty loginSession}">
				</c:when>
				<c:when test="${!empty loginSession}">
					<div class="col-xl-1 d-none d-xl-block navi-menu">
						<a href="${pageContext.request.contextPath }/toMypageConfirm.mem">${loginSession.nickname} 님</a>
					</div>
				</c:when>
			</c:choose>

			<c:choose>
				<c:when test="${empty loginSession}">
					<div class="col-xl-1 d-none d-xl-block navi-menu">
						<a href="${pageContext.request.contextPath }/toLogin.mem">로그인</a>
					</div>
				</c:when>
				<c:when test="${!empty loginSession}">
					<div class="col-xl-1 d-none d-xl-block navi-menu">
						<a href="${pageContext.request.contextPath }/logoutProc.mem">로그아웃</a>
					</div>
				</c:when>
			</c:choose>
			<div class="col-xl-1 col-3 navi-cart">
				<a href="${pageContext.request.contextPath}/tocart.cart">cart <span id="cartCount" class="badge bg-dark rounded-pill"></span></a>
			</div>
			<div class="col-xl-0 col-2 d-xl-none navi-menu">
				<a id="btn_navi_menu"><img src="../imgs/menu.png" width="20px"
					height="24px"></a>
			</div>
		</div>
	</nav>
	<div class="row navi-onButtons">
		<div class="col-12">
			<a href="${pageContext.request.contextPath }/toSurvey.srv">영양제추천</a>
		</div>
		<div class="col-12">
			<a href="${pageContext.request.contextPath }/toProduct.pro?currentPage=1">제품보기</a>
		</div>
		<div class="col-12">
			<a href="${pageContext.request.contextPath}/toAllReview.co">고객리뷰</a>
		</div>
		<div class="col-12">
			<a href="${pageContext.request.contextPath}/toInquiry.in?currentPage=1">고객센터</a>
		</div>
		<c:choose>
			<c:when test="${empty loginSession}">
			</c:when>
			<c:when test="${!empty loginSession}">
				<div class="col-12">
			<a href="${pageContext.request.contextPath }/toMypageConfirm.mem">${loginSession.nickname} 님</a>
		</div>
			</c:when>
		</c:choose>
		
		<c:choose>
			<c:when test="${empty loginSession}">
				<div class="col-12">
					<a href="${pageContext.request.contextPath }/toLogin.mem">로그인</a>
				</div>
			</c:when>
			<c:when test="${!empty loginSession}">
				<div class="col-12">
					<a href="${pageContext.request.contextPath }/logoutProc.mem">로그아웃</a>
				</div>
			</c:when>
		</c:choose>
		<div class="col-12">
			<a href="${pageContext.request.contextPath}/toInquiry.in?currentPage=1">고객센터</a>
		</div>
	</div>
	<div class="main">
	 <form action="${pageContext.request.contextPath}/registerProc.pro" method="post"
         id="productForm" name="productForm" enctype="multipart/form-data">
        <div class="container">
             <div class="row">
                  <div class="col">
                       <h2>상품 등록</h2>
                  </div>
             </div>
             <div class="row">
                  <div class="col-3">상품명</div>
                  <div class="col-9">
                      <input type="text" class="form-control" id="product_name" name="product_name">
                  </div>
             </div>
             <div class="row">
                  <div class="col-3">상품코드</div>
                  <div class="col-6">
                      <input type="text" class="form-control" id="product_code" name="product_code" readonly>
                  </div>
                  <div class="col-3">
                      <button type="button" class="btn btn-warning" id="checkPC">제품 코드 중복 확인</button>
                  </div>
             </div>
             <div class="row">
                  <div class="col-3">상품 가격</div>
                  <div class="col-9">
                      <input type="text" class="form-control" id="price" name="price">
                  </div>
             </div>
             <div class="row">
                  <div class="col-3">상품 이미지</div>
                  <div class="col-9">
                      <input type="file" id="productIMG" name="productIMG" required>
                  </div>
             </div>
             <div class="row">
                  <div class="col-3">상품 간단 설명</div>
                  <div class="col-9">
                      <textarea id="simple_content" name="simple_content"></textarea>
                  </div>
             </div>
             <div class="row">
                  <div class="col-3">상품 상세 설명</div>
                  <div class="col-9">
                      <textarea id="main_content" name="main_content"></textarea>
                  </div>
             </div>
             <div class="row">
                  <div class="col">
                      <button type="button" id="cancelBtn" class="btn btn-secondary">취소</button>
                      <button type="button" id="registerBtn" class="btn btn-primary">등록</button>
                  </div>
             </div>
        </div>
    </form>
	</div>
   <div class="footer">
		<div class="row footer-top">
			<ul>
				<li><a href="">이용약관</a></li>
				<li><a href="">개인정보처리방침</a></li>
				<li><a href="${pageContext.request.contextPath}/toInquiry.in?currentPage=1">고객센터</a></li>
			</ul>
		</div>
		<div class="row footer-body">
			<div class="col-12 col-xl-6 footer-body-left">
				<p>SUITED | 사업자번호: 000-00-00000 | 대표: ㅇㅇㅇ</p>
				<p>개인정보취급담당자: ㅇㅇㅇ</p>
				<p>통신판매업신고: 제 2021-서울강남-00000 호</p>
				<p>유통판매업신고: 제 2021-0000000 호</p>
			</div>
			<div class="col-12 col-xl-6 footer-body-right">
				<p>고객센터</p>
				<p>고객문의: cs@suited.com | 전화: 02-0000-0000</p>
				<p>상담시간: 평일 09:00~15:30 (점심시간 12:50~13:30)</p>
				<p>제휴문의: marketing@suited.com | 전화: 02-0000-0000</p>
			</div>
		</div>
		ⓒ SUITED Inc. All Rights Reserved.
	</div>
    <script>
        var fileCheck = $("#productIMG").val();
        document.getElementById("registerBtn").addEventListener("click", function(){
        	if(document.getElementById("product_code").value == "" ||
        			document.getElementById("product_name").value == "" ||
        			document.getElementById("price").value == "" ||
        			document.getElementById("simple_content").value == "" ||
        			document.getElementById("main_content").value == ""){
         		alert("비어있는 목록이 있습니다.");
         		return;
         		}
//          	} else if(!fileCheck){
//          		alert("이미지 파일이 첨부되지 않았습니다.");
//          		return;
//          	}
        	else{
         		document.getElementById("productForm").submit();
         	}
        })
        
        document.getElementById("checkPC").addEventListener("click", function(){
        	let url = "/product_codeCheckPopup.pro";
        	let name = "제품 코드 중복검사";
        	let option = "width=600, height=600, top=300";
        	
        	window.open(url, name, option);
        })
        
        document.getElementById("cancelBtn").addEventListener("click", function(){
        	location.href = "${pageContext.request.contextPath}/toProduct.pro?currentPage=1";
        })
    </script>
</body>
</html>