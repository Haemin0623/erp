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
				
				<form action="" name="frm">
					주문번호<input type="text" name="orderNo" readonly="readonly"><br>
					발주일<input type="date" name="orderdate"><br>
					고객코드<input type="text" name="buyerCd"><br>
					상품코드<input type="text" name="productCd"><br>
					고객명<input type="text" name="buyerName"><br>
					상품명<input type="text" name="productName"><br>
					수량<input type="number" name="requestqty"><br>
					판매가<input type="number" name="price"><br>
					납품요청일<input type="date" name="requestdate"><br>
					비고<textarea rows="5" cols="40" name="remark"></textarea>
				</form>
				<button id="addItem">추가</button>
				<div id="addItemDiv">
				
					<table id="addItemTable">
						<tr>
							<th>상품코드</th>
							<th>수량</th>
							<th>판매가</th>
							<th>총액</th>
							<th>납품요청일</th>
							<th>비고</th>
							<th>삭제</th>
						</tr>
					</table>
				
					
					<button id="insertOrder">등록</button>
					
					 

`				</div>
				
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
	
	
	
	function changeTable() {
		const productCd = frm.productCd.value;
		const requestqty = frm.requestqty.value;
		const price = frm.price.value;
		const amount = requestqty * price;
		const requestdate = frm.requestdate.value;
		const remark = frm.remark.value;
		
		if (productCd == '' || requestqty == '' || price == '' || 
				amount == '' || requestdate == '' || remark == ''){
			alert('값을 채워넣어주세요');
		} else {
			
			$('#addItemTable').append(
					"<tr>" +
						"<td>" + productCd + "</td>" +
						"<td>" + requestqty + "</td>" +
						"<td>" + price + "</td>" +
						"<td>" + amount + "</td>" +
						"<td>" + requestdate + "</td>" +
						"<td>" + remark + "</td>" +
						"<td><button onclick='deleteItem(this)'>삭제</button></td>" +
					"</tr>"
			);
			frm.productCd.value = '';
			frm.requestqty.value = '';
			frm.price.value = '';
			frm.requestdate.value = '';
			frm.remark.value = '';
			
		}
		
	}
	
	document.querySelector("#addItem").addEventListener("click", changeTable);
	
	function deleteItem(e) {
		e.parentNode.parentNode.parentNode.removeChild(e.parentNode.parentNode);
		
	}
	
	
	function insertOrder() {
		const table = document.querySelector('#addItemTable');
		const rows = table.getElementsByTagName("tr");
		const tableLength = table.rows.length-1;
		
		const head = {
			orderNo: frm.orderNo.value,
			buyerCd: frm.buyerCd.value,
			orderdate: frm.orderdate.value
		};
		
		const items = new Array(table.rows.length-1);
		
		
		
		for (let i = 1; i < tableLength; i++) {
			let cells = rows[i].getElementsByTagName("td");
			
			items[i] = { 
				orderNo: frm.orderNo.value,
				productCd: cells[0].firstChild.data,
				requestqty: cells[1].firstChild.data,
				price: cells[2].firstChild.data,
				amount: cells[3].firstChild.data,
				requestdate: cells[4].firstChild.data,
				remark: cells[5].firstChild.data
			};
			
			console.log(items[i]);
		};
		
		console.log(items);
		
		$.ajax({
		     method: 'post',
		     url: 'orderInsert.do',
		     traditional: true,
		     data: {
		    	 head: JSON.sringify(head),
		    	 items: JSON.stringify(items)
		     },
		     dataType: 'json',
		     success: function (res) {
		        if (res.result) {
					pageView('order.do');
		        }
			}
	   });
	}
	
	document.querySelector("#insertOrder").addEventListener("click", insertOrder);
	
	
	// 등록 후 테이블에 추가하기
</script>

</html>