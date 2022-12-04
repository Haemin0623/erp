<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../layoutElement/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<style type="text/css">

	input:disabled {
		background: red;
	}

	#container {
		margin-left: 50px;
	}

	#searchBox {
 		height: 150px;
 		width: 120vh;
		background: #5b6996;
		margin-top: 50px;
		color: white;
	}	
	
	#table{
		overflow: auto;
		height: 40vh;
		width: 120vh;
	}
	
	tr th {
		background: #5b6996;
		color: white;
	}
	
	#list {
		width: 100%;
		border: 1px solid;
		
	}
	
	.statusWindow {
		overflow: auto;
		height: 40vh;
		width: 120vh;	
	}
	
	#statusList {
		width: 100%;
		border: 1px solid;
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
	
	
	.sumo {
		color : black;
	}
	li.opt {
		color : black;
	}
	
	
	.fixed {
		position: sticky;
		top: 0;
	}
	
	
	
	
</style>

</head>
<body>
<div id="container">	
	<h1>주문 관리</h1>
	<div id="searchBox">
		<form name="searchBoxx">	
			<!-- 정렬용 -->
			<input type="hidden" name="sortOrderNo" value="${orderHead.sortOrderNo }">
			<input type="hidden" name="sortBuyerCd" value="${orderHead.sortBuyerCd }">
			<input type="hidden" name="sortOrderDate" value="${orderHead.sortOrderDate }">
			<input type="hidden" name="sortEmployeeCd" value="${orderHead.sortEmployeeCd }">
			<input type="hidden" name="sortStatus" value="${orderHead.sortStatus }">
			<input type="hidden" name="sortStatusDate" value="${orderHead.sortStatusDate }">
				
			주문번호<input type="text" name="orderNo" value="${orderHead.orderNo }">
			고객코드
			<select name="buyerCd" class="sumoBuy sumo">
				<option value="All"></option>
				<c:forEach var="buyer" items="${buyerEx }">
					<option value="${buyer.buyerCd }">${buyer.buyerCd }(${buyer.bname })</option>
				</c:forEach>
			</select>
			신청인
			<select name="employeeCd" class="sumoEmp sumo">
				<option value="All"></option>
				<c:forEach var="employee" items="${employeeEx }">
					<option value="${employee.employeeCd }">${employee.employeeCd }(${employee.ename })</option>
				</c:forEach>
			</select>
			
			신청일<input type="date" name="orderFromDate" value="${orderHead.orderFromDate }">
			~<input type="date" name="orderToDate" value="${orderHead.orderToDate }"><p>
			상태
			<select name="status">
				<option value="null">모두</option>		
				<option value="승인대기" <c:if test="${orderHead.status == '승인대기' }">selected="selected"</c:if>>승인대기</option>
				<option value="승인요청" <c:if test="${orderHead.status == '승인요청' }">selected="selected"</c:if>>승인요청</option>
				<option value="승인" <c:if test="${orderHead.status == '승인' }">selected="selected"</c:if>>승인</option>
				<option value="반려" <c:if test="${orderHead.status == '반려' }">selected="selected"</c:if>>반려</option>
			</select>
			
			<p>
			상품코드
			<select name="productCd" class="sumoProd sumo">
				<option value="All"></option>
				<c:forEach var="product" items="${productEx }">
					<option value="${product.productCd }">${product.productCd }(${product.pname })</option>
				</c:forEach>
			</select>
			
			납품요청일<input type="date" name="requestFromDate" value="${orderHead.requestFromDate }">
			~<input type="date" name="requestToDate" value="${orderHead.requestToDate }">


			삭제 된 주문 보기
			<select name="del">
				<option value="N">삭제 안된것</option>
				<c:if test="${orderHead.del == 'Y'}">
					<option value="Y" selected="selected">삭제 된것</option>
				</c:if>
				<c:if test="${orderHead.del != 'Y'}">
					<option value="Y">삭제 된것</option>
				</c:if>
				<c:if test="${orderHead.del == 'All'}">
					<option value="All" selected="selected">모두</option>
				</c:if>
				<c:if test="${orderHead.del != 'All'}">
					<option value="All">모두</option>
				</c:if>
			</select>
			
		</form>
		<button id="searchBtn">검색</button>
		<button id="initBtn">검색결과 초기화</button>
	</div>
	<p>
	<p>
	
	<button id="show">추가 </button>
	<c:if test="${orderHead.del != 'Y'}">
		<button type="button" onclick="deleteAction()">삭제</button>
	</c:if>
	<c:if test="${orderHead.del == 'Y'}">
		<button type="button" onclick="restoreAction()">복원</button>
	</c:if>
	
	<div id="page">
		<form name="itemLimit">
			<select name="rowPerPage" id="limit">
				<option value="10" <c:if test="${orderHead.rowPerPage == 10 }">selected="selected"</c:if> >
					10개씩보기
				</option>
				<option value="50" <c:if test="${orderHead.rowPerPage == 50 }">selected="selected"</c:if> >
					50개씩보기
				</option>
				<option value="100" <c:if test="${orderHead.rowPerPage == 100 }">selected="selected"</c:if> >
					100개씩보기
				</option>
				<option value="300" <c:if test="${orderHead.rowPerPage == 300 }">selected="selected"</c:if> >
					300개씩보기
				</option>
				<option value="500" <c:if test="${orderHead.rowPerPage == 500 }">selected="selected"</c:if> >
					500개씩보기
				</option>
			</select>
		</form>
	</div>
	
	<div id="table">
		<table id="list">
			<tr>
				<th class="fixed">
					<c:if test="${orderHead.del =='Y'}">
						<input type="checkbox" name="deletedCheckAll" id="th_deletedCheckAll">
					</c:if>
					<c:if test="${orderHead.del =='N' or orderHead.del == 'All' }">
						<input type="checkbox" name="checkAll" id="th_checkAll">
					</c:if>
				</th>
				<th class="fixed" id="sortOrderNo">주문번호</th>
				<th class="fixed" id="sortBuyerCd">고객코드</th>
				<th class="fixed" id="sortOrderDate">신청일</th>
				<th class="fixed" id="sortEmployeeCd">신청인</th>
				<th class="fixed" id="sortStatus">상태</th>
				<th class="fixed" id="sortStatusDate">상태변경일</th>
				<th class="fixed">버튼</th>
			</tr>
			<c:forEach var="head" items="${headList }">			
				<tr class="itemRow">
					<td>
						<c:if test="${head.del =='Y'}">
							<input type="checkbox" name="deletedRow" value="${head.orderNo }" >
						</c:if>
						<c:if test="${head.del =='N' and head.status == '승인대기'}">
							<input type="checkbox" name="checkRow" value="${head.orderNo }" >
						</c:if>
					</td>
					<td>${head.orderNo }<input type="hidden" value="${head.orderNo }"> </td>
					<td>${head.buyerCd }</td>
					<td>${head.orderdate }</td>
					<td>${head.employeeCd }</td>
					<td ><input type="hidden" value="${head.status }">${head.status }</td>
					<td><input type="hidden" value="${head.reason }">${head.statusdate }</td>
					<td>
						<c:if test="${head.status == '승인대기'}">
							<button onclick="approvalRequest('${head.orderNo }')">요청</button>
						</c:if>
						<c:if test="${head.status == '승인요청'}">
							<button onclick="approvalCancel('${head.orderNo }')">취소</button>
						</c:if>
						<c:if test="${head.status == '승인'}">
						</c:if>
						<c:if test="${head.status == '반려'}">
							<button onclick="approvalRequest('${head.orderNo }')">재요청</button>
						</c:if>
					
					</td>
				</tr>
			</c:forEach>
		</table>
	</div>
	
	<div id="pageBtn">
		<c:if test="${orderHead.currentPage != 1}">
			<h6 id="prev">이전</h6>
		</c:if>
		<form name="paging">
		 	<input type="number" name="currentPage" value="${orderHead.currentPage }" id="currentPage"> / ${orderHead.totalPage }
		</form>
		<c:if test="${orderHead.currentPage != orderHead.totalPage}">
			<h6 id="next">다음</h6>
		</c:if>
	</div>
	
	<div class="statusWindow">
		<table id="statusList">
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
	</div>
	


	<!-- 등록 창 팝업 -->
	<div class="background">
		<div class="window">
			<div class="popup">
			
				<button id="close">팝업닫기</button>
				
				<form action="" name="frm">
					주문번호<input type="text" name="orderNo" readonly="readonly"><br>
					발주일<input type="date" id="orderdate" name="orderdate"><br>
					고객코드
					<select name="buyerCd" class="sumo" id="buyerCd">
						<option value=""></option>
						<c:forEach var="buyer" items="${buyerEx }">
							<option value="${buyer.buyerCd }">${buyer.buyerCd }(${buyer.bname })</option>
						</c:forEach>
					</select>
					<br>
					상품코드
					<select name="productCd" class="sumo" id="productCd">
						<option value=""></option>
					</select>
					<br>
					수량<input type="number" name="requestqty"><br>
					판매가<input type="number" name="price"><br>
					납품요청일<input type="date" name="requestdate"><br>
					비고<textarea rows="5" cols="40" name="remark"></textarea>
				</form>
				<button id="addItem">추가</button>
				<div id="addItemDiv">
				
					<table id="addItemTable">
						<thead>
							<tr>
								<th>상품코드</th>
								<th>수량</th>
								<th>판매가</th>
								<th>총액</th>
								<th>납품요청일</th>
								<th>비고</th>
								<th>삭제</th>
							</tr>
						</thead>
						<tbody>						
						</tbody>
					</table>
				
					
					<button id="insertOrder">등록</button>
					<button id="reset">초기화</button>
					 
				</div>
				
			</div>
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
	
	// 	검색초기화
	document.querySelector("#initBtn").addEventListener("click",  function(){callView('order.do')});
	
	function changeTable() {
		const orderdate = frm.orderdate.value;
		const productCd = frm.productCd.value;
		const requestqty = frm.requestqty.value;
		const price = frm.price.value;
		const amount = requestqty * price;
		const requestdate = frm.requestdate.value;
		const remark = frm.remark.value;
		
		if (orderdate == '' || productCd == '' || requestqty == '' || price == '' || 
				amount == '' || requestdate == '' || remark == ''){
			alert('값을 채워넣어주세요');
		} else {
			
			$('#addItemTable > tbody').append(
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
			frm.remark.value = '';
			
			document.querySelector('#orderdate').setAttribute("disabled", "disabled");
			$('select#buyerCd')[0].sumo.disable();
			
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
		};
		
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
</script>

<!-- 검색용 -->
<script type="text/javascript">
	function search() {
				
		const keyword = {
			orderNo : searchBoxx.orderNo.value,	
			buyerCd : searchBoxx.buyerCd.value,	
			orderFromDate : searchBoxx.orderFromDate.value,	
			orderToDate : searchBoxx.orderToDate.value,	
			employeeCd : searchBoxx.employeeCd.value,	
			status : searchBoxx.status.value,	
			productCd : searchBoxx.productCd.value,	
			requestFromDate : searchBoxx.requestFromDate.value,
			requestToDate : searchBoxx.requestToDate.value,
			del : searchBoxx.del.value,
			
			sortOrderNo : searchBoxx.sortOrderNo.value,
			sortBuyerCd : searchBoxx.sortBuyerCd.value,
			sortOrderDate : searchBoxx.sortOrderDate.value,
			sortEmployeeCd : searchBoxx.sortEmployeeCd.value,
			sortStatus : searchBoxx.sortStatus.value,
			sortStatusDate : searchBoxx.sortStatusDate.value,
			
			rowPerPage : itemLimit.rowPerPage.value,
			
			currentPage : paging.currentPage.value,
			
			window : '주문관리'
		}
		
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

	};

	document.querySelector("#searchBtn").addEventListener("click", search);
</script>




<!-- 헤드의 아이템들 불러오기 -->
<script type="text/javascript">
	$("#table tr").on( "click", function() {
		$(".itemRow").removeClass('clickColor');
	    $(this).addClass('clickColor');
	});
	
	
	$('.itemRow').on('click', function() {
		
		$('#statusTable').empty();
		$('#area').empty();
		
		let thisRow = $(this).closest('tr');
		let orderNo = thisRow.find('td:eq(1)').find('input').val();
		let status = thisRow.find('td:eq(5)').find('input').val();
		let reason = thisRow.find('td:eq(6)').find('input').val();
		
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
				if (status == "승인" || status == "반려" ) {
					if (reason != "") {
							
						$('#area').append(
							"<tr>" +
							"<td colspan='8'><textarea rows='5' cols='70' name='reason' id='reason' readonly style='background-color:silver;'></textarea></td>"+
							"</tr>"
						);
						$('#reason').val(reason);
					}
				} 
	
				
				
				
			}, error : function(error) {
					alert("error"+error);
			}
		})
	});
