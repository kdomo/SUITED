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
<title>상품 삭제</title>
<style>
.container {
	width: 1000px;
	text-align: center;
}

#product_code {
	width: 300px;
	margin: auto;
}
</style>
</head>
<body>
	<c:if test="${product_code eq '없음'}">
		<script>
			alert("상품 코드가 존재하지 않습니다.");
		</script>
	</c:if>
	<form
		action="${pageContext.request.contextPath}/deleteProc.pro?currentPage=1"
		method="post" id="deleteForm" name="deleteForm">
		<div class="container">
			<div class="row">
				<div class="col">
					<h2>상품 삭제</h2>
				</div>
			</div>
			<div class="row">
				<div class="col" style="text-align: center;">
					<input type="text" class="form-control" id="product_code"
						name="product_code" placeholder="삭제할 상품의 코드를 입력하세요.">
				</div>
			</div>
			<div class="row">
				<div class="col" style="padding: 10px;">
					<button type="button" class="btn btn-secondary" id="cancelBtn">취소</button>
					<button type="button" class="btn btn-warning" id="confirmBtn">확인</button>
				</div>
			</div>
		</div>
	</form>
	<div class="container">
		<div class="row">
			<div class="col">
				<table class="table table-bordered">
					<thead>
						<tr>
							<th class="col-3">제품 코드</th>
							<th class="col-3">제품명</th>
							<th class="col-3">가격</th>
							<th class="col-3">등록일</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${list}" var="dto">
							<tr>
								<td>${dto.getProduct_code()}</td>
								<td>${dto.getProduct_name()}</td>
								<td>${dto.getPrice()}</td>
								<td>${dto.getWritten_product_date()}</td>
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
							href="${pageContext.request.contextPath}/deleteProc.pro?currentPage=${naviMap.get('startNavi')-1}">Previous</a>
					</c:if>
					<c:forEach var="i" begin="${naviMap.get('startNavi')}"
						end="${naviMap.get('endNavi')}">
						<li class="page-item"><a class="page-link"
							href="${pageContext.request.contextPath}/deleteProc.pro?currentPage=${i}">${i}</a></li>
					</c:forEach>
					<c:if test="${naviMap.get('needNext') eq true}">
						<li class="page-item"><a class="page-link"
							href="${pageContext.request.contextPath}/deleteProc.pro?currentPage=${naviMap.get('endNavi')+1}">Next</a></li>
					</c:if>
				</ul>
			</nav>
		</div>
	</div>
	<script>
		document.getElementById("confirmBtn").onclick = function() {
			if (document.getElementById("product_code").value == "") {
				alert("상품 코드를 입력하세요.");
				return;
			}
			let rs = confirm("상품코드 : "
					+ document.getElementById("product_code").value
					+ "를 정말 삭제하시겠습니까?");
			if (rs) {
				document.getElementById("deleteForm").submit();
			}
		}

		document.getElementById("cancelBtn").onclick = function() {
			location.href = "${pageContext.request.contextPath}/toProduct.pro?currentPage=1";
		}
	</script>
</body>
</html>