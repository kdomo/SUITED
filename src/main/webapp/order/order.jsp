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
					<div class="col-xl-2 col-5 navi-menu"></div>
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
				<a href="#">고객리뷰</a>
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

	<!-- 메인부분 -->
	<div class="main">
		<form method="post" id="orderForm" name="orderForm">
			<div class="row header">
				<h1 class="col-12 mb-3">주문서 작성</h1>
			</div>
			<div class="row">
				<div class="col">
					<table class="table table-bordered">
						<thead>
							<tr>
								<th class="col-5">제품 이미지</th>
								<th class="col-2">제품명</th>
								<th class="col-2">제품 금액</th>
								<th class="col-1">합계</th>
								<th class="col-2">수량</th>
							</tr>
						</thead>
						<tbody id="listDiv">
							
						</tbody>
					</table>
				</div>
			</div>
			<div class="row mb-3">
				<div class="col-12">
					<input type="text" class="form-control" id="order_name" name="order_name"
						placeholder="수취인 이름" value="${loginSession.get('name') }">
				</div>
			</div>
			<div class="row mb-3">
				<div class="col-12">
					<input type="text" class="form-control" id="order_phone" name="order_phone"
						placeholder="수취인 번호" value="${loginSession.get('phone') }">
				</div>
			</div>
			<div class="row mb-3">
				<div class="col-12 col-xl-8">
					<input type="text" class="form-control" id="order_address" name="order_address"
						placeholder="주소" value="${loginSession.get('address') }" disabled>
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
						<button type="button" class="btn btn-dark col-12" id="btn_update">변경</button>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="col-12 input-group mb-3">
					<span class="input-group-text">주문총액</span> <input type="text"
						class="form-control" placeholder="주문 총액" value="${order_amount}" id="order_amount" name="order_amount"
						style="text-align: center;" disabled> <span
						class="input-group-text">원</span>
				</div>
			</div>
			<div class="row">
				<div class="col-12 input-group mb-3">
					<span class="input-group-text">주문 메세지</span> <input type="text"
						class="form-control" placeholder="" name="order_message">
				</div>
			</div>
			<div class="row">
				<div class="col-12 input-group mb-3">
					<span class="input-group-text">배송 메세지</span> <input type="text"
						class="form-control" placeholder="" name="delivery_message">
				</div>
			</div>
			<div class="row foot">
				<div class="col-12 mb-3">
					<button type="button" class="btn btn-dark col-12" id="btn_submit">주문</button>
				</div>
			</div>
			<div class="row d-none">
				<div class="col-12 mb-3">
					<input type="text"
						class="form-control" placeholder="" name="order_no" id="order_no" value="0">
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


	<script
		src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script>
		$(function() {
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
			getCartList();
			
			$('#postcode').css({
				"display" : "none"
			});

			let loginSession = "${loginSession}";
			if (loginSession == null) {
				alert("로그인 후 이용가능합니다.");
				location.href = "/member/login.jsp";
			} else if (loginSession == '') {
				alert("로그인 후 이용가능합니다.");
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
			
			$('#btn_update').on('click',function(){
				if($('#roadAddress').val() != "" &&
						$('#detailAddress').val() != "" &&
						$('#extraAddress').val() != ""
				){
					$('#order_address').val($('#roadAddress').val()
							+ $('#extraAddress').val() + " "
							+ $('#detailAddress').val() + " (우)"
							+ $('#postcode').val());
					$('#postcode').css({
						"display" : "none"
					});
				}else{
					alert("변경할 주소를 입력해주세요.")
				}
			});
			
			$('#btn_submit').on('click',function(){
				$('#order_amount').attr("disabled",false);
				$('#address').attr("disabled",false);
				let orderForm = $('#orderForm').serialize();
				$('#order_amount').attr("disabled",true);
				$('#address').attr("disabled",true);
				$.ajax({
					type:"post",
					url:"${pageContext.request.contextPath}/orderProc.order",
					data:orderForm,
					dataType:"text"
				}).done(function(data){
					if(data == 'orderSuccess'){
						$.ajax({
							type : "post"
							, url : "${pageContext.request.contextPath}/getCartProc.cart"
							, dataType : "json"
						}).done(function(data){
								$.ajax({
									type:"post",
									url:"${pageContext.request.contextPath}/order_productProc.order",
									data:{data : JSON.stringify(data)},
									traditional: true,
									dataType:"text"
								}).done(function(data){
										let token = data;
										location.href="${pageContext.request.contextPath}/orderComplete.order?token="+token;
								}).fail(function(data){
									
								})
							
							
						}).fail(function(e){
							console.log(e);
						})
					}
				}).fail(function(data){
					console.log(data);
				});
			});
		});
		
		function getCartList(){
			$.ajax({
				type : "post"
				, url : "${pageContext.request.contextPath}/getCartProc.cart"
				, dataType : "json"
			}).done(function(data){
				$('#listDiv').empty();
				$('.totalPrice').empty();
				let total = 0;
				let count = 1;
				for(let dto of data){
						let list = "<tr>"
					+ "<td><img alt=''"
					+ "src='${pageContext.request.contextPath}/product_img/" + dto.img_system_name + "'"
					+ "width='150px' height='150px'></td>"
					+ "<td>" + dto.product_name + "</td>"
					+ "<td>" + dto.price + "</td>"
					+ "<td>" + dto.price * dto.quantity + "</td>"
					+ "<td>"
					+ "<span> " + dto.quantity + " </span>"
					+ "</td>"
					+ "<td class='d-none'><input type='text' value='"+ (count++) +"'></td>";
					
					total += dto.price * dto.quantity;
					$("#listDiv").append(list);
				}
				$('#order_amount').val(total);
			}).fail(function(e){
				console.log(e);
			})
		}
		
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