</script>

<!-- 승인대기 -> 승인요청  -->
<script type="text/javascript">
	function approvalRequest(orderNo) {				
		$.ajax({
		     method: 'post',
		     url: 'approvalRequest.do',
		     traditional: true,
		     data: {
		    	 orderNo: orderNo
		     },
		     success: function (result) {
		    	 if(result){
			    	 search();
		    	 } else {
		    		 alert('실패');
		    	 }
			 }		     
	   });
	}
</script>

<!-- 승인요청 -> 승인대기  -->
<script type="text/javascript">
	function approvalCancel(orderNo) {
		$.ajax({
		     method: 'post',
		     url: 'approvalCancel.do',
		     traditional: true,
		     data: {
		    	 orderNo: orderNo
		     },
		     success: function (result) {
		    	 if(result){
			    	 search();
		    	 } else {
		    		 alert('실패');
		    	 }

		    	 
			 }		     
	   });
	}
</script>

<!-- 주문번호 생성 -->
<script type="text/javascript">


	var insertorderdate = "";
	var insertbuyerCd = "";
	var insertorderNo = "";
	var insertproductCd = "";
	
	$('#orderdate').on("change", function() {
		insertorderdate = frm.orderdate.value;
		insertorderdate = insertorderdate.charAt(2) + insertorderdate.charAt(2) + 
						insertorderdate.charAt(5) + insertorderdate.charAt(6) + 
						insertorderdate.charAt(8) + insertorderdate.charAt(9);
		insertorderNo = insertorderdate + insertbuyerCd;
		frm.orderNo.value = insertorderNo;
		
		if(insertorderNo.length == 12){
			const count = getOrderCount(insertorderNo);
			insertorderNo = insertorderNo + count;
			frm.orderNo.value = insertorderNo;
			
		}
	});
	
	$('#buyerCd').on("change", function() {
		insertbuyerCd = frm.buyerCd.value;
		insertorderNo = insertorderdate + insertbuyerCd
		frm.orderNo.value = insertorderNo;
		
		if(insertorderNo.length == 12){
			const count = getOrderCount(insertorderNo);
			insertorderNo = insertorderNo + count;
			frm.orderNo.value = insertorderNo;
		}
		
		insertproductCd = frm.productCd.value;
		
		if(insertproductCd != "" && insertbuyerCd != ""){
			frm.price.value = getPrice(insertbuyerCd, insertproductCd);
		}
	});
	
	$('#productCd').on("change", function() {
		insertproductCd = frm.productCd.value;
		
		if(insertproductCd != "" && insertbuyerCd != ""){
			frm.price.value = getPrice(insertbuyerCd, insertproductCd);
		}
	})
	
	function getOrderCount(orderNo) {
		let count = "";
		$.ajax({
		     method: 'post', 
		     url: 'getOrderCount.do', 
		     traditional: true,
		     async: false,
		     data: {
		    	orderNo: orderNo
		     },
		     success: function (result) {
		    	 count = result;
			}
	   	});
		return count;
	}
	
	function getPrice(buyerCd, productCd){
		let price = "";
		$.ajax({
		     method: 'post', 
		     url: 'getPrice.do', 
		     traditional: true,
		     async: false,
		     data: {
		    	 buyerCd: buyerCd,
		    	 productCd: productCd
		     },
		     success: function (result) {
		    	 if (result == -123){
		    		alert('계약기간이 지났습니다.');
		    		price = 0;
		    	 } else {
			    	 price = result;		    		 
		    	 }
		    	 
			}
	   	});
		return price;
	}
	
	
