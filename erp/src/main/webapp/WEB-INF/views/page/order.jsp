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
		margin: 0 auto;
		width: 90%;
		height: 100px;
		background-color: gray;
		color: white;
	}
	
	table {
		border: 1px solid;
	}
	

	
	.background {
	  position: fixed;
	  top: 0;
	  left: 0;
	  width: 100%;
	  height: 100vh;
	  background-color: rgba(0, 0, 0, 0.3);
	  z-index: 1000;
	  
	  /* 숨기기 */
	  z-index: -1;
	  opacity: 0;
	}
	
	.window {
	  position: relative;
	  width: 100%;
	  height: 100%;
	}
	
	.popup {
	  position: absolute;
	  top: 50%;
	  left: 50%;
	  transform: translate(-50%, -50%);
	  background-color: #ffffff;
	  box-shadow: 0 2px 7px rgba(0, 0, 0, 0.3);
	  
	  /* 임시 지정 */
	  width: 500px;
	  height: 500px;
	  
	  /* 초기에 약간 아래에 배치 */
	  transform: translate(-50%, -40%);
	}
	
	.show {
	  opacity: 1;
	  z-index: 1000;
	  transition: all .5s;
	}
	
	.show .popup {
	  transform: translate(-50%, -50%);
	  transition: all .5s;
	}
	
	#item {
		border: 1px solid;
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
	
	<%-- <div id="item">
		<table><caption>주문번호 : </caption>
			<tr>
				<th>선택</th>
				<th>상품코드</th>
				<th>수량</th>
				<th>판매가</th>
				<th>총액</th>
				<th>비고</th>
				<th>수정</th>
				<th></th>
			</tr>
			<c:foreach>
				<tr>
					<td><input type="checkbox" value> </td>
					<td></td>
					<td></td>
					<td></td>
					<td></td>
					<td></td>
					<td></td>
					<td></td>
					<td></td>
				</tr>
			</c:foreach>
		</table>
	</div> --%>

	<!-- 등록 창 팝업 -->
	<div class="background">
		<div class="window">
			<div class="popup">
				<button id="close">팝업닫기</button>
				
				<form action="">
					주문번호<input type="text" readonly="readonly">
					발주일<input type="date" name="orderdate">
					고객코드<input type="text" name="buyerCd">
					상품코드<input type="text" name="productCd">
					고객명<input type="text" name="buyerName">
					상품명<input type="text" name="productName">
					수량<input type="number" name="requestqty">
					판매가<input type="number" name="price">
					납품요청일<input type="date" name="requestdate">
					비고<textarea rows="5" cols="40" name="remark"></textarea>
				</form>
				<button id="addItem">추가</button>
				
				<table><caption>주문번호 : </caption>
					<tr>
						<th>선택</th>
						<th>상품코드</th>
						<th>수량</th>
						<th>판매가</th>
						<th>총액</th>
						<th>납품요청일</th>
						<th>비고</th>
						<th>삭제</th>
					</tr>
						<tr>
							<td><input type="checkbox" value> </td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
						</tr>
				</table>
				
			</div>
		</div>
	</div>

</body>

<script type="text/javascript">
	// 등록 팝업 열기 닫기
	function show() {
		document.querySelector(".background").className = "background show";
	}
	
	function close() {
		document.querySelector(".background").className = "background";
	}
	
	document.querySelector("#show").addEventListener("click", show);
	document.querySelector("#close").addEventListener("click", close);
	  
	document.querySelector("#show").addEventListener("click", show);
</script>

</html>