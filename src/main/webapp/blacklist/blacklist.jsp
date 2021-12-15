<%@page import="suited.com.dao.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%-- JSTL CDN --%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 페이지</title>
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

/* main 영역 */
.main {
	padding-top: 20px;
	width: 82.6vw;
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
</style>
</head>
<body>
	<nav class="navber">
		<div class="row nav-items d-flex justify-content-center">
			<div class="col-2 col-xl-2 navi-logo">
				<a href="${pageContext.request.contextPath }/admin/index.jsp"><img
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
				<a href="#">회원관리</a>
			</div>
			<div class="col-xl-1 d-none d-xl-block navi-menu">
				<a href="${pageContext.request.contextPath }/toBlacklist.bl?currentPage=1">블랙리스트</a>
			</div>
			<div class="col-xl-1 d-none d-xl-block navi-menu">
				<a href="#">리뷰관리</a>
			</div>
			<div class="col-xl-1 d-none d-xl-block navi-menu">
				<a href="#">상품관리</a>
			</div>
			<div class="col-xl-1 d-none d-xl-block navi-menu">
				<a href="${pageContext.request.contextPath }/toInquiry.in?currentPage=1">고객센터</a>
			</div>
			<div class="col-xl-1 d-none d-xl-block navi-menu">
				<a href="#">통계조회</a>
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
			<a href="#">회원관리</a>
		</div>
		<div class="col-12">
			<a href="${pageContext.request.contextPath }/toBlacklist.bl?currentPage=1">블랙리스트</a>
		</div>
		<div class="col-12">
			<a href="#">리뷰관리</a>
		</div>
		<div class="col-12">
			<a href="#">상품관리</a>
		</div>
		<div class="col-12">
			<a href="${pageContext.request.contextPath }/toInquiry.in?currentPage=1">고객센터</a>
		</div>
		<div class="col-12">
			<a href="#">통계조회</a>
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
	<div class="main">
	<div class="container">
        <div class="row mt-4">
            <div class="col-12 main_title_div">
                <h3>블랙리스트 관리</h3>
            </div>
        </div>
        <div class="row mt-4">
            <div class="col-3 suv_title_div">
                <h5>블랙리스트 추가</h5>
            </div>
            <div class="col-9 search_plus_div">
                <div class="row mb-3">
	                <div class="col-10 input_div" style="margin: auto;">
	                    <input type="text" id="idInput" placeholder="ID를 검색하세요." style="width: 100%;" name="idInput">
	                </div>
	                <div class="col-2 input_button_div" style="text-align: center;">
	                    <button type="button" id="btnSearch" class="btn btn-dark">
	                        <span>검색</span>
	                    </button>
	                </div>
                </div>
                <div class="row mb-3 d-none" id="hiddenDiv">
	                <div class="col-10 list_choice_div">
	                    <p>
	                        <strong id="strong" name="strong"></strong><input type="hidden" id="span">
	                    </p>
	                    <select id="reason" name="reason">
	                    	<option selected>사유를 선택하세요.</option>
                            <option value="구매의사 없는 구매 요청.">구매의사 없는 구매 요청</option>
                            <option value="제품 훼손 후 반품 요청">제품 훼손 후 반품 요청</option>
                            <option value="부적절한 언어 사용">부적절한 언어 사용</option>
                            <option value="부적합한 결제 방식 사용">부적합한 결제 방식 사용</option>
	                    </select>
	                </div>
	                <div class="col-2 plus_button_div" style="text-align: center;">
	                    <button type="button" id="btnPlus" class="btn btn-dark">
	                        <span>추가</span>
	                    </button>
	                </div>
                </div>
            <!--     <div class="row">
                     <div class="col-12 warning_div">
                        <p class="m-0">※ 블랙리스트는 ......이러한 기능들이 차단됩니다.</p>
                    </div>
                </div>-->
            </div>
        </div>
        <form id="blackForm" action="${pageContext.request.contextPath}/deleteProc.bl" method="post">
        <div class="row mt-5">
            <div class="col-12 list_all_div" style="height: 469px;">
                <table class="table table-bordered">
                    <thead>
                        <tr style="text-align: center;">
                            <th class="col-1"><input type="checkbox" id="allcheck" name="allcheck"></th>
                            <th class="col-2">ID</th>
                            <th class="col-2">이름</th>
                            <th class="col-2">추가일</th> 
                            <th class="col-5">사유</th>
                        </tr>
                    </thead>
                    <tbody id="plusBlacklist">
                        <!-- 추가될 영역 -->
                    <c:choose> 
	                    <c:when test="${empty list}">
                        <tr>
                            <td colspan="6" style="text-align: center;">검색 결과가 없습니다.</td>
                        </tr>
                        </c:when>
                        <c:otherwise>
	                    <c:forEach items="${list}" var="dto">
                        <tr class="firstList" style="text-align: center;">
                            <td style="text-align: center;"><input type="checkbox" class="testaa" name="solcheck" value="${dto.getId()}"></td>
                            <td>${dto.getId()}</td>
                            <td>${dto.getName()}</td>
                            <td>${dto.getBlack_update()}</td>
                            <td>${dto.getReason()}</td>
                        </tr>
                        </c:forEach>
	                    </c:otherwise>
	                </c:choose>
                    </tbody>
                </table>
            </div>
        </div>
        </form>
        <div class="row mt-1">
            <div class="col-12" style="text-align: right;">
                <button type="button" id="btnDelete" class="btn btn-dark">해제</button>
                <!--<button type="button" id="allDelete" class="btn btn-dark">전체 해제</button> -->
            </div>
        </div>
        <div class="row mt-2 beforeNavi">
        <nav class="col" aria-label="Page navigation example">
			  <ul class="pagination justify-content-center">
				  <c:if test="${settingMap.get('needPrev') eq true}">
				  	<li class="page-item"><a class="page-link" href="${pageContext.request.contextPath}/toBlacklist.bl?currentPage=${settingMap.get('startNavi')-1}">Previous</a></li>
				  </c:if>
				  <!--startNavi ->endNavi  -->
				  <c:forEach var="i" begin="${settingMap.get('startNavi')}" end="${settingMap.get('endNavi')}">
				  	<li class="page-item"><a class="page-link" href="${pageContext.request.contextPath}/toBlacklist.bl?currentPage=${i}">${i}</a></li>
				  </c:forEach>
				  <c:if test="${settingMap.get('needNext') eq true}">
				  	<li class="page-item"><a class="page-link" href="${pageContext.request.contextPath}/toBlacklist.bl?currentPage=${settingMap.get('endNavi')+1}">Next</a></li>
				  </c:if>			    
			  </ul>
			</nav>
        </div>
        <div class="row mt-2">
            <div class="col-5" style="text-align: right; margin: auto; padding-right: 0;">
                <select>
                    <option selected>ID</option>
                    <!--  <option value="name">이름</option> -->
                </select>
            </div>
            <div class="col-2" style="text-align: center; margin: auto;">
                <input type="text" placeholder="검색어를 입력해주세요." id="searchIdName" name="searchIdName">
            </div>
            <div class="col-5" style="text-align: left;">
            <button type="button" id="searchBtn" class="btn btn-dark">검색</button>
            <button type="button" id="searchBtnAll" class="btn btn-dark">전체보기</button>
            </div>
        </div>
    </div>
    <script>
    	let allcheck = document.getElementById("allcheck");
    	let solcheck = document.getElementsByName("solcheck");
    	
    	// 맨 위를 체크하면 전부 체크/해제됨
    	allcheck.addEventListener("click", function(){
    		allcheck.checked;
    		for(let i= 0; i<solcheck.length; i++){
    			solcheck[i].checked = allcheck.checked;
    		}
    	});
    	
    	let btnDelete = document.getElementById("btnDelete");
    	let solchecks = [];
    	
    	// 해제버튼을 눌렀을 때
    	btnDelete.addEventListener("click", function(e){
    		
    		let rs = confirm("블랙리스트 해제를 하시겠습니까?");
    		if(!rs){
    			return;
    		}
    		for(let i=0; i<solcheck.length; i++){
    			if(solcheck[i].checked){
    				solchecks.push(solcheck[i].value);
    				console.log(solcheck[i].value);
    			}
    			
    		}console.log(solchecks, "1");
    		let data = {"solchecks" : solchecks};
    		console.log(data, "2");
			$.ajax({
			type: "post",
			traditional : true,
			url : "${pageContext.request.contextPath}/deleteById.bl",
			data : data
			}).done(function(data){// 서버에 요청을 보내고 그 요청이 성공적을 이뤄졌을 때 응답값을 되돌려 받는 곳
				
				if(data == "success"){
					for(let i = 0; i < data.length; i++){
						solchecks.pop();
					}
					console.log(solchecks, "3");
					getBlackList();// 성공하면 블랙리스트에 추가되어 업로드
					
				}else if (data == "fail"){
					alert("삭제되지 않았습니다. 다시 시도해 주세요.");
					return;
				}
				$(location).attr("href", "${pageContext.request.contextPath}/toBlacklist.bl?currentPage=1");
			}).fail(function(e){// 서버에 요청이 실패했을 때 매개변수로 에러와 관련된 정보값이 담김
				console.log(e);
			})
			
    	});
    	
    	// 전체보기 버튼을 눌렀을 때
    	$("#searchBtnAll").on("click", function(){
    		$(location).attr("href", "${pageContext.request.contextPath}/toBlacklist.bl?currentPage=1");
    	});
    	
    	// 아래 검색 버튼을 눌렀을 때
    	$("#searchBtn").on("click", function(){
    		let searchIdName = $("#searchIdName").val();
    		let data = {"searchIdName" : searchIdName};
    		$.ajax({
				type: "post",
				url : "${pageContext.request.contextPath}/searchIdName.bl",
				data : data,
				dataType : "json"
				}).done(function(data){// 서버에 요청을 보내고 그 요청이 성공적을 이뤄졌을 때 응답값을 되돌려 받는 곳
					$("#plusBlacklist").empty();
					//$(".firstList").attr("hidden", true);
					for(let blacklist of data){
			            let list = "<tr style='text-align: center;'><td style='text-align: center;''><input type='checkbox' name='solcheck' id='solcheck' value='${dto.getId()}'></td>"
			            + "<td>" + blacklist.id + "</td>"
			            + "<td>" + blacklist.name + "</td>"
			            + "<td>" + blacklist.black_update + "</td>"
			            + "<td>" + blacklist.reason + "</td>"
			            + "</tr>"
		           
		            	$("#plusBlacklist").append(list);// 동적으로 블랙리스트 테이블 추가
					}
				}).fail(function(e){// 서버에 요청이 실패했을 때 매개변수로 에러와 관련된 정보값이 담김
					console.log(e);
				})
    	});
    	
	    
    	//위에 검색 버튼을 눌렀을 때
    	$("#btnSearch").on("click", function(){
    		let idInput = $("#idInput").val();
    		if(idInput == ""){
    			console.log($("#idInput").val());
    			alert("등록할 ID를 입력하세요.");
    			return;
    		}else{
    			
    			let data = {"idInput" : idInput};
    			$.ajax({
				type: "post",
				url : "${pageContext.request.contextPath}/searchId.bl",
				data : data
				}).done(function(data){// 서버에 요청을 보내고 그 요청이 성공적을 이뤄졌을 때 응답값을 되돌려 받는 곳
					let name = data;
					if(name == "fail"){
						alert("등록된 사용자가 아닙니다.");
						$("#idInput").val("");
						$("#hiddenDiv").addClass("d-none");
						return;
					}else{
						$("#hiddenDiv").removeClass("d-none");
						$("#strong").html($("#idInput").val() + "(" + name + ")");
						$("#span").val(name);
					}
					
				}).fail(function(e){// 서버에 요청이 실패했을 때 매개변수로 에러와 관련된 정보값이 담김
					console.log(e);
				})
    		}
    	});
    	
    	let reason = $("#reason").change(function(e){
    		$(e.target).val();
    	});
    	
    	
    	//$(document).ready(function(){
		//	getBlackList();
		//});
    	
    	$("#btnPlus").on("click", function(){
    		if($("#reason").val() == "사유를 선택하세요."){
    			alert("사유를 선택하여주세요.");
    			return;
    		}
    		let data = {"id" : $("#idInput").val(), "name" : $("#span").val(), "reason" : $("#reason").val()};
    		console.log(data);
    		
    		$.ajax({
				type: "post",
				url : "${pageContext.request.contextPath}/updateList.bl",
				data : data
			}).done(function(data){// 서버에 요청을 보내고 그 요청이 성공적을 이뤄졌을 때 응답값을 되돌려 받는 곳
				if(data == "success"){
					alert("블랙리스트에 추가되었습니다.");
					
					getBlackList();// 성공하면 블랙리스트에 추가되어 업로드
					
					
				}else if(data == "fail"){
					alert("추가에 실패하였습니다."); // 실패하면 alert 
				}
				$(location).attr("href", "${pageContext.request.contextPath}/toBlacklist.bl?currentPage=1");
			}).fail(function(e){// 서버에 요청이 실패했을 때 매개변수로 에러와 관련된 정보값이 담김
				console.log(e);
			})
    	});
    	
    	function getBlackList(){
    		let data = {"id" : $("#idInput").val(), "currentPage" : 1};
    		$.ajax({
				type: "post",
				url : "${pageContext.request.contextPath}/plusBlacklist.bl",
				data : data,
				dataType : "json"
			}).done(function(data){// 서버에 요청을 보내고 그 요청이 성공적을 이뤄졌을 때 응답값을 되돌려 받는 곳
				
				$("#plusBlacklist").empty();
				//$(".firstList").attr("hidden", true);
					for(let blacklist of data){
			            let list = "<tr class='firstList' style='text-align: center;'><td style='text-align: center;''><input type='checkbox' name='solcheck' id='solcheck' value= "+ blacklist.id +"></td>"
			            + "<td>" + blacklist.id + "</td>"
			            + "<td>" + blacklist.name + "</td>"
			            + "<td>" + blacklist.black_update + "</td>"
			            + "<td>" + blacklist.reason + "</td>"
			            + "</tr>"
		           
		            	$("#plusBlacklist").append(list);// 동적으로 블랙리스트 테이블 추가
			            
					}
	           	$("#idInput").val("");
	            $("#hiddenDiv").addClass("d-none");
	           
	            
			}).fail(function(e){// 서버에 요청이 실패했을 때 매개변수로 에러와 관련된 정보값이 담김
				console.log(e);
			})
    	}
    </script>
	</div>

	<div class="footer">
		<div class="row footer-top">
			<ul>
				<li><a href="">이용약관</a></li>
				<li><a href="">개인정보처리방침</a></li>
				<li><a href="">고객센터</a></li>
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
			if(admin_yn=='0'){
				alert("접근할 수 없습니다.");
				location.href="/index.jsp";
			}else if(admin_yn==''){
				alert("접근할 수 없습니다.");
				location.href="/index.jsp";
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
