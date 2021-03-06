<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%-- JSTL CDN --%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>나에게 딱 맞는 SUITED</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3"
	crossorigin="anonymous">
<!-- 부트스트랩 CDN -->

<script src="https://code.jquery.com/jquery-3.6.0.js"
	integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk="
	crossorigin="anonymous"></script>
<!-- jquery CDN-->
<style>
@import
	url('https://fonts.googleapis.com/css2?family=Do+Hyeon&display=swap');
</style>
<!-- 배달의민족 도현 글꼴 -->

<style>
* {
	box-sizing: border-box;
	font-family: 'Do Hyeon', sans-serif;
}

html {
	width: 100vw;
	height: 100%;
}

body {
	width: 1024pw;
	height: 100%;
}

a {
	text-decoration: none;
	color: black;
}

/* Navi 영역*/
.navber {
	width: 82.6vw;
	margin: auto;
	padding-top: 30px;
	padding-bottom: 30px;
	background-color: white;
	position: fixed;
	left: 50%;
	transform: translateX(-50%);
	z-index: 1;
}

.nav-items {
	margin: auto;
	width: 100%;
}

.nav-items>div {
	padding: 0px 10px;
}

a:hover {
	text-decoration: none;
	color: green;
	border-bottom: 2px solid green;
}

.navi-logo {
	text-align: left;
}

.navi-menu {
	text-align: center;
}

.navi-cart {
	text-align: right;
}

.navi-onButtons {
	padding-top: 92px;
	margin: auto;
	width: 82.6vw;
	height: 0;
	display: none;
}

.navi-onButtons>div {
	padding: 10px 0px;
	text-align: center;
}

.badge {
	height: 16px;
	line-height: 8px;
}

/* main 영역 */
.main {
	padding-top: 112px;
	width: 82.6vw;
	margin: auto;
	text-align: center;
}

/* footer 영역 */
.footer {
	margin: auto;
	width: 82.6vw;
}

.footer-top {
	margin: auto;
	width: 82.6vw;
}

.footer-top>ul {
	padding: 20px 0px;
	margin: 0px;
	border-bottom: 2px solid gray;
}

.footer-top>ul>li {
	list-style: none;
	float: left;
	margin-right: 10px;
}

.footer-body {
	margin: auto;
	width: 82.6vw;
	border-bottom: 2px solid gray;
	padding-bottom: 20px;
}

.footer-body-left {
	margin-top: 20px;
	padding: 0px;
}

.footer-body-left>p {
	padding: 0px;
	margin: 0px;
}

.footer-body-right {
	margin-top: 20px;
	padding: 0px;
}

