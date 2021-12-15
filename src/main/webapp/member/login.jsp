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
	width:100%;
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
.badge{
height:16px;
line-height:8px;
}

/* main 영역 */
.main {
	padding-top: 92px;
	width: 40vw;
	margin: auto;
	text-align: center;
}

#btn_login {
	width: 100%;
}

#btn_signup {
	width: 100%;
	background-color: rgb(248, 203, 53);
	color: black;
}

#link_signup {
	text-align: left;
}

#link_find {
	text-align: right;
}

#kakao_login {
	width: 100%;
	height: 38px;
	background-color: #fee819;
	border: 0px;
	border-radius: 5px;
	color: black
}

.alert {
	width: 100%;
	height: 38px;
	padding: 0px;
	border: 0px;
	border-radius: 5px;
	color: black
}

.alert>p {
	height: 100%;
	margin: auto;
	padding: 0px;
}
#result{
	transition-duration:1s;
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
				<div class="col-xl-3 col-5 navi-menu"></div>
				</c:when>
				<c:when test="${!empty loginSession}">
					<div class="col-xl-2 col-5 navi-menu"></div>
				</c:when>
			</c:choose>
			
			<div class="col-xl-1 d-none d-xl-block navi-menu">
				<a href="#">영양제추천</a>
			</div>
			<div class="col-xl-1 d-none d-xl-block navi-menu">
				<a href="${pageContext.request.contextPath }/toProduct.pro?currentPage=1">제품보기</a>
			</div>
			<div class="col-xl-1 d-none d-xl-block navi-menu">
				<a href="#">고객리뷰</a>
			</div>
			<div class="col-xl-1 d-none d-xl-block navi-menu">
				<a href="#">스토리</a>
			</div>
			<div class="col-xl-1 d-none d-xl-block navi-menu">
				<a href="${pageContext.request.contextPath }/toInquiry.in?currentPage=1">고객센터</a>
			</div>
			<c:choose>
				<c:when test="${empty loginSession}">
				</c:when>
				<c:when test="${!empty loginSession}">
					<div class="col-xl-1 d-none d-xl-block navi-menu">
						<a href="#">${loginSession.nickname} 님</a>
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
				<a href="${pageContext.request.contextPath}/tocart.cart">cart <span class="badge bg-dark rounded-pill">0</span></a>
			</div>
			<div class="col-xl-0 col-2 d-xl-none navi-menu">
				<a id="btn_navi_menu"><img src="../imgs/menu.png" width="20px"
					height="24px"></a>
			</div>
		</div>
	</nav>
	<div class="row navi-onButtons">
		<div class="col-12">
			<a href="#">영양제추천</a>
		</div>
		<div class="col-12">
			<a href="${pageContext.request.contextPath }/toProduct.pro?currentPage=1">제품보기</a>
		</div>
		<div class="col-12">
			<a href="#">고객리뷰</a>
		</div>
		<div class="col-12">
			<a href="${pageContext.request.contextPath }/toInquiry.in?currentPage=1">고객센터</a>
		</div>
		<c:choose>
			<c:when test="${empty loginSession}">
			</c:when>
			<c:when test="${!empty loginSession}">
				<div class="col-12">
			<a href="${pageContext.request.contextPath }/toMypage">${loginSession.nickname} 님</a>
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
		<form
			method="post" id="loginForm">
			<h1 class="mt-3">로그인</h1>
			<input type="text" class="form-control mt-3" id="id" name="id"
				placeholder="아이디"> <input type="password"
				class="form-control mt-3" id="password" name="password"
				placeholder="패스워드">
			<div class="row">
				<div class="col-6" id="link_signup">
					<a href="${pageContext.request.contextPath }/toSignup.mem?kakao_value=0">회원가입</a>
				</div>
				<div class="col-6" id="link_find">
					<a href="">아이디 / 비밀번호 찾기</a>
				</div>
			</div>
			<div class="row d-none">
				<input type="text" name="kakao_value" value="0">
			</div>
			<div class="row">
				<div class="col-12">
					<button type="button" class="btn btn-dark" id="btn_login">로그인</button>
				</div>
				<div class="col-12">
					<button type="button" class="mt-3" id="kakao_login">카카오
						로그인</button>
				</div>
			</div>
			<div class="row">
				<div class="col-12" id="result">
				
				</div>
			</div>
