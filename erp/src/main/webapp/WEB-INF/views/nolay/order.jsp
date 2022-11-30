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
					<td class="editable"><input type="checkbox" value="${head.orderNo }"></td>
					<td class="editable">${head.orderNo }</td>
					<td class="editable">${head.buyerCd }</td>
					<td class="editable">${head.orderdate }</td>
					<td class="editable">${head.employeeCd }</td>
					<td class="editable">${head.status }</td>
					<td class="editable">${head.statusdate }</td>
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
		console.log(rows);
		
		const head = {
			orderNo: frm.orderNo.value,
			buyerCd: frm.buyerCd.value,
			orderdate: frm.orderdate.value
		};
		
		const items = new Array(tableLength);
		
		
		
		for (let i = 0; i < tableLength; i++) {
			let cells = rows[i+1].getElementsByTagName("td");
			
			items[i] = { 
				orderNo: frm.orderNo.value,
				productCd: cells[0].firstChild.data,
				requestqty: cells[1].firstChild.data,
				price: cells[2].firstChild.data,
				amount: cells[3].firstChild.data,
				requestdate: cells[4].firstChild.data,
				remark: cells[5].firstChild.data
			};
			console.log('야호');
			console.log(items[i]);
		};
		
		console.log(items);
		
		$.ajax({
		     method: 'post',
		     url: 'orderInsert.do',
		     traditional: true,
		     data: {
		    	 head: JSON.stringify(head),
		    	 items: JSON.stringify(items)
		     },
		     dataType: 'json',
		     success: function (result) {
		        if (result) {
					callView('order.do');
		        } else {
		        	alert("실패");
		        }
			}
	   });
	}
	
	document.querySelector("#insertOrder").addEventListener("click", insertOrder);
	
	function search() {
		const orderNo = searchBoxx.orderNo.value;	
		const buyerCd = searchBoxx.buyerCd.value;	
		const orderFromDate = searchBoxx.orderFromDate.value;	
		const orderToDate = searchBoxx.orderToDate.value;	
		const employeeCd = searchBoxx.employeeCd.value;	
		const status = searchBoxx.status.value;	
		const productCd = searchBoxx.productCd.value;	
		const requestdate = searchBoxx.requestdate.value;
		console.log(orderNo);
		console.log(buyerCd);
		console.log(orderFromDate);
		console.log(orderToDate);
		console.log(employeeCd);
		console.log(status);
		console.log(productCd);
		console.log(requestdate);
		$.ajax({
		     method: 'post',
		     url: 'order.do',
		     traditional: true,
		     data: {
		    	 orderNo: orderNo,
		    	 buyerCd: buyerCd,
		    	 orderFromDate: orderFromDate,
		    	 orderToDate: orderToDate,
		    	 employeeCd: employeeCd,
		    	 status: status,
		    	 productCd: productCd,
		    	 requestdate: requestdate
		     },
		     success: function (result) {
		    	 $('#content').children().remove();
				 $('#content').html(result);
			 }
		     
		     
	   });
	}
	
	document.querySelector("#searchBtn").addEventListener("click", search);
</script>

<!-- 테이블 요소 더블클릭 하면 수정 가능 input으로 변경 -->
<script>
    $(document).ready(function() {
        $(document).on("dblclick", ".editable", function() {
            var value=$(this).text();
            var input="<input type='text' class='input-data' value='"+value+"' class='form-control'>";
            $(this).html(input);
            $(this).removeClass("editable")
        });
        $(document).on("blur", ".input-data", function() {
            var value=$(this).val();
            var td=$(this).parent("td");
            $(this).remove();
            td.html(value);
            td.addClass("editable")
            });
        $(document).on("keypress", ".input-data", function(e) {
            var key=e.which;
            if(key==13) {
                var value=$(this).val();
                var td=$(this).parent("td");
                $(this).remove();
                td.html(value);
                td.addClass("editable");
            }
        });
   });
</script>

</html>