.footer-body-right>p {
	padding: 0px;
	margin: 0px;
}
</style>
</head>
<body>
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
		<div class="row">
			<div class="col-12">
				<h1 class="mt-3">장바구니</h1>
			</div>
		</div>
		<div class="empty">
			<div class="row">
				<p>장바구니에 추가된 제품이 없습니다.</p>
				<p>
					몇가지 건강설문을 통해<br> 나만을 위한 영양성분을 찾아보세요.
				</p>
			</div>
			<button type="button" class="btn btn-dark" id="btn_survey">영양제
				추천받기</button>
		</div>
		<div class="added">
			<div class="row">
				<div class="col">
					<table class="table table-bordered">
						<thead>
							<tr>
								<th class="col-5">제품 이미지</th>
								<th class="col-2">제품명</th>
								<th class="col-1">제품 금액</th>
								<th class="col-1">합계</th>
								<th class="col-2">수량</th>
								<th class="col-1"></th>
							</tr>
						</thead>
						<tbody id="listDiv">
							
						</tbody>
					</table>
				</div>
			</div>
			<div class="totalPrice">
				
			</div>
			<div class="row">
			     <div class="col">
			          <button type="button" class="btn btn-dark" id="btn_toPay">주문하기</button>
			     </div>
			</div>
		</div>
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
		$(function() {
			getCartCount();
			getCartList();
			let loginSession = "${loginSession}";

			if (loginSession == '') {
				alert("로그인 후 이용해주세요.");
				location.href = "/member/login.jsp";
			}

			let onNavbar = 0; // 네비 햄버거버튼 클릭했는지 아닌지 알기위한 변수
			$('#btn_navi_menu').on('click', function() { //햄버거버튼 클릭 시
				if (onNavbar == 0) {
					$('.navi-onButtons').css({
						"height" : "auto",
						"display" : "block"
					}); // 세로 네비영역 열기
					onNavbar = 1;
					$('html, body').animate({
						scrollTop : 0
					}, 100);
					return false;
				} else {
					$('.navi-onButtons').css({
						"height" : "0",
						"display" : "none"
					}); //세로 네비영역 닫기
					onNavbar = 0;
				}
			});

			$(window).resize(function() { //브라우저 크기를 조정했을때
				if (window.innerWidth > 1199) { //브라우저 크기가 1199를 넘었다면
					$('.navi-onButtons').css({
						"height" : "0",
						"display" : "none"
					}); //세로 네비영역 닫기
					onNavbar = 0;
				}
			});
			
			//결제하러가기 버튼
			$('#btn_toPay').on('click',function(){
				location.href="${pageContext.request.contextPath}/toOrder.order";
			})
			
			// 장바구니 수량
			function getCartCount(){
				$.ajax({
					type : "get"
					, url : "${pageContext.request.contextPath}/countCartProc.cart"
				}).done(function(rs){
					if(rs != "fail"){
						$('#cartCount').html(rs);
						if(rs > 0){
							$('.empty').css({"display" : "none"});
						}else if (rs == 0){
							$('.added').css({"display" : "none"});
						}
					} else {
						alert("오류");
					}
				}).fail(function(e){
					console.log(e);
				})
			}
			
			// 장바구니 목록 불러오기
			function getCartList(){
				$.ajax({
					type : "post"
					, url : "${pageContext.request.contextPath}/getCartProc.cart"
					, dataType : "json"
				}).done(function(data){
					$('#listDiv').empty();
					$('.totalPrice').empty();
					let total = 0;
					
					for(let dto of data){
 						let list = "<tr>"
						+ "<td><img alt=''"
						+ "src='${pageContext.request.contextPath}/product_img/" + dto.img_system_name + "'"
						+ "width='150px' height='150px'></td>"
						+ "<td>" + dto.product_name + "</td>"
						+ "<td>" + dto.price + "</td>"
						+ "<td>" + dto.price * dto.quantity + "</td>"
						+ "<td>"
						+ "<button type='button' class='quantityBtn' value='" + dto.quantity + "'id='" + dto.product_code + "-'>-</button>"
						+ "<span> " + dto.quantity + " </span>"
						+ "<button type='button' class='quantityBtn' value='" + dto.quantity + "'id='" + dto.product_code + "!'>+</button>"
						+ "</td>"
						+ "<td>"
						+ "<button type='button' class='btn btn-deleteCart' value='"+ dto.product_code +"'>삭제</button>"
						+ "</td>"
						+ "</tr>";
						
						total += dto.price * dto.quantity;
						$("#listDiv").append(list);
					}
					let totalPrice = "<div class='col'>"
					+ "<p>총 결제 금액 : " + total + "</p>"
					+ "</div>"
					$('.totalPrice').append(totalPrice);
				}).fail(function(e){
					console.log(e);
				})
			}
			
			// +,- 버튼
			$(document).on('click', '.quantityBtn', function(e){
// 				console.log(e.target.id);
				$.ajax({
					url : "${pageContext.request.contextPath}/getQuantity.cart?btnId=" + e.target.id + "&quantity=" + $(e.target).val()
					, type : 'get'
				}).done(function(rs){
				    if(rs == "success"){
				    	getCartList();
				    }else if(rs == "fail"){
				    	alert("수량 조절 실패");
				    }
				}).fail(function(e){
					console.log(e);
				})
			})
			
			// 장바구니 목록 삭제
			$(document).on("click", ".btn-deleteCart", function(e){
				$.ajax({
					url : "${pageContext.request.contextPath}/deleteProc.cart?product_code=" + $(e.target).val()
					, type : 'get'
				}).done(function(rs){
					if(rs == "success"){
						getCartCount();
						getCartList();
					}else if(rs == "fail"){
						alert("장바구니 목록 삭제에 실패했습니다.");
					}
				}).fail(function(e){
					console.log(e);
				})
			})
		});
	</script>
</body>
</html>