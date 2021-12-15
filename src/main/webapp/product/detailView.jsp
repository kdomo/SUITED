<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3"
	crossorigin="anonymous">
<script src="https://code.jquery.com/jquery-3.6.0.js"
	integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk="
	crossorigin="anonymous"></script>
<title>제품 상세</title>
<style>
.col {
	border: 0.5px solid gray;
}

.btn-container {
	padding-top: 10px;
	text-align: center;
}

.cmt-container {
	padding-top: 20px;
}

textarea {
	resize: none;
}

img{
    text-aling: center;
    width:300px;
    height:300px;
}
</style>
</head>
<body>
	<div class="container">
		<div class="row">
			<div class="col">
				<h2>${dto.getProduct_name()}</h2>
			</div>
			<div class="col">
				<div>${dto.getPrice()}\</div>
			</div>
		</div>
		<div class="row">
			<div class="col">	
			    <img alt="" src="${pageContext.request.contextPath}/product_img/${dto.getImg_system_name()}">
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
					<div class="col-11">
						<input type="text" id="comment" name="comment" placeholder="리뷰 입력"
							style="width: 100%">
					</div>
					<div class="col-1">
						<button type="button" id="btnSubmitCmt" class="btn btn-primary">등록</button>
					</div>
				</div>
				<input type="text" name="product_code"
					value="${dto.getProduct_code()}" hidden>
				<input type="text" name="currentPage" value="${currentPage}" hidden>
			</form>
		</div>
	</div>
	<div class="container btn-container">
		<button type="button" class="btn btn-secondary" id="toProductBtn">상품
			목록</button>
		<button type="button" class="btn btn-primary" id="buyBtn">즉시
			구매</button>
	</div>
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
				+ "<textarea class='form-control' name='comment' readonly>"
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