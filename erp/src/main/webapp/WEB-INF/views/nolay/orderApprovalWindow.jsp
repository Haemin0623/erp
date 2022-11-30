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
	
/* 마우스 오버(마우스 올렸을때) */
tr{
color: black;
}
tr:hover{
    background-color: #f4f4f4;
    cursor: pointer;
}
/* 마우스 클릭하고있을때 */
tr:active{
    background-color: #B9E2FA;
}

.clickColor {
	background-color: #B9E2FA;
	
}
</style>

</head>
<body>
	<h1>주문 승인</h1>
	
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
	
	
	<div id="table">
		<table>
			<tr>
				<th>선택</th>
				<th>주문번호</th>
				<th>고객코드</th>
				<th>주문일</th>
				<th>작성자</th>
				<th>상태</th>
				<th>상태변경일</th>
			</tr>
			<c:forEach var="head" items="${headList }">			
				<tr class="itemRow">
					<td><input type="checkbox" value="${head.orderNo }"></td>
					<td>${head.orderNo }</td>
					<td>${head.buyerCd }</td>
					<td>${head.orderdate }</td>
					<td>${head.ename } ${head.job } (${head.department })</td>
					<td><input type="hidden" value="${head.status }">${head.status }</td>
					<td>${head.statusdate }</td>
				</tr>
			</c:forEach>
		</table>
	</div>
		
<br>
<hr>
<br>



		<div class="statusWindow">
			<table>
<%-- 				<tr>
					<th>주문번호</th>
					<td>${head.orderNo }</td>
					<th>주문일</th>
					<td>${head.orderdate }</td>
					<th>고객코드</th>
					<td>${head.buyerCd }</td>
					<th>작성자</th>
					<td>${head.employeeCd } <!-- 쿼리수정해서이름도? --></td>
				</tr> --%>
				<tr>
					<th>No.</th>
					<th>상품코드</th>
					<th>상품명</th>
					<th>주문수량</th>
					<th>납품요청일</th>
					<th>가격</th>
					<th>합계</th>
					<th>비고</th>
				</tr>
				<tbody id="statusTable"/>
				<tbody id="area"/>
				<tbody id="updateBtn"/>
				
			<!-- 	<tr>
					<td colspan="6"><textarea rows="5" cols="40" name="reason"></td>
					<th><button onclick="updateStatus"></button></th>
					<th><button></button></th>
				</tr> -->
			</table>
		</div>
		
		
</body>

		
<script type="text/javascript">

	$("#table tr").on( "dblclick", function() {
		$(".itemRow").removeClass('clickColor');
	    $(this).addClass('clickColor');
	});

	
	$('.itemRow').on('dblclick', function() {
		
		$('#statusTable').empty();
		$('#updateBtn').empty();
		
		let thisRow = $(this).closest('tr');
		let orderNo = thisRow.find('td:eq(0)').find('input').val();
		let status = thisRow.find('td:eq(5)').find('input').val();
		
		/* console.log(status); */
		/* alert(orderNo); */
		
		$.ajax({
			method: 'post',
			url: 'orderItemList.do',
			data: {"orderNo":orderNo},
			
			success: function(data) {
				for(var i=0 in data) {
					var x = parseInt(i)+1;
					
					let dateFormat = new Date(data[i].requestdate);
					let year = dateFormat.getFullYear();
					let month = dateFormat.getMonth() + 1;  /* 월은 0부터 시작, +1 */
					let date = dateFormat.getDate(); 
					
					/* let reqDate = year+"-"+month+"-"+date; */
					let reqDate = year+"-"+(("00"+month.toString()).slice(-2))+"-"+(("00"+date.toString()).slice(-2));
					console.log(reqDate);
					
					$('#statusTable').append(
						"<tr>" +
							"<td>" + x + "</td>" +
							"<td>" + data[i].productCd + "</td>" +
							"<td>" + data[i].pname + "</td>" +
							"<td>" + data[i].requestqty + "</td>" +
							"<td>" + reqDate + "</td>" +
							"<td>" + data[i].price + "</td>" +
							"<td>" + data[i].amount + "</td>" +
							"<td>" + data[i].remark + "</td>" +
						"</tr>"
					);
				
					if (status == "승인요청") {
						
						$('#area').append(
							"<tr>" +
							"<td colspan='8'><textarea rows='5' cols='50' name='reason' id='reason'></textarea></td>"+
							"</tr>"
						);
	
					} else if (status == "승인" or status == "반려") {
						
						$('#area').append(
							"<tr>" +
							"<td colspan='8'><textarea rows='5' cols='50' name='reason' value="+data[i].reason+"></textarea></td>"+
							"</tr>"
						);
					}
					
	$('#updateBtn').append(
			"<tr>" +
				"<td colspan='3'></td>"+
				"<td><button id='orderApprovall' >승인</button></td>"+
				"<td><button onclick='orderReturn("+ data[i].orderNo +")'>반려</button></td>"+
			"<td colspan='3'></td>"+
			"</tr>"
	);
				
				}
			}, error : function(error) {
					alert("error"+error);
					console.log("에러");
			}
		})
	});
	
	
	
	
	$('#orderApprovall').on("click", function(orderNo) {
		
		console.log(orderNo);
		console.log(reason);
		alert(reason);
		$.ajax({
			method: 'post',
			url: 'orderApproval.do',
			data: {
				orderNo:orderNo,
				reason:reason 
				},
			success: function(data) {
				console.log(data)
			}
		});
	
	});
	
</script>


</html>