<%-- 			<c:if test="${rs eq 'fail'}"> --%>
<!-- 				<button type="button" class="alert alert-dark mt-3" disabled>아이디 또는 -->
<!-- 					비밀번호가 일치하지 않습니다.</button> -->
<%-- 			</c:if> --%>
<%-- 			<c:if test="${rs eq 'signSuccess'}"> --%>
<!-- 				<button type="button" class="alert alert-success mt-3" disabled>회원가입에 성공하였습니다. 이메일을 확인해주세요.</button> -->
<%-- 			</c:if> --%>
<%-- 			<c:if test="${rs eq 'signFail'}"> --%>
<!-- 				<button type="button" class="alert alert-danger mt-3" disabled>회원가입에 실패하였습니다.</button> -->
<%-- 			</c:if> --%>
<%-- 			<c:if test="${rs eq 'emailSuccess'}"> --%>
<!-- 				<button type="button" class="alert alert-success mt-3" disabled>이메일 인증에 성공했습니다.</button> -->
<%-- 			</c:if> --%>
<%-- 			<c:if test="${rs eq 'emailFail'}"> --%>
<!-- 				<button type="button" class="alert alert-danger mt-3" disabled>이메일 인증에 실패했습니다.</button> -->
<%-- 			</c:if> --%>
<%-- 			<c:if test="${rs eq 'emailIncomplete'}"> --%>
<!-- 				<button type="button" class="alert alert-danger mt-3" disabled>이메일 인증이 완료되지 않았습니다.</button> -->
<%-- 			</c:if> --%>
			
		</form>
		<form action="${pageContext.request.contextPath}/toSignup.mem"
			method="post" class="d-none" id="kakaoForm">
			<input type="text" id="kakao_value" name="kakao_value" value="0">
			<input type="text" id="kakao_id" name="kakao_id">
			<input type="text" id="gender" name="gender">
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
	<script src = "https://developers.kakao.com/sdk/js/kakao.min.js"></script>
	<script>
		$(function() {
			let rs = "${rs}";
			if(rs!=null){
				if(rs=='signSuccess'){
					$('#result').empty();
	 				let loginResult = "<button type='button' class='alert alert-success mt-3' disabled>회원가입이 완료되었습니다.</button>";
					$('#result').append(loginResult);
	 				setTimeout(resultEmpty, 5000);
				}else if(rs == 'emailSuccess'){
					$('#result').empty();
	 				let loginResult = "<button type='button' class='alert alert-success mt-3' disabled>이메일 인증에 성공하였습니다.</button>";
					$('#result').append(loginResult);
	 				setTimeout(resultEmpty, 5000);
				}else if(rs == 'emailFail'){
					$('#result').empty();
	 				let loginResult = "<button type='button' class='alert alert-danger mt-3' disabled>이메일 인증에 실패하였습니다.</button>";
					$('#result').append(loginResult);
	 				setTimeout(resultEmpty, 5000);
				}
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
			
			Kakao.init('40f2b5b7058ed045a9aa804d45255e9b');
			
			$('#kakao_login')
					.on(
							'click',
							function() {
								Kakao.Auth.login({
							        success: function(authObj) {
							          //2. 로그인 성공시, API 호출
							          Kakao.API.request({
							            url: '/v2/user/me',
							            data: {
									        property_keys: ["kakao_account.email","kakao_account.gender"]
									    },
							            success: function(response) {
							              $('#kakao_value').val(response.id);
							              $('#kakao_id').val(response.kakao_account.email);
							              $('#gender').val(response.kakao_account.gender);
										  scope : 'account_email,gender';
							              
							             console.log($('#kakao_value').val() + " : " + $('#kakao_id').val() + " : " + $('#gender').val());
							             $('#kakaoForm').submit();
							              
							        }
							          })
							          console.log(authObj);
							          var token = authObj.access_token;
							        },
							        fail: function(err) {
							          alert(JSON.stringify(err));
							        }
							      });			
							});

			$('#btn_login').on('click', function() {
				if (($('#id').val() == "") || ($('#password').val() == "")) {
					alert("아이디 혹은 비밀번호를 입력해주세요.");
					return;
				} else {
					let loginForm = $('#loginForm').serialize();
					login(loginForm);
				}
			});
			function resultEmpty(){
				$('#result').empty();
			};
			function login(loginForm){
				$.ajax({
					type:"post",
					url:"${pageContext.request.contextPath}/loginProc.mem",
					data:loginForm,
					dataType:"text"
				}).done(function(data){
					console.log(data);
					if(data == 'loginSuccess'){
						location.href="/";
					}else if(data == 'loginFail'){
						$('#result').empty();
		 				let loginResult = "<button type='button' class='alert alert-dark mt-3' disabled>아이디 또는 비밀번호가 일치하지 않습니다.</button>";
						$('#result').append(loginResult);
		 				setTimeout(resultEmpty, 5000);
					}
					else if(data =='emailFail'){
						$('#result').empty();
		 				let loginResult = "<button type='button' class='alert alert-danger mt-3' disabled>이메일 인증이 완료되지 않았습니다.</button>";
						$('#result').append(loginResult);
		 				setTimeout(resultEmpty, 5000);
					}
					else if(data == 'admin'){
						$('#result').empty();
		 				let loginResult = "<button type='button' class='alert alert-danger mt-3' disabled>관리자로 로그인해주세요.</button>";
						$('#result').append(loginResult);
		 				setTimeout(resultEmpty, 5000);
		 				location.href = "/admin/login.jsp";
					}
				}).fail(function(data){
					console.log(data);
				});
			}
			
		});
	</script>
</body>
</html>