</script>

<!-- 전체 선택 / 삭제  -->
<c:if test="${orderHead.del =='N' or orderHead.del == 'All' }">
	<script type="text/javascript">
		function checkAll(){
		    if( $("#th_checkAll").is(':checked') ){
		      $("input[name=checkRow]").prop("checked", true);
		    }else{
		      $("input[name=checkRow]").prop("checked", false);
		    }
		}
		
		document.querySelector("#th_checkAll").addEventListener("click", checkAll);
	</script>
</c:if>
<script type="text/javascript">
	
	function deleteAction(){
		  var checkRow = new Array();
		  $( "input[name='checkRow']:checked" ).each (function (){
		    checkRow.push($(this).val()) ;
		  });
		  
		  if(checkRow == ''){
		    alert("삭제할 대상을 선택하세요.");
		    return false;
		  }
		  $.ajax({
			    url : "orderDelete.do",
			    type : "post",
			    traditional : true,
			    data : { checkRows : checkRow },
			    
			    success : function(result){
			    	if(result){
			    		alert("삭제완료");
			    		search();
			    		
			    	}else
			    		alert("삭제실패");
			    }
		  });
	};
	
</script>

<!-- 삭제 항목 복원  -->
<c:if test="${orderHead.del =='Y'}">
	<script type="text/javascript">
		function delCheckAll(){
		    if( $("#th_deletedCheckAll").is(':checked') ){
		      $("input[name=deletedRow]").prop("checked", true);
		    }else{
		      $("input[name=deletedRow]").prop("checked", false);
		    }
		}
	
		document.querySelector("#th_deletedCheckAll").addEventListener("click", delCheckAll);
	</script>
