<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../layoutElement/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

	<table>
		<tr>
			<th>상품코드</th>
			<th>수량</th>
			<th>판매가</th>
			<th>총액</th>
			<th>납품요청일</th>
			<th>비고</th>
			<th>삭제</th>
		</tr>
		<c:forEach var="item" items="${itemList }">
			<tr>
				<td>${item.productCd }</td>
				<td>${item.requestqty }</td>
				<td>${item.price }</td>
				<td>${item.amount }</td>
				<td>${item.requestdate }</td>
				<td>${item.remark }</td>
				<td><button>${item.orderNo }</button></td>
			</tr>
		</c:forEach>
	</table>

</body>
</html>