<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../layoutElement/taglib.jsp"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<style type="text/css">

	#searchBox{
		width: 
	}
	
</style>

</head>
<body>
	<h1>주문 관리</h1>
	
	<div id="searchBox">
		<form action="">		
			주문번호<input type="number" name="orderNo">
			고객코드<input type="text" name="buyerCd">
			신청일<input type="date" name="orderDate">
			상품코드<input type="text" name="productCD">
			납품요청일<input type="date" name="requestDate">
			<input type="submit" value="검색">
		</form>
	</div>
	
	<button id="show">추가 </button>
	
	<div id="table">
		<table>
			<tr>
				<th>선택</th>
				<th>주문번호</th>
				<th>고객코드</th>
				<th>신청일</th>
				<th>신청인</th>
				<th>상태</th>
				<th>상태변경일</th>
				<th>버튼</th>
			</tr>
			<c:forEach var="head" items="${headList }">			
				<tr>
					<td><input type="checkbox" value="${head.orderNo }"></td>
					<td>${head.orderNo }</td>
					<td>${head.buyerCd }</td>
					<td>${head.orderdate }</td>
					<td>${head.employeeCd }</td>
					<td>${head.status }</td>
					<td>${head.statusdate }</td>
					<td><button>예시</button></td>
				</tr>
			</c:forEach>
		</table>
	</div>
	
</body>
</html>