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
	
	.scrollwrap {position: relative; display: block; width: 1000px; overflow-x: auto;}
	.scrollcontent {width: 2200px;}
	
</style>

<script type="text/javascript">

	function allCheck(allCheck)  {
		  const checkboxes 
		       = document.getElementsByName('check');
		  
		  checkboxes.forEach((checkbox) => {
		    checkbox.checked = allCheck.checked;
		  })
		}
</script>
	
</head>
<body>
	<h1>주문 현황</h1>

	<div id="searchBox">
		<form name="searchBoxx">		
			<div>
				주문번호 <input type="text" name="orderNo" value="${orderItem.orderNo }" >
				고객코드
					<select name="buyerCd">
						<option value="${orderItem.buyerCd }"></option>
							<c:forEach var="buyer" items="${buyerList}">
								<option value="${buyer.buyerCd}">${buyer.buyerCd}</option>
							</c:forEach>
					</select>
				고객명 
					<select name="bname">
						<option value="${orderItem.bname }"></option>
							<c:forEach var="buyer" items="${buyerList}">
								<option value="${buyer.bname}">${buyer.bname}</option>
							</c:forEach>
					</select>
				상품코드 <input type="text" name="productCd" value="${orderItem.productCd }" >
				상품명 <input type="text" name="pname" value="${orderItem.pname }">
				영업담당자코드 <input type="text" name="employeeCd" value="${orderItem.employeeCd }">
				영업담당자
					<select name="ename">
						<option value="${orderItem.ename }"></option>
							<c:forEach var="emp" items="${empList}">
								<c:if test="${emp.department=='영업'}">
									<option>${emp.ename} ${emp.job}(${emp.department})</option>
								</c:if>
							</c:forEach>
					</select>
				승인자코드영업담당자코드 <input type="text" name="signempCd" value="${orderItem.signempCd }">
				승인자
					<select name="signempName">
						<option value="${orderItem.signempCd }"></option>
							<c:forEach var="emp" items="${empList}">
								<c:if test="${emp.department=='영업'}">
									<option>${emp.ename} ${emp.job}(${emp.department})</option>
								</c:if>
							</c:forEach>
					</select>
				신청일<input type="date" name="orderFromDate" value=${orderItem.orderFromDate }>
					-<input type="date" name="orderToDate" value=${orderItem.orderToDate }>
				납품요청일<input type="date" name="requestFromDate" value="${orderItem.requestFromDate }">
					-<input type="date" name="requestToDate" value="${orderItem.requestToDate }">
				
				상태 
					<select name="status">
						<option value="${orderItem.status }"></option>
						<option value="null">모두</option>			
						<option value="승인요청">승인요청</option>
						<option value="승인">승인</option>
						<option value="반려">반려</option>
					</select>
				국가코드
					<select name="countryCd">
						<option value="${orderItem.countryCd }"></option>
							<c:forEach var="country" items="${countryList}">
								<option>${country.cname}(${country.countryCd})</option>
							</c:forEach>
					</select>
			</div>
		</form>
			<button id="searchBtn">검색</button>
	</div>	
	
	<div class="scrollwrap">
		<table class="scrollcontent">
			<tr>
				<th><input type="checkbox" name="check" value="allcheck" onclick="allCheck(this)"></th>
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
		<c:forEach var="item" items="${orderStatusList}">
			<tr>
				<td><input type="checkbox" name="check"></td>
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
			<%-- 	<td>${item.signempCd }</td> --%>
				 		<c:if test="${item.signempCd==null }">
				 			<td>예정</td>
				 		</c:if>
				 	<c:forEach var="emp" items="${empList}">
						<c:if test="${item.signempCd ==emp.employeeCd}">
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
			</tr>
		</c:forEach>
		</table>
	</div>
	<p class="scroll"></p>



</body>

<script type="text/javascript">
	
	function search() {
		const keyword = {
			orderNo : searchBoxx.orderNo.value,	
			buyerCd : searchBoxx.buyerCd.value,	
			bname : searchBoxx.bname.value,
			productCd : searchBoxx.productCd.value,	
			pname : searchBoxx.pname.value,	
			employeeCd : searchBoxx.employeeCd.value,
			ename : searchBoxx.ename.value,
			signempCd : searchBoxx.signempCd.value,
			signempName : searchBoxx.signempName.value,
			orderFromDate : searchBoxx.orderFromDate.value,	
			orderToDate : searchBoxx.orderToDate.value,	
			requestFromDate : searchBoxx.requestFromDate.value,
			requestToDate : searchBoxx.requestToDate.value,
			status : searchBoxx.status.value,
			countryCd : searchBoxx.countryCd.value
			
		}
		console.log(keyword);
		
		$.ajax({
		     method: 'post',
		     url: 'orderStatusSearch.do',
		     traditional: true,
		     data: {
		    	keywordd: JSON.stringify(keyword)
		     },
		     success: function (result) {
		    	 $('#content').children().remove();
				 $('#content').html(result);
			 }
	   });
	}
	
	document.querySelector("#searchBtn").addEventListener("click", search);

</script>
</html>