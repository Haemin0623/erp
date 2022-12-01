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
<div id="container">
	<h1>주문 승인</h1>
	
	<div id="searchBox">
		<form name="searchBoxx">		
			주문번호<input type="text" name="orderNo" value="${orderHead.orderNo }">
			고객코드<input type="text" name="buyerCd" value="${orderHead.buyerCd }">
			신청일<input type="date" name="orderFromDate" value=${orderHead.orderFromDate }>
			~<input type="date" name="orderToDate" value=${orderHead.orderToDate }>
			신청인<input type="text" name="employeeCd" value="${orderHead.employeeCd }">
			
			<select name="status">
				<option value="null">모두</option>			
				<option value="승인대기">승인대기</option>
				<option value="승인요청">승인요청</option>
				<option value="승인">승인</option>
				<option value="반려">반려</option>
			</select>
			
			상품코드<input type="text" name="productCd">
			납품요청일<input type="date" name="requestdate">
			
		</form>
			<button id="searchBtn">검색</button>
	</div>
	
	
	<div id="table">
		<table id="list">
			<tr>
				<th>선택</th>
				<th>주문번호</th>
				<th>고객코드</th>
				<th>주문일</th>
				<th>작성자</th>
				<th>상태</th>
				<th>상태변경일</th>
				<th>사유</th>
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
					<td style="text-align: center;">
						<c:if test="${head.reason == null}">
							<input type="hidden" value="${head.reason }">-
						</c:if>
						<c:if test="${head.reason != null}">
							<input type="hidden" value="${head.reason }">${head.reason }
						</c:if>
					</td>
				</tr>
			</c:forEach>
		</table>
	</div>
		
<br>
<hr>
<br>



		<div class="statusWindow" id="table">
			<table id="list">
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
			</table>
			<div>
				<button class='orderApproval' name='btn' value='승인'>승인</button>
				<button class='orderApproval' name='btn' value='반려'>반려</button>
			</div>
		</div>
		
</div>	
</body>

		
<script type="text/javascript">

	function callView(request) {
		var addr = request;
	
		var ajaxOption = {
			url : request,
			async : true,
			type : "POST",
			dataType : "html",
			cache : false
		};
	
		$.ajax(ajaxOption).done(function(data) {
			$('#content').children().remove();
			$('#content').html(data);
		});
	}
	
	/* search */
	function search() {
				
		const keyword = {
			orderNo : searchBoxx.orderNo.value,	
			buyerCd : searchBoxx.buyerCd.value,	
			orderFromDate : searchBoxx.orderFromDate.value,	
			orderToDate : searchBoxx.orderToDate.value,	
			employeeCd : searchBoxx.employeeCd.value,	
			status : searchBoxx.status.value,	
			productCd : searchBoxx.productCd.value,	
			requestdate : searchBoxx.requestdate.value,
			window : '주문승인'
		}
		console.log(keyword);
		
		$.ajax({
		     method: 'post',
		     url: 'orderSearch.do',
		     traditional: true,
		     data: {
		    	keyword: JSON.stringify(keyword)
		     },
		     success: function (result) {
		    	 $('#content').children().remove();
				 $('#content').html(result);
			 }
	   });
	}
	
	document.querySelector("#searchBtn").addEventListener("click", search);
	
	
	/* 행 색상 */
	$("#table tr").on( "click", function() {
		$(".itemRow").removeClass('clickColor');
	    $(this).addClass('clickColor');
	});

	/* head 행 클릭시 itemList */
	$('.itemRow').on('click', function() {
		
		$('#statusTable').empty();
		$('#area').empty();
		
		let thisRow = $(this).closest('tr');
		let orderNo = thisRow.find('td:eq(0)').find('input').val();
		let status = thisRow.find('td:eq(5)').find('input').val();
		let reason = thisRow.find('td:eq(7)').find('input').val();
		
		/* console.log(reason); */
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
				
					
				
				}
					if (status == "승인요청") {
						
						$('#area').append(
							"<tr>" +
							"<td colspan='8'><textarea rows='5' cols='70' name='reason' id='reason'></textarea></td>"+
							"</tr>"
						);
	
					} else if (status == "승인" || status == "반려" ) {
						if (reason != "") {
								
							$('#area').append(
								"<tr>" +
								"<td colspan='8'><textarea rows='5' cols='70' name='reason' id='textarea' readonly style='background-color:silver;'></textarea></td>"+
								"</tr>"
							);
							$('#textarea').val(reason);
						}
					} else if (status == "승인대기" ) {
						if (reason == "") {
								
							$('#area').append(
								"<tr>" +
								"<td colspan='8'><textarea rows='5' cols='70' name='reason' id='textarea' readonly style='background-color:silver;'></textarea></td>"+
								"</tr>"
							);
							$('#textarea').val("승인 대기 중");
						}
					
					}
			}, error : function(error) {
					alert("error"+error);
					console.log("에러");
			}
		})
	});
	
	/* 승인 or 반려 */
	$('.orderApproval').on("click", function() {
		
		let thisRow = $('.clickColor').closest('tr');
		let orderNo = thisRow.find('td:eq(0)').find('input').val();
		
		console.log(orderNo);
		console.log("1");
		
		let writeReason = $('#reason').val();
		console.log(writeReason);
		console.log("2");
		console.log(reason);
		console.log("3");
		
		let btnValue = $('button[name=btn]').val();
		console.log(btnValue);
		console.log("4");
		
		$.ajax({
			method: 'post',
			url: 'orderApproval.do',
			data: {
				"orderNo":orderNo,
				"reason":writeReason,
				"btnValue":btnValue
				},
				
			success: function(data) {
				console.log("된듯");
				callView('orderApprovalWindow.do');
				
			}, error: function (xhr, status, error) {
				console.log("error");
			}
		});
	
	});
</script>


</html>