</c:if>
<script type="text/javascript">


function restoreAction(){
	  var checkRow = new Array();
	  $( "input[name='deletedRow']:checked" ).each (function (){
	    checkRow.push($(this).val());
	  });
	  
	  if(checkRow == ''){
	    alert("복원할 대상을 선택하세요.");
	    return false;
	  }
	  $.ajax({
		    url : "orderRestore.do",
		    type : "post",
		    traditional : true,
		    data : { checkRows : checkRow },
		    
		    success : function(result){
		    	if(result ==1){
		    		alert("복원완료");
		    		search();
		    		
		    	}else
		    		alert("복원실패");
		    }
	  });
};
</script>

<!-- 스모셀렉트 -->
<script type="text/javascript">
$(document).ready(function() {
	$('.sumo').SumoSelect({
		search: true,
		searchText: '검색어 입력',
	});
	$('select.sumoBuy')[0].sumo.selectItem("${orderHead.buyerCd }");
	
	$('select.sumoEmp')[0].sumo.selectItem("${orderHead.employeeCd }");
	
	$('select.sumoProd')[0].sumo.selectItem("${orderHead.productCd }");
	
});

</script>

<!-- 고객 코드 설정시 계약된(판매가마스터에 존재하는) 상품만 가져오기 -->
<script type="text/javascript">
	$('#buyerCd').on("change", function() {
		const prod = $('select#productCd');
		
		console.log("지워져라~");
		console.log($('select#productCd option').length);
		var leng = $('select#productCd option').length
		for (var i = 1; i < leng; i++) {
			$('select#productCd')[0].sumo.remove(1);
		}
		
		$.ajax({
		    url : "getPricingProductList.do",
		    type : "post",
		    traditional : true,
		    data : { 
		    	buyerCd  : frm.buyerCd.value
		    },		    
		    success : function(result){
		    	console.log("성공?");
		    	console.log(result);
		    	console.log(result.length);
		    	for (var i = 0; i < result.length; i++) {
		    		const codeName = result[i];
		    		const code = result[i].split('(')[0];
		    		console.log(code);
		    		$('select#productCd')[0].sumo.add(code, result[i]);
		    	}
		    	
		    }
	  	});
	});
