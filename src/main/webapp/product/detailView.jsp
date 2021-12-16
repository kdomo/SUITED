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
	width: 100%;
	height: auto;
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

/* header */
.header {
	padding-top: 92px;
	margin: auto;
	width: 82.6vw;
	position: relative;
}

#btn_survey {
	position: absolute;
	top: 80%;
	left: 50%;
	transform: translate(-50%, -50%);
}

/* main 영역 */
.main {
 padding-top: 112px;
   width: 40vw;
   margin: auto;
}

.card {
	border-radius: 10%;
	margin: auto;
	margin-bottom: 20px;
	border: 2px solid gray;
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
/* .col { */
/* 	border: 0.5px solid gray; */
/* } */

/* .btn-container { */
/* 	padding-top: 10px; */
/* 	text-align: center; */
/* } */

/* .cmt-container { */
/* 	padding-top: 20px; */
/* } */

/* textarea { */
/* 	resize: none; */
/* } */

/* img{ */
/*     text-aling: center; */
/*     width:300px; */
/*     height:300px; */
/* } */
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
	
	<div class="container">
		<div class="row">
			<div class="col">
				<h2>${dto.getProduct_name()}</h2>
			</div>
			<div class="col">
				<div>${dto.getPrice()}원</div>
			</div>
		</div>
		<div class="row">
			<div class="col">	
			    <img alt="" src="${pageContext.request.contextPath}/product_img/${dto.getImg_system_name()}" width="300px;" height="300px;">
			</div>
			<div class="col">상품 간단 설명 : ${dto.getSimple_content()}</div>
		</div>
		<div class="row">
			<div class="col">상품 상세 설명 : ${dto.getMain_content()}</div>
		</div>
	</div>
	<div class="container cmt-container">
		<div class="cmt-showBox">
		</div>
		<div class="row">
			<nav class="col" aria-label="Page navigation example">
				<ul class="pagination justify-content-center">
					<c:if test="${naviMap_cmt.get('needPrev') eq true}">
						<li class="page-item"><a class="page-link"
							href="${pageContext.request.contextPath}/toDetailView.pro?product_code=${dto.getProduct_code()}&currentPage=${currentPage}&currentPage_cmt=${naviMap_cmt.get('startNavi')-1}">Previous</a>
					</c:if>
					<c:forEach var="i" begin="${naviMap_cmt.get('startNavi')}"
						end="${naviMap_cmt.get('endNavi')}">
						<li class="page-item"><a class="page-link"
							href="${pageContext.request.contextPath}/toDetailView.pro?product_code=${dto.getProduct_code()}&currentPage=${currentPage}&currentPage_cmt=${i}">${i}</a></li>
					</c:forEach>
					<c:if test="${naviMap_cmt.get('needNext') eq true}">
						<li class="page-item"><a class="page-link"
							href="${pageContext.request.contextPath}/toDetailView.pro?product_code=${dto.getProduct_code()}&currentPage=${currentPage}&currentPage_cmt=${naviMap_cmt.get('endNavi')+1}">Next</a></li>
					</c:if>
				</ul>
			</nav>
		</div>
		
		<div class="cmt-inputBox">
			<form id="cmtForm" method="post">
				<div class="row">
					<div class="col-12 col-xl-10">
						<input type="text" id="comment" name="comment" placeholder="리뷰 입력"
							style="width: 100%">
					</div>
					<div class="col-12 col-xl-2">
						<button type="button" id="btnSubmitCmt" class="btn btn-dark">등록</button>
					</div>
				</div>
				<input type="text" name="product_code"
					value="${dto.getProduct_code()}" hidden>
				<input type="text" name="currentPage" value="${currentPage}" hidden>
			</form>
		</div>
	</div>
	<div class="row">
		<div class="col-12">
		<button type="button" class="btn btn-secondary" id="toProductBtn">상품
			목록</button>
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
			let admin_yn = "${loginSession.get('admin_yn')}";
			if(admin_yn=='1'){
				location.href="/toAdminIndex.admin";
			}
			
			if("${loginSession}" != ''){
				getCartCount();
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
			
			$('#btn_survey').on('click',function(){
				location.href="${pageContext.request.contextPath }/toSurvey.srv";
			})
		
			function getCartCount(){
				$.ajax({
					type : "get"
					, url : "${pageContext.request.contextPath}/countCartProc.cart"
				}).done(function(rs){
					if(rs != "fail"){
						$('#cartCount').html(rs);
					} else {
						alert("오류");
					}
				}).fail(function(e){
					console.log(e);
				})
			}
		});
	</script>
	<script>
	$(document).ready(function(){
		getCommentList();
	})
	// 리뷰 등록
	$("#btnSubmitCmt").on("click", function(){
		let data = $("#cmtForm").serialize();
		console.log(data);
		$("#comment").val("");
		
		$.ajax({
			url : "${pageContext.request.contextPath}/insertProc.co"
			, type : 'post'
			, data : data
		}).done(function(rs){
			if(rs == "success"){
				getCommentList();
			}else if(rs == "fail"){
				alert("리뷰 등록에 실패했습니다.");
			}
		}).fail(function(e){
			console.log(e);
		})
	})
	// 리뷰 삭제
	$(document).on("click", ".btn-deleteCmt", function(e){
		$.ajax({
			url : "${pageContext.request.contextPath}/deleteProc.co?seq_review=" + $(e.target).val()
			, type : 'get'
		}).done(function(rs){
			if(rs == "success"){
				getCommentList();
			}else if(rs == "fail"){
				alert("리뷰 삭제에 실패했습니다.");
			}
		}).fail(function(e){
			console.log(e);
		})
	})
	
	function getCommentList(){
		// ajax 통해 리뷰 불러오기
		$.ajax({
			type : "get"
			, url : "${pageContext.request.contextPath}/getCommentProc.co?product_code=${dto.getProduct_code()}&currentPage_cmt=${naviMap_cmt.get('currentPage_cmt')}"
			, dataType : "json"
		}).done(function(data){
			$(".cmt-showBox").empty();
			
			for(let dto of data){
				let comment = "<div class='row comment-header m-1'>"
				+ "<div class='row'>"
				+ "<div calss='col d-flex justify-content-start cmt-info'>" + dto.nickname + "</div>"
				+ "</div>"
				+ "<div class='row'>"
				+ "<div class='col d-flex justify-content-start cmt-info'>" + dto.written_comment_date + "</div>"
				+ "</div>"
				+ "<div class='row'>"
				+ "<div class='col-10 d-flex justify-content-start contentDiv-cmt'>"
				+ "<textarea class='form-control' name='comment' readonly style='resize:none;'>"
				+ dto.content
				+ "</textarea>"
				+ "</div>"
				+ "</div>"
				+ "</div>"
				// 댓글 동적 요소 추가
				$(".cmt-showBox").append(comment);
				
				// 삭제 버튼 영역
				if("${loginSession.get('id')}" == dto.id){
					let btns = "<div class='col-1 d-flex justify-content-center'>"
					    + "<button type='button' class='btn btn-deleteCmt' value='" + dto.seq_review + "'>삭제</button>"
					    + "</div>";
					    
					    $(".contentDiv-cmt:last").after(btns);
				}
			}
		}).fail(function(e){
			console.log(e);
		})
	}
	
	// 상품 목록 페이지 이동
		document.getElementById("toProductBtn").onclick = function() {
			location.href = "${pageContext.request.contextPath}/toProduct.pro?currentPage=1";
		}
	</script>
</body>
</html>