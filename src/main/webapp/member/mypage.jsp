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
	padding-top: 92px;
	width: 40vw;
	margin: auto;
	text-align: center;
}

.modal-body>div>p {
	margin-top: 16px;
	margin-bottom: 0px;
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
				<a
					href="${pageContext.request.contextPath }/toProduct.pro?currentPage=1">제품보기</a>
			</div>
			<div class="col-xl-1 d-none d-xl-block navi-menu">
				<a href="${pageContext.request.contextPath}/toAllReview.co">고객리뷰</a>
			</div>
			<div class="col-xl-1 d-none d-xl-block navi-menu">
				<a href="#">스토리</a>
			</div>
			<div class="col-xl-1 d-none d-xl-block navi-menu">
				<a href="${pageContext.request.contextPath}/toInquiry.in?currentPage=1">고객센터</a>
			</div>
			<c:choose>
				<c:when test="${empty loginSession}">
				</c:when>
				<c:when test="${!empty loginSession}">
					<div class="col-xl-1 d-none d-xl-block navi-menu">
						<a href="${pageContext.request.contextPath }/toMypage">${loginSession.nickname}
							님</a>
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
				<a href="${pageContext.request.contextPath}/tocart.cart">cart <span
					id="cartCount" class="badge bg-dark rounded-pill"></span></a>
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
			<a
				href="${pageContext.request.contextPath }/toProduct.pro?currentPage=1">제품보기</a>
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
					<a href="#">${loginSession.nickname} 님</a>
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
		<div class="row header">
			<h1 class="col-12 mb-3">마이페이지</h1>
		</div>

		<c:choose>
			<c:when test="${token ne null and page eq 1 }">
				<div class="row mb-3">
					<div class="col">
						<a
							href="${pageContext.request.contextPath}/toMypage.mem?token=ConfirmSuccess&page=1&currentPage=1"
							style="color: black;">내정보조회</a>
					</div>
					<div class="col">
						<a
							href="${pageContext.request.contextPath}/toMypage.mem?token=ConfirmSuccess&page=2&currentPage=1"
							style="color: gray;">내가 쓴 리뷰</a>
					</div>
				</div>
				<form action="${pageContext.request.contextPath}/.mem" method="post"
					id="mypageForm" name="mypageForm">
					<div class="row">
						<div class="col-12 mb-3">
							<input type="text" class="form-control" id="id" name="id"
								placeholder="아이디" value="${loginSession.get('id') }" disabled>
						</div>
					</div>
					<div class="row mb-3">
						<div class="col-12 col-xl-8">
							<input type="password" class="form-control" id="password"
								name="password" placeholder="비밀번호" value="${loginSession.get('password')}" disabled>
						</div>
						<div class="col-12 col-xl-4">
							<input type="button" onclick="" value="비밀번호 변경"
								data-bs-toggle="modal" data-bs-target="#passwordChange"
								class="btn btn-dark col-12">
						</div>
						<!--비밀번호 변경 Modal -->
						<div class="modal fade" id="passwordChange"
							data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1"
							aria-hidden="true">
							<div class="modal-dialog modal-dialog-centered">
								<div class="modal-content">
									<div class="modal-header">
										<h5 class="modal-title">비밀번호 변경</h5>
										<button type="button" class="btn-close"
											data-bs-dismiss="modal" aria-label="Close"></button>
									</div>
									<div class="modal-body">
										<div class="row">
											<div class="col-12">
												<input type="password" class="form-control"
													id="modal_password" name="modal_password"
													placeholder="비밀번호">
											</div>
											<p id="pwConfirm">
												*비밀번호는 6-20자 이내로 입력하세요.<br> (영어 대소문자,숫자,특수문자 포함)
											</p>
										</div>
									</div>
									<div class="modal-footer d-flex justify-content-center">
										<button type="button" class="btn btn-secondary"
											data-bs-dismiss="modal">닫기</button>
										<button type="button" class="btn btn-dark"
											id="modal_btn_pwUse" disabled>사용</button>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="row mb-3">
						<div class="col-12 col-xl-8">
							<input type="text" class="form-control" id="nickname"
								name="nickname" placeholder="닉네임"
								value="${loginSession.get('nickname') }" disabled>
						</div>
						<div class="col-12 col-xl-4">
							<!-- 닉네임 중복검사 modal -->
							<button type="button" class="btn btn-dark col-12"
								data-bs-toggle="modal" data-bs-target="#nicknameCheck"
								id="btn_Nickname_check">닉네임 변경</button>

							<!-- Modal -->
							<div class="modal fade" id="nicknameCheck"
								data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1"
								aria-hidden="true">
								<div class="modal-dialog modal-dialog-centered">
									<div class="modal-content">
										<div class="modal-header">
											<h5 class="modal-title">닉네임 중복확인</h5>
											<button type="button" class="btn-close"
												data-bs-dismiss="modal" aria-label="Close"></button>
										</div>
										<div class="modal-body">
											<div class="row">
												<div class="col-8">
													<input type="text" class="form-control" id="modal_nickname"
														name="modal_nickname" placeholder="변경 할 닉네임">
												</div>
												<div class="col-4">
													<button type="button" class="btn btn-dark col-12"
														id="modal_btn_nicknamecheck" disabled>중복 확인</button>
												</div>
											</div>
											<div id="nicknameCheckModalResult">
												<p>*변경하실 닉네임을 입력해주세요.</p>
											</div>
										</div>
										<div class="modal-footer d-flex justify-content-center">
											<button type="button" class="btn btn-secondary"
												data-bs-dismiss="modal">닫기</button>
											<button type="button" class="btn btn-dark"
												id="modal_btn_Nicknameuse">사용</button>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="row mb-3">
						<div class="col-12 col-xl-8">
							<input type="text" class="form-control" id="address"
								name="address" placeholder="주소"
								value="${loginSession.get('address') }" disabled>
						</div>
						<div class="col-12 col-xl-4">
							<input type="button" onclick="Postcode()" value="주소 변경"
								class="btn btn-dark col-12">
						</div>
					</div>
					<div class="mb-3" id="postcode">
						<div class="row">
							<div class="col-12 mb-3">
								<input type="text" class="form-control" id="roadAddress"
									name="roadAddress" placeholder="도로명주소" disabled>
							</div>
						</div>
						<div class="row">
							<div class="col-6 mb-3">
								<input type="text" class="form-control" id="detailAddress"
									name="detailAddress" placeholder="상세주소">
							</div>
							<div class="col-6 mb-3">
								<input type="text" class="form-control" id="extraAddress"
									name="extraAddress" placeholder="읍/면/동" disabled>
							</div>
						</div>
						<div class="row">
							<div class="col-12 mb-3">
								<button type="button" class="btn btn-dark col-12"
									id="btn_address_update">주소 변경 확인</button>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-12 col-xl-8">
							<input type="text" class="form-control" id="phone" name="phone"
								placeholder="휴대폰번호"
								value="" disabled>
<!-- 								인풋태그에 담은다음에 그 값으로 다시 세팅해주기 -->
						</div>
						<div class="col-12 col-xl-4">
							<input type="button" onclick="" value="휴대폰번호 변경"
								data-bs-toggle="modal" data-bs-target="#phoneChange"
								class="btn btn-dark col-12">
						</div>
						<!--휴대폰번호 변경 Modal -->
						<div class="modal fade" id="phoneChange" data-bs-backdrop="static"
							data-bs-keyboard="false" tabindex="-1" aria-hidden="true">
							<div class="modal-dialog modal-dialog-centered">
								<div class="modal-content">
									<div class="modal-header">
										<h5 class="modal-title">휴대폰번호 변경</h5>
										<button type="button" class="btn-close"
											data-bs-dismiss="modal" aria-label="Close"></button>
									</div>
									<div class="modal-body">
										<div class="row">
											<div class="col-12">
												<input type="text" class="form-control" id="modal_phone"
													name="modal_phone" placeholder="휴대폰번호">
											</div>
											<p id="phoneConfirm">*변경하실 휴대폰 번호를 입력하세요.</p>
										</div>
									</div>
									<div class="modal-footer d-flex justify-content-center">
										<button type="button" class="btn btn-secondary"
											data-bs-dismiss="modal">닫기</button>
										<button type="button" class="btn btn-dark"
											id="modal_btn_phoneUse" disabled>사용</button>
									</div>
								</div>
							</div>
						</div>
					</div>


					<div class="row">
						<div class="col-12 mb-3">
							<input type="text" class="form-control d-none" id="phoneDnone"
								name="phoneDnone" placeholder="휴대폰번호"
								value="${loginSession.get('phone')}" disabled>
						</div>
					</div>
					<div class="col-12">
						<button type="button" class="btn btn-dark col-12" id="btn_submit">변경</button>
					</div>
				</form>
			</c:when>
			<c:when test="${token ne null and page eq 2}">
				<div class="row mb-5">
					<div class="col">
						<a
							href="${pageContext.request.contextPath}/toMypage.mem?token=ConfirmSuccess&page=1&currentPage=1"
							style="color: gray;">내정보조회</a>
					</div>
					<div class="col">
						<a
							href="${pageContext.request.contextPath}/toMypage.mem?token=ConfirmSuccess&page=2&currentPage=1"
							style="color: black;">내가 쓴 리뷰</a>
					</div>
				</div>
				<div class="row">
			<div class="col">
				<table class="table table-bordered">
					<thead>
						<tr>
							<th class="col-1">아이디</th>
							<th class="col-1">닉네임</th>
							<th class="col-6">내용</th>
							<th class="col-2">작성일</th>
							<th class="col-1">제품 코드</th>
							<th class="col-1"></th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${list}" var="dto">
							<tr>
								<td>${dto.getId()}</td>
								<td>${dto.getNickname()}</td>
								<td>${dto.getContent()}</td>
								<td>${dto.getWritten_comment_date()}</td>
								<td>${dto.getProduct_code()}</td>
								<td>
									<button type="button" class="btn btn-deleteCmt"
										value="${dto.getSeq_review()}">삭제</button>
								</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
		</div>
		<div class="row">
			<nav class="col" aria-label="Page navigation example">
				<ul class="pagination justify-content-center">
					<c:if test="${naviMap.get('needPrev') eq true}">
						<li class="page-item"><a class="page-link"
							href="${pageContext.request.contextPath}/allReviewProc.co?currentPage=${naviMap.get('startNavi')-1}">Previous</a>
					</c:if>
					<c:forEach var="i" begin="${naviMap.get('startNavi')}"
						end="${naviMap.get('endNavi')}">
						<li class="page-item"><a class="page-link"
							href="${pageContext.request.contextPath}/allReviewProc.co?currentPage=${i}">${i}</a></li>
					</c:forEach>
					<c:if test="${naviMap.get('needNext') eq true}">
						<li class="page-item"><a class="page-link"
							href="${pageContext.request.contextPath}/allReviewProc.co?currentPage=${naviMap.get('endNavi')+1}">Next</a></li>
					</c:if>
				</ul>
			</nav>
		</div>
			</c:when>
			<c:when test="${token eq null}">
				<form>
					<div class="row header">
						<h1 class="col-12 mb-3">마이페이지</h1>
					</div>
					<p>비정상적인 접근입니다.</p>
					<script>
						$(function() {
							function mypageFail() {
								location.href = "/index.jsp";
							}
							setTimeout(mypageFail, 5000);
						})
					</script>
				</form>
			</c:when>
			<c:otherwise>
			</c:otherwise>
		</c:choose>
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

	<script
		src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script>
		$(function() {
			$('#phone').val($('#phoneDnone').val().substring(0,3)+"-"+$('#phoneDnone').val().substring(3,7)+"-"+$('#phoneDnone').val().substring(7,11));//여기
			
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
			
			getCartCount();
			
			
			let loginSession = "${loginSession}";

			if (loginSession == '') {
				alert("로그인 후 이용해주세요.");
				location.href = "/member/login.jsp";
			}

			$('#postcode').css({
				"display" : "none"
			});
			let addressChange = false;
			let passwordChange = false;
			let phoneChange = false;
			let nicknameChange = false;

			let nicknameNull = false;
			let nicknameRegex = false;
			let passwordNull = false;
			let passwordRegex = false;
			let phoneNull = false;
			let phoneRegex = false;

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
										$('#modal_btn_Nicknameuse').attr(
												"disabled", false);
										$('#nicknameCheckModalResult').empty();
										let nicknameCheckResult = "<p class='mt-3 mb-0' style='color:green;'>사용이 가능한 닉네임 입니다.</p>"
										$('#nicknameCheckModalResult').append(
												nicknameCheckResult);
									} else if (data == 'nicknameCheckFail') {
										$('#modal_btn_Nicknameuse').attr(
												"disabled", true);
										$('#nicknameCheckModalResult').empty();
										let nicknameCheckResult = "<p class='mt-3 mb-0' style='color:red;'>사용이 불 가능한 닉네임 입니다.</p>"
										$('#nicknameCheckModalResult').append(
												nicknameCheckResult);
									}
								}).fail(function(data) {
							console.log(data);
						});
			}

			$('#modal_nickname')
					.on(
							"keyup",
							function() {
								$('#modal_btn_nicknamecheck').attr('disabled',
										true);

								let regexModalNickname = /^[가-힣a-zA-Z0-9]{2,20}$/g;

								if (regexModalNickname
										.test($('#modal_nickname').val())) {
									nicknameRegex = true;
									$('#modal_btn_nicknamecheck').attr(
											'disabled', false);
									$('#nicknameCheckModalResult').empty();
									let nicknameCheckResult = "<p class='mt-3' style='color:black;'>*형식에 맞습니다. 중복확인을 해주세요.</p>"
									$('#nicknameCheckModalResult').append(
											nicknameCheckResult);
								}else{
									$('#nicknameCheckModalResult').empty();
									let nicknameCheckResult = "<p class='mt-3' style='color:black;'>*닉네임은 2-10자 이내로 입력해주세요.</p>"
									$('#nicknameCheckModalResult').append(
											nicknameCheckResult);
									nicknameRegex = false;
									return;
								}
								if ($('#modal_nickname').val() == "") {
									$('#nicknameCheckModalResult').empty();
									let nicknameCheckResult = "<p class='mt-3' style='color:black;'>*변경하실 닉네임을 입력해주세요.</p>"
									$('#nicknameCheckModalResult').append(
											nicknameCheckResult);
									$('#modal_btn_nicknameUse').attr("disabled", true);
									phoneNull = false;
									return;
								} else {
									phoneNull = true;
									return;
								}
								$('#modal_btn_Nicknameuse').attr("disabled",
										false);
								
							})

			$('#modal_btn_nicknamecheck').on('click', function() { //모달에서 중복확인 버튼을 눌렀을때
				let value = $('#modal_nickname').val();
				nicknameCheck(value);
			});

			$('#modal_btn_Nicknameuse').on('click', function() { //모달에서 사용버튼을 누를때
				let myModalEl = document.getElementById('nicknameCheck')
				let modal = bootstrap.Modal.getInstance(myModalEl)
				$('#nickname').val($('#modal_nickname').val());
			
				modal.hide();
				nicknameChange = true;
			});

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

			$('#modal_btn_phoneUse').on(
					'click',
					function() {
						if (phoneRegex == true && phoneNull == true) {

							let myModalEl = document
									.getElementById('phoneChange')
							let modal = bootstrap.Modal.getInstance(myModalEl)
							$('#phoneDnone').val($('#modal_phone').val());
							$('#phone').val(
									$('#modal_phone').val().substring(0, 3)
											+ "-"
											+ $('#modal_phone').val()
													.substring(3, 7)
											+ "-"
											+ $('#modal_phone').val()
													.substring(7, 11));
							phoneChange = true;
							modal.hide();

						} else {
							alert("비 정상적인 접근입니다.");
						}
					})

			$('#modal_btn_pwUse').on('click', function() {
				if (passwordRegex == true && passwordNull == true) {
					let password = $('#modal_password').val();
					let myModalEl = document.getElementById('passwordChange')
					let modal = bootstrap.Modal.getInstance(myModalEl)
					$.ajax({
						type:"post",
						url:"${pageContext.request.contextPath}/getHashPw.mem",
						data : {password:password},
						dataType : "text"
					}).done(function(data){
						$('#modal_password').val(data);
						$('#password').val($('#modal_password').val());
						passwordChange = true;
						modal.hide();
					}).fail(function(data){
						
					})
					
					
					

				} else {
					
				}
			})


			$('#modal_phone').on('keyup', function() {

				let regexPhone = /[0,1,9]{3}[0-9]{4}[0-9]{4}/g

				if (!(regexPhone.test($('#modal_phone').val()))) {
					$('#phoneConfirm').html("*숫자만 입력하세요");
					$('#phoneConfirm').css("color", "red");
					phoneRegex = false;
					$('#modal_btn_phoneUse').attr("disabled", true);
				} else {
					$('#phoneConfirm').html("*올바른 형식의 휴대폰 번호입니다.");
					$('#phoneConfirm').css("color", "green");
					phoneRegex = true;
					$('#modal_btn_phoneUse').attr("disabled", false);
					return;
				}
				if ($('#modal_phone').val() == "") {
					$('#phoneConfirm').html("*변경하실 휴대폰 번호를 입력하세요.");
					$('#phoneConfirm').css("color", "black");
					$('#modal_btn_phoneUse').attr("disabled", true);
					phoneNull = false;
					return;
				} else {
					phoneNull = true;
					return;
				}
			});

			$('#modal_password')
					.on(
							'keyup',
							function() {
								let regexPw = /^[a-zA-Z0-9~!@#$%^&*+.]{6,20}$/g;

								if (!(regexPw.test($('#modal_password').val()))) {
									$('#pwConfirm').html("*형식에 맞춰 입력해주세요.");
									$('#pwConfirm').css("color", "red");
									passwordRegex = false;
									$('#modal_btn_pwUse')
											.attr("disabled", true);
								} else {
									$('#pwConfirm').html(
											"*올바른 형식의 PassWord 입니다.");
									$('#pwConfirm').css("color", "green");
									passwordRegex = true;
									$('#modal_btn_pwUse').attr("disabled",
											false);
									return;
								}
								if ($('#modal_password').val() == "") {
									$('#pwConfirm')
											.html(
													"*비밀번호는 6-20자 이내로 입력하세요.<br>(영어 대소문자,숫자,특수문자 포함)");
									$('#pwConfirm').css("color", "black");
									$('#modal_btn_pwUse')
											.attr("disabled", true);
									passwordNull = false;
									return;
								} else {
									passwordNull = true;
									return;
								}
							});

			$('#btn_submit').on(
					'click',
					function() {
						$('#password').attr("disabled",false);
						$('#nickname').attr("disabled",false);
						$('#address').attr("disabled",false);
						$('#phoneDnone').attr("disabled",false);
						let mypageForm = $('#mypageForm').serialize();
						$('#password').attr("disabled",true);
						$('#nickname').attr("disabled",true);
						$('#address').attr("disabled",true);
						$('#phoneDnone').attr("disabled",true);
						
						if (addressChange == false && passwordChange == false
								&& phoneChange == false
								&& nicknameChange == false) {
							alert("변경된 값이 없습니다.");
						} else {
							$.ajax({
								type : "post",
								url : "${pageContext.request.contextPath}/updateProc.mem",
								data : mypageForm,
								dataType : "text"
							}).done(function(data) {
										console.log(data);
										if(data == 'updateSuccess'){
											alert("성공적으로 수정되었습니다. 다시 로그인해주세요.");
											location.href="${pageContext.request.contextPath}/logoutProc.mem";
										}else if(data == 'updateFail'){
											alert("수정에 실패하였습니다.");
											location.href="${pageContext.request.contextPath }/toMypageConfirm.mem";
										}
									}).fail(function(data) {
								console.log(data);
							console.log($('#password').val());
							console.log($('#nickname').val());
							console.log($('#address').val());
							console.log($('#phone').val());
						
					})
						}
						});

			$('#btn_address_update').on(
					'click',
					function() {
						if ($('#roadAddress').val() != ""
								&& $('#detailAddress').val() != ""
								&& $('#extraAddress').val() != "") {
							$('#address').val(
									$('#roadAddress').val()
											+ $('#extraAddress').val() + " "
											+ $('#detailAddress').val()
											+ " (우)" + $('#postcode').val());
							$('#postcode').css({
								"display" : "none"
							});
							addressChange = true;
						} else {
							alert("변경할 주소를 입력해주세요.")
						}
					});

		});

		function Postcode() {
			$('#postcode').css({
				"display" : "block"
			});
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
						}
					}).open();
		}
	</script>
</body>
</html>