</script>

<!-- 등록창 초기화 -->
<script type="text/javascript">
	$('#reset').on('click', function() {
		frm.orderNo.value = '';
		frm.orderdate.value = '';
		document.querySelector('#orderdate').removeAttribute("disabled");
		$('select#buyerCd')[0].sumo.enable();
		$('select#buyerCd')[0].sumo.unSelectAll();
		$('select#productCd')[0].sumo.unSelectAll();		
		frm.requestqty.value = '';
		frm.price.value = '';
		frm.requestdate.value = '';
		frm.remark.value = '';
		
		console.log($('#addItemTable').length);
		$('#addItemTable > tbody').empty();
		
	});
</script>

<!-- 정렬 -->
<script type="text/javascript">
	function initSort() {
		searchBoxx.sortOrderNo.value = 0;
		searchBoxx.sortBuyerCd.value = 0;
		searchBoxx.sortOrderDate.value = 0;
		searchBoxx.sortEmployeeCd.value = 0;
		searchBoxx.sortStatus.value = 0;
		searchBoxx.sortStatusDate.value = 0;
	}

	$('#sortOrderNo').on('click', function() {
		if (searchBoxx.sortOrderNo.value == 0 || searchBoxx.sortOrderNo.value == 2) {
			initSort();
			searchBoxx.sortOrderNo.value = 1;			
		} else if (searchBoxx.sortOrderNo.value == 1) {
			initSort();
			searchBoxx.sortOrderNo.value = 2;
		}		
		search();
	});
	$('#sortBuyerCd').on('click', function() {
		if (searchBoxx.sortBuyerCd.value == 0 || searchBoxx.sortBuyerCd.value == 2) {
			initSort();
			searchBoxx.sortBuyerCd.value = 1;			
		} else if (searchBoxx.sortBuyerCd.value == 1) {
			initSort();
			searchBoxx.sortBuyerCd.value = 2;
		}		
		search();
	});
	$('#sortOrderDate').on('click', function() {
		if (searchBoxx.sortOrderDate.value == 0 || searchBoxx.sortOrderDate.value == 2) {
			initSort();
			searchBoxx.sortOrderDate.value = 1;		
		} else if (searchBoxx.sortOrderDate.value == 1) {
			initSort();
			searchBoxx.sortOrderDate.value = 2;
		}		
		search();
	});
	$('#sortEmployeeCd').on('click', function() {
		if (searchBoxx.sortEmployeeCd.value == 0 || searchBoxx.sortEmployeeCd.value == 2) {
			initSort();
			searchBoxx.sortEmployeeCd.value = 1;			
		} else if (searchBoxx.sortEmployeeCd.value == 1) {
			initSort();
			searchBoxx.sortEmployeeCd.value = 2;
		}		
		search();
	});
	$('#sortStatus').on('click', function() {
		if (searchBoxx.sortStatus.value == 0 || searchBoxx.sortStatus.value == 2) {
			initSort();
			searchBoxx.sortStatus.value = 1;			
		} else if (searchBoxx.sortStatus.value == 1) {
			initSort();
			searchBoxx.sortStatus.value = 2;
		}		
		search();
	});
	$('#sortStatusDate').on('click', function() {
		if (searchBoxx.sortStatusDate.value == 0 || searchBoxx.sortStatusDate.value == 2) {
			initSort();
			searchBoxx.sortStatusDate.value = 1;			
		} else if (searchBoxx.sortStatusDate.value == 1) {
			initSort();
			searchBoxx.sortStatusDate.value = 2;
		}		
		search();
	});
</script>

<!-- 페이지 버튼 / 페이지 당 요소 갯수 -->
<script type="text/javascript">
	$('#prev').on('click', function() {
		paging.currentPage.value--;
		if (paging.currentPage.value < 1) {
			paging.currentPage.value = 1;
		}
		search();
	});
	$('#next').on('click', function() {
		paging.currentPage.value++;
		
		if (paging.currentPage.value > '${orderHead.totalPage }') {
			paging.currentPage.value = ${orderHead.totalPage };
		}
		search();
	});
	
	$('#limit').on('change', function() {
		search();
	});
	
	$('#currentPage').keydown(function(key) {
		if(key.keyCode == 13) {
			key.preventDefault();
			search();
		}
	});
</script>



</html>