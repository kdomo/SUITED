<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css"
	rel="stylesheet">
<script
	src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
</head>
<title>제품 코드 중복 확인</title>
</head>
<body>
	<form action="/product_codeCheckProc.pro" method="post" id="checkForm">
		<div class="container">
			<div class="row p-4">
				<input type="text" id="product_codeInput" class="form-control"
					placeholder="제품 코드 입력" name="product_codeInput"
					value="${product_codeInput}">
			</div>
			<div class="col-4 mb-4">
				<button type="button" id="btnCheck" class="btn btn-dark w-100">제품 코드 확인</button>
			</div>
		</div>
		<div class="row p-4">
			<div class="col mb-4">
				<h4>확인 결과 :</h4>
			</div>
		</div>
		<div class="row p-4">
			<div class="col mb-4">
				<c:if test="${rs eq 'available'}">
					<p id="rs">사용 가능한 제품 코드입니다.</p>
				</c:if>
				<c:if test="${rs eq 'unavailable'}">
					<p id="rs">사용 불가능한 제품 코드입니다.</p>
				</c:if>
			</div>
		</div>
		<div class="row p-4 justify-content-center">
			<div class="col-4 d-flex justify-content-end">
				<button type="button" id="btnCancel" class="btn btn-secondary">창닫기</button>
			</div>
			<div class="col-4 d-flex justify-content-start">
				<button type="button" id="btnSubmit" class="btn btn-dark">사용</button>
			</div>
		</div>
	</form>
	<script>
	    let rs = document.getElementById("rs");
	    let btnSubmit = document.getElementById("btnSubmit");
		let btnCancel = document.getElementById("btnCancel");
		let product_codeInput = document.getElementById("product_codeInput");
		let btnCheck = document.getElementById("btnCheck");
		
		// 제품 코드 확인 버튼을 눌렀을 때 submit에 대한 이벤트 처리
		btnCheck.addEventListener("click", function(){
			// 제품 코드 정규식 추가 (영문, 숫자만 10글자 이내로 사용가능)
			let regexId = /[a-zA-Z0-9]{1,10}/;
			if(!regexId.test(product_codeInput.value)){
				alert("제품 코드를 형식에 맞게 입력하세요. 영문자, 숫자만 사용 가능");
				return;
			}
			document.getElementById("checkForm").submit();
		});
		
		btnCancel.addEventListener("click", function(){
			self.close();// 현재 팝업창을 닫겠다. 
		})
		btnSubmit.addEventListener("click", function(){
			//opener.document.signupForm.id.value = idInput.value;
			opener.document.getElementById("product_code").value = product_codeInput.value;
			self.close();
		})
		
		if(rs.innerHTML == "사용 가능한 제품 코드입니다."){
			rs.style.color = "green";
		}else{
			rs.style.color = "red";
			btnSubmit.disabled = true;
		}
	</script>
</body>
</html>