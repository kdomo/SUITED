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
	<c:if test="${loginSession.get('admin_yn') eq '1'}">
		<nav class="navber">
			<div class="row nav-items d-flex justify-content-center">
				<div class="col-2 col-xl-2 navi-logo">
					<a href="${pageContext.request.contextPath }/toAdminIndex.admin"><img
						src="../imgs/logo.png" width="80px"></a>
				</div>
				<c:choose>
					<c:when test="${empty loginSession}">
						<div class="col-xl-2 col-5 navi-menu"></div>
					</c:when>
					<c:when test="${!empty loginSession}">
						<div class="col-xl-2 col-5 navi-menu"></div>
					</c:when>
				</c:choose>

				<div class="col-xl-1 d-none d-xl-block navi-menu">
					<a href="${pageContext.request.contextPath }/toMemberList.admin">회원조회</a>
				</div>
				<div class="col-xl-1 d-none d-xl-block navi-menu">
					<a
						href="${pageContext.request.contextPath }/toBlacklist.bl?currentPage=1">블랙리스트</a>
				</div>
				<div class="col-xl-1 d-none d-xl-block navi-menu">
					<a href="${pageContext.request.contextPath }/toAllReview.admin">리뷰관리</a>
				</div>
				<div class="col-xl-1 d-none d-xl-block navi-menu">
					<a
						href="${pageContext.request.contextPath }/toAdminProduct.pro?currentPage=1">상품관리</a>
				</div>
				<div class="col-xl-1 d-none d-xl-block navi-menu">
					<a
						href="${pageContext.request.contextPath }/toInquiry.in?currentPage=1">고객센터</a>
				</div>
				<div class="col-xl-1 d-none d-xl-block navi-menu">
					<a href="${pageContext.request.contextPath }/toOrderList.admin">주문조회</a>
				</div>
				<div class="col-xl-1 d-none d-xl-block navi-menu">
					<a href="${pageContext.request.contextPath }/toSurveyList.admin">통계조회</a>
				</div>
				<c:choose>
					<c:when test="${empty loginSession}">
						<div class="col-xl-1 d-none d-xl-block navi-menu">
							<a href="${pageContext.request.contextPath }/toLogin.admin">로그인</a>
						</div>
					</c:when>
					<c:when test="${!empty loginSession}">
						<div class="col-xl-1 d-none d-xl-block navi-menu">
							<a href="${pageContext.request.contextPath }/logoutProc.admin">로그아웃</a>
						</div>
					</c:when>
				</c:choose>
				<div class="col-xl-0 col-2 d-xl-none navi-menu">
					<a id="btn_navi_menu"><img src="../imgs/menu.png" width="20px"
						height="24px"></a>
				</div>
			</div>
		</nav>
		<div class="row navi-onButtons">
			<div class="col-12">
				<a href="${pageContext.request.contextPath }/toMemberList.admin">회원조회</a>
			</div>
			<div class="col-12">
				<a
					href="${pageContext.request.contextPath }/toBlacklist.bl?currentPage=1">블랙리스트</a>
			</div>
			<div class="col-12">
				<a href="${pageContext.request.contextPath }/toAllReview.admin">리뷰관리</a>
			</div>
			<div class="col-12">
				<a
					href="${pageContext.request.contextPath }/toAdminProduct.pro?currentPage=1">상품관리</a>
			</div>
			<div class="col-12">
				<a
					href="${pageContext.request.contextPath }/toInquiry.in?currentPage=1">고객센터</a>
			</div>
			<div class="col-12">
				<a href="${pageContext.request.contextPath }/toSurveyList.admin">통계조회</a>
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
						<a href="${pageContext.request.contextPath }/toLogin.admin">로그인</a>
					</div>
				</c:when>
				<c:when test="${!empty loginSession}">
					<div class="col-12">
						<a href="${pageContext.request.contextPath }/logoutProc.mem">로그아웃</a>
					</div>
				</c:when>
			</c:choose>
		</div>
	</c:if>
	<c:if test="${loginSession.get('admin_yn') ne '1'}">
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
	</c:if>
	<div class="main">
		<div class="title">
			<div class="col-12 mt-4 mb-4" style="text-align: center;">
				<h4>1대1 맞춤상담 게시판입니다.</h4>
			</div>
		</div>
		<div class="container" style="width: 70%; padding: 10px;">
			<form id="answerForm"
				action="${pageContext.request.contextPath}/sendAnswerProc.in?seq_inquiry=${dto.getSeq_inquiry()}&currentPage=${currentPage}"
				method="post">
				<table class="table table-bordered">
					<tr>
						<th class="col-2">제목</th>
						<td class="col-10" style="text-align: left; width: 50%;">
							<div>${dto.getTitle()}</div>
						</td>
					</tr>
					<c:if test="${dto.getProduct_code() ne 'X'}">
						<tr>
							<th class="col-2">제품</th>
							<td class="col-10" style="text-align: left;">
								<div>${dto.getProduct_code()}</div>
							</td>
						</tr>
					</c:if>
					<tr>
						<th class="col-2">작성자</th>
						<td class="col-10" style="text-align: left;">
							<div>${dto.getId()}</div>
						</td>
					</tr>
					<tr>
						<th class="col-2">작성일</th>
						<td class="col-10" style="text-align: left;">
							<div>${dto.getInquiry_date()}</div>
						</td>
					</tr>
					<tr>
						<th class="col-2">내용</th>
						<td class="col-10">
							<div style="width: 100%; height: 500px;">${dto.getContent()}</div>
						</td>
					</tr>
					<c:if test="${loginSession.get('admin_yn') eq '0'}">
						<th class="col-2">답변</th>
						<c:choose>
							<c:when test="${answer_yn eq '1'}">
								<td class="col-10">
									<div style="width: 100%; height: 300px;">${dto.getAnswer()}</div>
								</td>
							</c:when>
							<c:otherwise>
								<td class="col-10">
									<div>빠른 시일 내에 답변을 남겨드리겠습니다.</div>
								</td>
							</c:otherwise>
						</c:choose>
					</c:if>
					<c:if test="${loginSession.get('admin_yn') eq '1'}">
						<tr>
							<th class="col-12" colspan="2"
								style="text-align: center; border: white;">
								<h4>************** 답글쓰기 **************</h4>
							</th>
						</tr>
						<tr>
							<th class="col-2">답변</th>
							<c:choose>
								<c:when test="${answer_yn eq '1'}">
									<td class="col-10">
										<div style="width: 100%; height: 300px;">${dto.getAnswer()}</div>
									</td>
								</c:when>
								<c:otherwise>
									<td class="col-10"><textarea id="answer" name="answer"
											placeholder="내용을 입력하세요."
											style="width: 100%; height: 300px; resize: none;"></textarea>
									</td>
								</c:otherwise>
							</c:choose>
						</tr>
					</c:if>
				</table>
			</form>
		</div>
		<div class="boxBtn" style="text-align: center;">
			<button type="button" class="btn btn-dark" id="btnBack">목록으로</button>
			<c:if
				test="${loginSession.get('admin_yn') eq '1' and answer_yn eq '0'}">
				<button type="button" class="btn btn-dark" id="btnSave">저장</button>
			</c:if>
		</div>
		<script>
			$("#btnBack")
					.on(
							"click",
							function() {
								$(location)
										.attr(
												"href",
												"${pageContext.request.contextPath}/toInquiry.in?seq_inquiry=${dto.getSeq_inquiry()}&currentPage=${currentPage}");
							});
			$("#btnSave").on("click", function() {
				$("#answerForm").submit();
			});
		</script>
	</div>
	<div class="footer">
		<div class="row footer-top">
			<ul>
				<li><a href="">이용약관</a></li>
				<li><a href="">개인정보처리방침</a></li>
				<li><a
					href="${pageContext.request.contextPath}/toInquiry.in?currentPage=1">고객센터</a></li>
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

			function getCartCount() {
				$
						.ajax(
								{
									type : "get",
									url : "${pageContext.request.contextPath}/countCartProc.cart"
								}).done(function(rs) {
							if (rs != "fail") {
								$('#cartCount').html(rs);
							} else {
								alert("오류");
							}
						}).fail(function(e) {
							console.log(e);
						})
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

		});
	</script>
</body>
</html>
