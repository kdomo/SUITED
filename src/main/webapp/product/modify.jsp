	<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css"
	integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm"
	crossorigin="anonymous">
<script src="https://code.jquery.com/jquery-3.6.0.js"
	integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk="
	crossorigin="anonymous"></script>
<title>상품 수정</title>
<style>
.container {
	text-align: center;
}

textarea {	
	width: 800px;
	height: 500px;
	resize: none;
}

.row {
	padding: 20px;
}
</style>
</head>
<body>
<c:if test="${product_code eq '없음'}">
    <script>
        alert("상품 코드가 존재하지 않습니다.");
    </script>
</c:if>
	<div class="container">
		<div class="row">
			<div class="col">
				<h2>상품 수정</h2>
			</div>
		</div>
		<form action="${pageContext.request.contextPath}/confirm.pro"
		    method="post" id="confirmForm" name="confirmForm"> <!-- 확인 버튼으로 상품코드 제출 -->
		    <div class="row">
			    <div class="col-3">상품코드</div>
			    <div class="col-4">
				    <input type="text" class="form-control" id="product_code"
					name="product_code" value="${dto.getProduct_code()}" placeholder="수정할 상품의 코드를 입력하세요.">
			    </div>
			    <div class="col-3">
			        <button type="button" class="btn btn-warning" id="confirmBtn">확인</button>
				    <button type="button" id="resetBtn" class="btn btn-danger">리셋</button>
			    </div>
		    </div>
		</form>
		<form action="${pageContext.request.contextPath}/modifyProc.pro"
			method="post" id="modifyForm" name="modifyForm" enctype="multipart/form-data"> <!-- 수정 될 내용 전송 -->
			<input type="text" name="product_code" value="${dto.getProduct_code()}" hidden>
			<div class="row">
				<div class="col-3">상품명</div>
				<div class="col-9">
					<input type="text" class="form-control" id="product_name"
						name="product_name" value="${dto.getProduct_name()}">
				</div>
			</div>
			<div class="row">
				<div class="col-3">상품 가격</div>
				<div class="col-9">
					<input type="text" class="form-control" id="price" name="price" value="${dto.getPrice()}">
				</div>
			</div>
			<div class="row">
				<div class="col-3">상품 이미지</div>
				<div class="col-9">
					<input type="file" name="productIMG">
				</div>
			</div>
			<div class="row">
				<div class="col-3">상품 간단 설명</div>
				<div class="col-9">
					<textarea id="simple_content" name="simple_content">${dto.getSimple_content()}</textarea>
				</div>
			</div>
			<div class="row">
				<div class="col-3">상품 상세 설명</div>
				<div class="col-9">
					<textarea id="main_content" name="main_content">${dto.getMain_content()}</textarea>
				</div>
			</div>
			<div class="row">
				<div class="col">
					<button type="button" id="cancelBtn" class="btn btn-secondary">취소</button>
					<button type="button" id="modifyBtn" class="btn btn-primary">수정</button>
				</div>
			</div>
		</form>
	</div>
	<script>
	// 확인 버튼
	document.getElementById("confirmBtn").addEventListener("click", function(){
    	if(document.getElementById("product_code").value == ""){
        	alert("상품 코드를 입력해주세요.");
        	return;
        } else{
        	document.getElementById("confirmForm").submit();
        }
    });
	
	// 수정 버튼
    document.getElementById("modifyBtn").addEventListener("click", function(){
    	if(document.getElementById("product_name").value == "" || document.getElementById("price").value == ""
    			|| document.getElementById("simple_content").value == "" || document.getElementById("main_content").value == ""){
    		alert("비어있는 내용이 있습니다.");
    		return;
    	}
    	document.getElementById("modifyForm").submit();
    })
    
    // 취소 버튼
    document.getElementById("cancelBtn").addEventListener("click", function(){
    	location.href = "${pageContext.request.contextPath}/toProduct.pro?currentPage=1";
    })
    
    // 리셋 버튼
    document.getElementById("resetBtn").addEventListener("click", function(){
    	location.href = "${pageContext.request.contextPath}/toModify.pro";
    })
	</script>
</body>
</html>