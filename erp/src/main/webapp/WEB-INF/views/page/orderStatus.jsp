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
	<h1>주문 현황</h1>

	<div id="searchBox">
		<form action="">		
			<div>
				주문번호 <input type="text" name="orderSearch">
				상품코드(명) <input type="text" name="productSearch" placeholder="상품코드/상품명">
				고객코드(명)
					<select>
						<c:forEach var="buyer" items="${buyerList}">
							<option>${buyer.buyerCd}(${buyer.name})</option>
						</c:forEach>
					</select>
				영업담당자
					<select>
						<c:forEach var="emp" items="${empList}">
							<c:if test="${emp.department=='영업'}">
								<option>${emp.name} ${emp.job}(${emp.department})</option>
							</c:if>
						</c:forEach>
					</select>
				승인자
					<select>
						<c:forEach var="emp" items="${empList}">
							<c:if test="${emp.department=='관리'}">
								<option>${emp.name} ${emp.job}(${emp.department})</option>
							</c:if>
						</c:forEach>
					</select>
				신청일 <input type="date" name="addDateSearch1"> - <input type="date" name="addDateSearch2">
				납품요청일 <input type="date" name="reqDateSearch1"> - <input type="date" name="reqDateSearch2">
				상태 
					<select>
						<option value="" selected="selected">전체 보기
<!-- 						<option value="승인대기">승인대기 	주문현황이라 아직 요청 전인 승인 대기는 안 보이도록 할 생각-->
						<option value="승인요청">승인요청
						<option value="승인">승인
						<option value="반려">반려
						<option value="삭제">삭제
					</select>
				국가코드
					<select>
						<c:forEach var="country" items="${countryList}">
							<option>${country.name}(${country.countryCd})</option>
						</c:forEach>
					</select>
				단어 검색 <input type="text" name="wordSearch">
				<input type="submit" value="검색">
			</div>
		</form>
	</div>	<!-- searchBox -->
	
	<div id="table">
		<table style="border: 1px;">
			<tr>
				<th><input type="checkbox"></th>
				<th>주문일</th>
				<th>주문번호</th>
				<th>상품코드</th>
				<th>상품명</th>
				<th>주문수량</th>
				<th>판매가</th>
				<th>금액 합계</th>
				<th>영업담당자</th>
				<th>상태</th>
				<th>상태변경일</th>
				<th>승인자</th>
				<th>납품요청일</th>
				<th>고객코드</th>
				<th>고객명</th>
				<th>고객담당자</th>
				<th>고객연락처</th>
				<th>고객이메일</th>
				<th>비고</th>
				
				
			</tr>
			<tr>
			<c:forEach var="item" items="${orderStatusList}">
				<td>${item.orderdate }</td>
				<td>${item.orderNo }</td>
				<td>${item.productCd }</td>
				<td>${item.pname }</td>
				<td>${item.requestqty }</td>
				<td>${item.price }</td>
				<td>${item.amount }</td>
				<td>${item.ename }</td>
				<td>${item.status }</td>
				<td>${item.statusdate }</td>
					<c:forEach var="emp" items="${empList}">
						<c:if test="${item.signempCd }==${emp.employeeCd}">
							<td>${emp.ename }</td>
						</c:if>
					</c:forEach>
				<td>${item.requestdate }</td>
				<td>${item.buyerCd }</td>
				<td>${item.bname }</td>
				<td>${item.manager }</td>
				<td>${item.tel }</td>
				<td>${item.email }</td>
				<td>${item.remark }</td>
			</c:forEach>
			</tr>
		</table>
	</div>



</body>
</html>