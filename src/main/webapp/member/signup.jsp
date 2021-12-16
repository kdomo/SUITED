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
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p"
	crossorigin="anonymous"></script>
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
}

body {
	width: 100%;
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
	padding-top: 92px;
	width: 40vw;
	margin: auto;
	text-align: center;
}

form>p {
	text-align: left;
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

	<!-- 메인부분 -->
	<div class="main">
		<form action="${pageContext.request.contextPath}/signupProc.mem"
			method="post" id="signupForm" name="signupForm">
			<div class="row header">
				<h1 class="col-12">회원가입</h1>
			</div>
			<div class="row d-none">
				<c:if test="${kakao_value eq 0}">
					<input type="text" class="form-control" id="kakao_value"
						name="kakao_value" value="0">
				</c:if>
				<c:if test="${kakao_value ne 0}">
					<input type="text" class="form-control" id="kakao_value"
						name="kakao_value" value="${kakao_value}">
				</c:if>
			</div>
			<div class="row">
				<div class="col-12 col-xl-8">
					<c:if test="${kakao_id eq null}">
						<input type="text" class="form-control" id="id" name="id"
							placeholder="이메일">
						<script>
							let idNull = false;
							let idRegex = false;
							let idConfirm = false;
						</script>
					</c:if>
					<c:if test="${kakao_id ne null}">
						<input type="text" class="form-control" id="id" name="id"
							placeholder="이메일" value="${kakao_id }" disabled>
						<script>
							let idNull = true;
							let idRegex = true;
							let idConfirm = true;
							$(function() {
								$('#idConfirm').html("*사용할 수 있는 이메일 입니다.");
								$('#idConfirm').css("color", "green");
								$('#id').css("border", "2px solid gray");
							})
						</script>
					</c:if>
				</div>
				<div class="col-12 col-xl-4">
					<!-- Button trigger modal -->
					<button type="button" class="btn btn-dark col-12"
						data-bs-toggle="modal" data-bs-target="#idCheck" id="btn_Id_check"
						disabled>중복확인</button>

					<!-- Modal -->
					<div class="modal fade" id="idCheck" data-bs-backdrop="static"
						data-bs-keyboard="false" tabindex="-1" aria-hidden="true">
						<div class="modal-dialog modal-dialog-centered">
							<div class="modal-content">
								<div class="modal-header">
									<h5 class="modal-title">아이디 중복확인</h5>
									<button type="button" class="btn-close" data-bs-dismiss="modal"
										aria-label="Close"></button>
								</div>
								<div class="modal-body">
									<div class="row">
										<div class="col-8">
											<input type="text" class="form-control" id="modal_id"
												name="modal_id" placeholder="이메일">
										</div>
										<div class="col-4">
											<button type="button" class="btn btn-dark col-12"
												id="modal_btn_Idcheck" disabled>중복 확인</button>
										</div>
									</div>
									<div id="idCheckModalResult">
										<img src="../imgs/loading.gif" class="mt-3" width="24px;">
									</div>
								</div>
								<div class="modal-footer d-flex justify-content-center">
									<button type="button" class="btn btn-secondary"
										data-bs-dismiss="modal">닫기</button>
									<button type="button" class="btn btn-dark" id="modal_btn_Iduse">사용</button>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
			<p id="idConfirm">*이메일을 입력해주세요.</p>
			<div class="row">
				<div class="col-12">
					<input type="password" class="form-control" id="password"
						name="password" placeholder="비밀번호">
				</div>
			</div>
			<p id="pwConfirm">
				*비밀번호는 6-20자 이내로 입력하세요.<br> (영어 대소문자,숫자,특수문자 포함)
			</p>
			<div class="row">
				<div class="col-12">
					<input type="password" class="form-control" id="pwCheck"
						name="pwCheck" placeholder="비밀번호 확인">
				</div>
			</div>
			<p id="pwCheckConfirm">*비밀번호를 일치시켜주세요.</p>
			<div class="row">
				<div class="col-12 col-xl-8">
					<input type="text" class="form-control" id="nickname"
						name="nickname" placeholder="닉네임">
				</div>
				<div class="col-12 col-xl-4">
					<!-- 닉네임 중복검사 modal -->
					<button type="button" class="btn btn-dark col-12"
						data-bs-toggle="modal" data-bs-target="#nicknameCheck" id="btn_Nickname_check"
						disabled>중복확인</button>

					<!-- Modal -->
					<div class="modal fade" id="nicknameCheck" data-bs-backdrop="static"
						data-bs-keyboard="false" tabindex="-1" aria-hidden="true">
						<div class="modal-dialog modal-dialog-centered">
							<div class="modal-content">
								<div class="modal-header">
									<h5 class="modal-title">닉네임 중복확인</h5>
									<button type="button" class="btn-close" data-bs-dismiss="modal"
										aria-label="Close"></button>
								</div>
								<div class="modal-body">
									<div class="row">
										<div class="col-8">
											<input type="text" class="form-control" id="modal_nickname"
												name="modal_nickname" placeholder="닉네임">
										</div>
										<div class="col-4">
											<button type="button" class="btn btn-dark col-12"
												id="modal_btn_nicknamecheck" disabled>중복 확인</button>
										</div>
									</div>
									<div id="nicknameCheckModalResult">
										<img src="../imgs/loading.gif" class="mt-3" width="24px;">
									</div>
								</div>
								<div class="modal-footer d-flex justify-content-center">
									<button type="button" class="btn btn-secondary"
										data-bs-dismiss="modal">닫기</button>
									<button type="button" class="btn btn-dark" id="modal_btn_Nicknameuse">사용</button>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
			<p id="nicknameConfirm">*닉네임은 2-10자 이내로 입력해주세요.</p>
			<div class="row">
				<div class="col-4 mb-3">
					<input type="text" class="form-control" id="name" name="name"
						placeholder="이름">
				</div>
				<div class="col-4 mb-3">
					<c:choose>
						<c:when test="${gender eq 'male'}">
							<select name="gender" id="gender" class="form-select" disabled>
								<option value="none" disabled>성별</option>
								<option value="남" selected>남</option>
								<option value="여">여</option>
							</select>
							<script>
								let genderNull = true;
								$(function() {
									$('#gender').css("border",
											"2px solid green");
								})
							</script>
						</c:when>
						<c:when test="${gender eq 'female'}">
							<select name="gender" id="gender" class="form-select" disabled>
								<option value="none" disabled>성별</option>
								<option value="남">남</option>
								<option value="여" selected>여</option>
							</select>
							<script>
								let genderNull = true;
								$(function() {
									$('#gender').css("border",
											"2px solid green");
								})
							</script>
						</c:when>
						<c:when test="${gender eq null}">
							<select name="gender" id="gender" class="form-select">
								<option value="none" selected disabled>성별</option>
								<option value="남">남</option>
								<option value="여">여</option>
							</select>
							<script>
								let genderNull = false;
							</script>
						</c:when>
					</c:choose>
				</div>
				<div class="col-4 mb-3">
					<input type="text" class="form-control" id="age" name="age"
						placeholder="나이" maxlength="2">
				</div>
			</div>
			<div class="row">
				<div class="col-4 mb-3">
					<select name="phone1" id="phone1" class="form-select">
						<option value="none" selected disabled>선택</option>
						<option value="010">010</option>
						<option value="011">011</option>
						<option value="019">019</option>
					</select>
				</div>
				<div class="col-4 mb-3">
					<input type="text" class="form-control" id="phone2" name="phone2"
						maxlength="4" placeholder="">
				</div>
				<div class="col-4 mb-3">
					<input type="text" class="form-control" id="phone3" name="phone3"
						maxlength="4" placeholder="">
				</div>
				<div class="row d-none">
					<input type="text" class="form-control" id="phone" name="phone">
				</div>
			</div>
			<div class="row">
				<div class="col-6 mb-3">
					<input type="text" id="postcode" placeholder="우편번호" name="postcode"
						class="form-control">
				</div>
				<div class="col-6 mb-3">
					<input type="button" onclick="Postcode()" value="우편번호 찾기"
						class="btn btn-dark col-12">
				</div>
			</div>
			<div class="row">
				<div class="col-12 mb-3">
					<input type="text" class="form-control" id="roadAddress"
						name="roadAddress" placeholder="도로명주소">
				</div>
			</div>
			<div class="row">
				<div class="col-6 mb-3">
					<input type="text" class="form-control" id="detailAddress"
						name="detailAddress" placeholder="상세주소">
				</div>
				<div class="col-6 mb-3">
					<input type="text" class="form-control" id="extraAddress"
						name="extraAddress" placeholder="읍/면/동">
				</div>
				<input type="text" class="form-control d-none" id="address"
					name="address">
			</div>
			<div class="row foot">
				<div class="col-12 col-xl-6">
					<button type="button" class="btn btn-secondary col-12"
						id="btn_back">취소</button>
				</div>
				<div class="col-12 col-xl-6">
					<button type="button" class="btn btn-dark col-12" id="btn_submit">가입</button>
				</div>
			</div>
		</form>
	</div>
	<script
		src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

	<script>
		
		let nicknameConfirm = false;
		
		let passwordNull = false;
		let passwordRegex = false;

		let pwCheckNull = false;
		let pwCheckEquals = false;

		let nicknameNull = false;
		let nicknameRegex = false;

		let nameNull = false;
		let nameRegex = false;

		let ageNull = false;

		let phone1Null = false;

		let phone2Null = false;
		let phone2Regex = false;

		let phone3Null = false;
		let phone3Regex = false;

		let postcodeNull = false;
		let roadAddressNull = false;
		let detailAddressNull = false;
		let extraAddressNull = false;

		$(function() {
			function idCheck(value) {
				$
						.ajax(
								{
									type : "post",
									url : "${pageContext.request.contextPath}/idCheckProc.mem",
									data : {value:value},
									dataType : "text"
								})
						.done(
								function(data) {
									console.log(data);
									if (data == 'idCheckSuccess') {
										$('#modal_btn_Iduse').attr("disabled", false);
										$('#idCheckModalResult').empty();
										let ldCheckResult = "<p class='mt-3 mb-0' style='color:green;'>사용이 가능한 이메일 입니다.</p>"
										$('#idCheckModalResult').append(
												ldCheckResult);
									} else if (data == 'idCheckFail') {
										$('#modal_btn_Iduse').attr("disabled", true);
										$('#idCheckModalResult').empty();
										let ldCheckResult = "<p class='mt-3 mb-0' style='color:red;'>사용이 불 가능한 이메일 입니다.</p>"
										$('#idCheckModalResult').append(
												ldCheckResult);
									}
								}).fail(function(data) {
							console.log(data);
						});
			}
			
			function nicknameCheck(value) {
				$
						.ajax(
								{
									type : "post",
									url : "${pageContext.request.contextPath}/nicknameCheckProc.mem",
									data : {value:value},
									dataType : "text"
								})
						.done(
								function(data) {
									console.log(data);
									if (data == 'nicknameCheckSuccess') {
										$('#modal_btn_Nicknameuse').attr("disabled", false);
										$('#nicknameCheckModalResult').empty();
										let nicknameCheckResult = "<p class='mt-3 mb-0' style='color:green;'>사용이 가능한 닉네임 입니다.</p>"
										$('#nicknameCheckModalResult').append(
												nicknameCheckResult);
									} else if (data == 'nicknameCheckFail') {
										$('#modal_btn_Nicknameuse').attr("disabled", true);
										$('#nicknameCheckModalResult').empty();
										let nicknameCheckResult = "<p class='mt-3 mb-0' style='color:red;'>사용이 불 가능한 닉네임 입니다.</p>"
										$('#nicknameCheckModalResult').append(
												nicknameCheckResult);
									}
								}).fail(function(data) {
							console.log(data);
						});
			}

			$('#modal_id')
					.on(
							"keyup",
							function() {
								$('#modal_btn_Idcheck').attr('disabled', true);

								$('#idCheckModalResult').empty();
								let ldCheckResult = "<p class='mt-3' style='color:black;'>중복 확인을 해주세요.</p>"
								$('#idCheckModalResult').append(ldCheckResult);

								let regexModalId = /^[a-zA-z][a-zA-z0-9_.]{1,}@[a-zA-z]{1,}\.([a-zA-Z]{2,3}\.)*[a-zA-Z]{2,3}/g;

								if (regexModalId.test($('#modal_id').val())) {
									$('#modal_btn_Idcheck').attr('disabled',
											false);
								}
								$('#modal_btn_Iduse').attr("disabled", true);
							})

			$('#modal_btn_Idcheck').on('click', function() {
				let signupForm = $('#modal_id').val();
				idCheck(signupForm);
			});
			
			$('#modal_btn_Iduse').on('click', function() { //모달에서 사용버튼을 누를때
				let myModalEl = document.getElementById('idCheck')
				let modal = bootstrap.Modal.getInstance(myModalEl) 
				$('#id').val($('#modal_id').val());
				$('#id').attr("disabled",true);
				modal.hide();
				idConfirm = true;
				$('#id').css("border", "2px solid green");
				$('#btn_Id_check').attr('disabled', true);
				$('#idConfirm').html("*사용할 수 있는 이메일입니다.");
				$('#idConfirm').css("color", "green");
			});

			$('#btn_Id_check').on('click', function() {
				$('#modal_id').val($('#id').val());
				let value = $('#signupForm').serialize();
				idCheck(value);
			});

			
			//
			$('#modal_nickname')
					.on(
							"keyup",
							function() {
								$('#modal_btn_nicknamecheck').attr('disabled', true);

								$('#nicknameCheckModalResult').empty();
								let nicknameCheckResult = "<p class='mt-3' style='color:black;'>중복 확인을 해주세요.</p>"
								$('#nicknameCheckModalResult').append(nicknameCheckResult);
								
								let regexModalNickname = /^[가-힣a-zA-Z0-9]{2,20}$/g;
								
								if (regexModalNickname.test($('#modal_nickname').val())) {
									$('#modal_btn_nicknamecheck').attr('disabled',
											false);
								}
								$('#modal_btn_Nicknameuse').attr("disabled", true);
							})

			$('#modal_btn_nicknamecheck').on('click', function() {
				let value = $('#modal_nickname').val();
				nicknameCheck(value);
			});
			
			$('#modal_btn_Nicknameuse').on('click', function() { //모달에서 사용버튼을 누를때
				let myModalEl = document.getElementById('nicknameCheck')
				let modal = bootstrap.Modal.getInstance(myModalEl) 
				$('#nickname').val($('#modal_nickname').val());
				$('#nickname').attr("disabled",true);
				modal.hide();
				nicknameConfirm = true;
				$('#nickname').css("border", "2px solid green");
				$('#btn_Nickname_check').attr('disabled', true);
				$('#nicknameConfirm').html("*사용할 수 있는 닉네임입니다.");
				$('#nicknameConfirm').css("color", "green");
			});

			$('#btn_Nickname_check').on('click', function() {
				$('#modal_nickname').val($('#nickname').val());
				let value = $('#signupForm').serialize();
				nicknameCheck(value);
			});
			
			
			$('#btn_back').on('click', function() { //취소 버튼을 눌렀을때
				window.history.back();
			});

			$('#id')
					.on(
							'keyup',
							function() {
								let regexId = /^[a-zA-z][a-zA-z0-9_.]{1,}@[a-zA-z]{1,}\.([a-zA-Z]{2,3}\.)*[a-zA-Z]{2,3}/g;
								if (!(regexId.test($('#id').val()))) {
									$('#idConfirm').html("*형식에 맞춰 입력해주세요.");
									$('#idConfirm').css("color", "red");
									$('#id').css("border", "2px solid red");
									$('#btn_Id_check').attr('disabled', true);
									idRegex = false;
								} else {
									$('#idConfirm').html(
											"*올바른 형식의 이메일 입니다. 중복확인을 해주세요");
									$('#idConfirm').css("color", "gray");
									$('#id').css("border", "2px solid gray");
									$('#btn_Id_check').attr('disabled', false);
									idRegex = true;
								}
								if ($('#id').val() == "") {
									$('#idConfirm').html("*이메일을 입력해주세요.");
									$('#idConfirm').css("color", "gray");
									$('#id').css("border", "");
									$('#btn_Id_check').attr('disabled', true);
									idNull = false;
								} else {
									idNull = true;
								}
							});
			$('#password').on('keyup',function() {
								let regexPw = /^[a-zA-Z0-9~!@#$%^&*+.]{6,20}$/g;

								$('#pwCheckConfirm').html("*비밀번호를 일치시켜주세요.");
								$('#pwCheckConfirm').css("color", "gray");
								$('#pwCheck').css("border", "");
								$('#pwCheck').val("");

								if (!(regexPw.test($('#password').val()))) {
									$('#pwConfirm').html("*형식에 맞춰 입력해주세요.");
									$('#pwConfirm').css("color", "red");
									$('#password').css("border",
											"2px solid red");
									passwordRegex = false;
								} else {
									$('#pwConfirm').html(
											"*올바른 형식의 PassWord 입니다.");
									$('#pwConfirm').css("color", "green");
									$('#password').css("border",
											"2px solid green");
									passwordRegex = true;
									return;
								}

								if ($('#pw').val() == "") {
									$('#pwConfirm')
											.html(
													"*비밀번호는 6-20자 이내로 입력하세요.<br>(영어 대소문자,숫자,특수문자 포함)");
									$('#pwConfirm').css("color", "gray");
									$('#pw').css("border", "");
									passwordNull = false;
									return;
								} else {
									passwordNull = true;
									return;
								}
							});

			$('#pwCheck').on('keyup', function() {
				if ($('#password').val() == "") {
					$('#pwCheckConfirm').html("*비밀번호를 일치시켜주세요.");
					$('#pwCheckConfirm').css("color", "gray");
					$('#password').css("border", "");
					$('#pwCheck').val("");
				} else {
					if ($('#password').val() !== $('#pwCheck').val()) {
						$('#pwCheckConfirm').html("*비밀번호가 일치하지 않습니다.");
						$('#pwCheckConfirm').css("color", "red");
						$('#pwCheck').css("border", "2px solid red");
						pwCheckEquals = false;
					} else {
						$('#pwCheckConfirm').html("*비밀번호가 일치합니다.");
						$('#pwCheckConfirm').css("color", "green");
						$('#pwCheck').css("border", "2px solid green");
						pwCheckEquals = true;
					}
					if ($('#pwCheck').val() == "") {
						$('#pwCheckConfirm').html("*비밀번호를 일치시켜주세요.");
						$('#pwCheckConfirm').css("color", "gray");
						$('#pwCheck').css("border", "2px solid red");
						pwCheckNull = false;
					} else {
						pwCheckNull = true;
						return;
					}
				}
			});

			$('#nickname').on('keyup', function() {
				let regexNickname = /^[가-힣a-zA-Z0-9]{2,20}$/g;

				if (!(regexNickname.test($('#nickname').val()))) {
					$('#nickname').css("border", "2px solid red");
					$('#nicknameConfirm').html("*형식에 맞춰 입력해주세요.");
					$('#nicknameConfirm').css("color", "red");
					$('#btn_nickname_check').attr('disabled', true);
					nicknameRegex = false;
				} else {
					$('#nicknameConfirm').html("*올바른 형식의 닉네임 입니다. 중복확인을 해주세요");
					$('#nicknameConfirm').css("color", "gray");
					$('#nickname').css("border", "2px solid gray");
					$('#btn_Nickname_check').attr('disabled', false);
					nicknameRegex = true;
				}

				if ($('#nickname').val() == "") {
					$('#nicknameConfirm').html("*닉네임은 2-10자 이내로 입력해주세요.");
					$('#nicknameConfirm').css("color", "black");
					$('#nickname').css("border", "");
					nicknameNull = false;
				} else {
					nicknameNull = true;
					return;
				}
			});

			$('#name').on('keyup', function() {
				let regexName = /^[가-힣]{2,4}$/g;

				if (!(regexName.test($('#name').val()))) {
					$('#name').css("border", "2px solid red");
					nameRegex = false;
				} else {
					$('#name').css("border", "2px solid green");
					nameRegex = true;
				}

				if ($('#name').val() == "") {
					$('#name').css("border", "");
					nameNull = false;
				} else {
					nameNull = true;
					return;
				}
			});

			$('#gender').on('change', function() {
				$('#gender').css("border", "2px solid green");
				genderNull = true;
			})

			$('#age').on('keyup', function() {
				if ($('#age').val() == "") {
					$('#age').css("border", "");
					ageNull = false;
				} else {
					$('#age').css("border", "2px solid green");
					ageNull = true;
				}
			})

			$('#phone1').on('change', function() {
				$('#phone1').css("border", "2px solid green");
				phone1Null = true;
			})

			$('#phone2').on('keyup', function() {
				let regexPhone = /^[0-9]{4}$/g;
				if (!(regexPhone.test($('#phone2').val()))) {
					$('#phone2').css("border", "2px solid red");
					phone2Regex = false;
				} else {
					$('#phone2').css("border", "2px solid green");
					phone2Regex = true;
				}
				if ($('#phone2').val() == "") {
					$('#phone2').css("border", "");
					phone2Null = false;
				} else {
					phone2Null = true;
				}
			})

			$('#phone3').on('keyup', function() {
				let regexPhone = /^[0-9]{4}$/g;
				if (!(regexPhone.test($('#phone3').val()))) {
					$('#phone3').css("border", "2px solid red");
					phone3Regex = false;
				} else {
					$('#phone3').css("border", "2px solid green");
					phone3Regex = true;
				}
				if ($('#phone3').val() == "") {
					$('#phone3').css("border", "");
					phone3Null = false;
				} else {
					phone3Null = true;
				}
			})

			$('#detailAddress').on('keyup', function() {

				if ($('#detailAddress').val() == "") {
					$('#detailAddress').css("border", "2px solid red");
					detailAddressNull = false;
				} else {
					$('#detailAddress').css("border", "2px solid green");
					detailAddressNull = true;
				}
			})

			$('#btn_submit').on(
					'click',
					function() { //가입 버튼을 눌렀을때
						if (idNull == true && idRegex == true
								&& passwordNull == true
								&& passwordRegex == true && pwCheckNull == true
								&& pwCheckEquals == true
								&& nicknameNull == true
								&& nicknameRegex == true && nameRegex == true
								&& nameNull == true && phone1Null == true
								&& genderNull == true && ageNull == true
								&& phone2Null == true && phone2Regex == true
								&& phone3Null == true && phone3Regex == true
								&& postcodeNull == true
								&& roadAddressNull == true
								&& detailAddressNull == true
								&& extraAddressNull == true 
								&& idConfirm == true && nicknameConfirm == true) {
							$('#phone').val(
									$('#phone1').val() + $('#phone2').val()
											+ $('#phone3').val());
							$('#address').val(
									$('#roadAddress').val()
											+ $('#extraAddress').val() + " "
											+ $('#detailAddress').val() + " (우)"
											+ $('#postcode').val());
							$('#id').attr("disabled", false);
							$('#nickname').attr("disabled", false);
							$('#gender').attr("disabled", false);
							$('#signupForm').submit();
						} else {
							alert("모든 값을 정확히 입력해주세요.");
						}
					});

		})
		//본 예제에서는 도로명 주소 표기 방식에 대한 법령에 따라, 내려오는 데이터를 조합하여 올바른 주소를 구성하는 방법을 설명합니다.
		function Postcode() {
			new daum.Postcode(
					{
						oncomplete : function(data) {
							// 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

							// 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
							// 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
							var roadAddr = data.roadAddress; // 도로명 주소 변수
							var extraRoadAddr = ''; // 참고 항목 변수

							// 법정동명이 있을 경우 추가한다. (법정리는 제외)
							// 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
							if (data.bname !== ''
									&& /[동|로|가]$/g.test(data.bname)) {
								extraRoadAddr += data.bname;
							}
							// 건물명이 있고, 공동주택일 경우 추가한다.
							if (data.buildingName !== ''
									&& data.apartment === 'Y') {
								extraRoadAddr += (extraRoadAddr !== '' ? ', '
										+ data.buildingName : data.buildingName);
							}
							// 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
							if (extraRoadAddr !== '') {
								extraRoadAddr = ' (' + extraRoadAddr + ')';
							}

							// 우편번호와 주소 정보를 해당 필드에 넣는다.
							document.getElementById('postcode').value = data.zonecode;
							document.getElementById("roadAddress").value = roadAddr;

							// 참고항목 문자열이 있을 경우 해당 필드에 넣는다.
							if (roadAddr !== '') {
								document.getElementById("extraAddress").value = extraRoadAddr;
							} else {
								document.getElementById("extraAddress").value = '';
							}

							$('#postcode').css("border", "2px solid green");
							postcodeNull = true;
							$('#roadAddress').css("border", "2px solid green");
							roadAddressNull = true;
							$('#extraAddress').css("border", "2px solid green");
							extraAddressNull = true;
						}
					}).open();
		}
	</script>
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

		});
	</script>
</body>
</html>