<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet"
        integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
<script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
<title>Insert title here</title>
</head>
<body>
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
	                    <button type="button" id="btnSearch" class="btn btn-primary">
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
                            <option value="1번 땡땡땡땡땡땡땡 이렇습니다.">1번 사유는 땡땡땡땡땡땡땡 이렇습니다.</option>
                            <option value="2번 땡땡땡땡땡땡땡 이렇습니다.">2번 사유는 땡땡땡땡땡땡땡 이렇습니다.</option>
                            <option value="3번 땡땡땡땡땡땡땡 이렇습니다.">3번 사유는 땡땡땡땡땡땡땡 이렇습니다.</option>
                            <option value="4번 땡땡땡땡땡땡땡 이렇습니다.">4번 사유는 땡땡땡땡땡땡땡 이렇습니다.</option>
                            <option value="5번 땡땡땡땡땡땡땡 이렇습니다.">5번 사유는 땡땡땡땡땡땡땡 이렇습니다.</option>
	                    </select>
	                </div>
	                <div class="col-2 plus_button_div" style="text-align: center;">
	                    <button type="button" id="btnPlus" class="btn btn-primary">
	                        <span>추가</span>
	                    </button>
	                </div>
                </div>
                <div class="row">
                    <div class="col-12 warning_div">
                        <p class="m-0">※ 블랙리스트는 ......이러한 기능들이 차단됩니다.</p>
                    </div>
                </div>
            </div>
        </div>
        <form id="blackForm" action="${pageContext.request.contextPath}/deleteProc.bl" method="post">
        <div class="row mt-5">
            <div class="col-12 list_all_div">
                <table class="table table-bordered">
                    <thead>
                        <tr style="text-align: center;">
                            <th class="col-1"><input type="checkbox" id="allcheck" name="allcheck"></th>
                            <th class="col-2">ID</th>
                            <th class="col-1">이름</th>
                            <th class="col-2">추가일</th> 
                            <th class="col-5">사유</th>
                            <th class="col-1">해제</th>
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
                        <tr class="firstList">
                            <td style="text-align: center;"><input type="checkbox" class="testaa" name="solcheck" value="${dto.getId()}"></td>
                            <td>${dto.getId()}</td>
                            <td>${dto.getName()}</td>
                            <td>${dto.getBlack_update()}</td>
                            <td>${dto.getReason()}</td>
                            <td>해제</td>
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
                <button type="button" id="btnDelete" class="btn btn-secondary">해제</button>
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
            <button type="button" id="searchBtn" class="btn btn-primary">검색</button>
            <button type="button" id="searchBtnAll" class="btn btn-secondary">전체보기</button>
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
			}).fail(function(e){// 서버에 요청이 실패했을 때 매개변수로 에러와 관련된 정보값이 담김
				console.log(e);
			})
			
    	});
    	
    	// 전체보기 버튼을 눌렀을 때
    	$("#searchBtnAll").on("click", function(){
    		$(location).attr("href", "${pageContext.request.contextPath}/toBlacklist.bl?currentPage=1");
    	});
    	
    	// 검색 버튼을 눌렀을 때
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
			            let list = "<tr><td style='text-align: center;''><input type='checkbox' name='solcheck' id='solcheck' value='${dto.getId()}'></td>"
			            + "<td>" + blacklist.id + "</td>"
			            + "<td>" + blacklist.name + "</td>"
			            + "<td>" + blacklist.black_update + "</td>"
			            + "<td>" + blacklist.reason + "</td>"
			            + "<td>해제</td></tr>"
		           
		            	$("#plusBlacklist").append(list);// 동적으로 블랙리스트 테이블 추가
					}
				}).fail(function(e){// 서버에 요청이 실패했을 때 매개변수로 에러와 관련된 정보값이 담김
					console.log(e);
				})
    	});
    	
	    
    
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
					}else if(name == "failMatch"){
						alert("이미 등록된 회원입니다.");
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
			            let list = "<tr class='firstList'><td style='text-align: center;''><input type='checkbox' name='solcheck' id='solcheck' value= "+ blacklist.id +"></td>"
			            + "<td>" + blacklist.id + "</td>"
			            + "<td>" + blacklist.name + "</td>"
			            + "<td>" + blacklist.black_update + "</td>"
			            + "<td>" + blacklist.reason + "</td>"
			            + "<td>해제</td></tr>"
		           
		            	$("#plusBlacklist").append(list);// 동적으로 블랙리스트 테이블 추가
					}
	           	$("#idInput").val("");
	            $("#hiddenDiv").addClass("d-none");
	           
	            
			}).fail(function(e){// 서버에 요청이 실패했을 때 매개변수로 에러와 관련된 정보값이 담김
				console.log(e);
			})
    	}
    </script>
</body>
</html>