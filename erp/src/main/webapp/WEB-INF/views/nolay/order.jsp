<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../layoutElement/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<style type="text/css">
	
</style>

</head>
<body>
<div id="container">	
	<h1>주문 관리</h1>
	<div id="searchBox">
		<div class="searchInBox">
			<form name="searchBoxx">	
				<!-- 정렬용 -->
				<input type="hidden" name="sortOrderNo" value="${orderHead.sortOrderNo }">
				<input type="hidden" name="sortBuyerCd" value="${orderHead.sortBuyerCd }">
				<input type="hidden" name="sortOrderDate" value="${orderHead.sortOrderDate }">
				<input type="hidden" name="sortEmployeeCd" value="${orderHead.sortEmployeeCd }">
				<input type="hidden" name="sortStatus" value="${orderHead.sortStatus }">
				<input type="hidden" name="sortStatusDate" value="${orderHead.sortStatusDate }">
				
				<div class="search-sub-div">
					<div class="search-item-div">
						<div class="search-item-text">주문번호</div>
						<input type="text" name="orderNo" value="${orderHead.orderNo }">
					</div>
					<div class="search-item-div">
						<div class="search-item-text">고객코드</div>
						<select name="buyerCd" class="sumoBuy sumo">
							<option value="All"></option>
							<c:forEach var="buyer" items="${buyerEx }">
								<option value="${buyer.buyerCd }">${buyer.buyerCd }(${buyer.bname })</option>
							</c:forEach>
						</select>
					</div>
					<div class="search-item-div">
						<div class="search-item-text">신청일</div>
						<input type="date" name="orderFromDate" value="${orderHead.orderFromDate }">
						~<input type="date" name="orderToDate" value="${orderHead.orderToDate }">
					</div>
					<div class="search-item-div">
						<div class="search-item-text">상태</div>
						<div class="boxx">
							<select name="status" class="search">
								<option value="null">모두</option>		
								<option value="승인대기" <c:if test="${orderHead.status == '승인대기' }">selected="selected"</c:if>>승인대기</option>
								<option value="승인요청" <c:if test="${orderHead.status == '승인요청' }">selected="selected"</c:if>>승인요청</option>
								<option value="승인" <c:if test="${orderHead.status == '승인' }">selected="selected"</c:if>>승인</option>
								<option value="반려" <c:if test="${orderHead.status == '반려' }">selected="selected"</c:if>>반려</option>
							</select>
						</div>
					</div>
				</div>
				<div class="search-sub-div">
					<div class="search-item-div">
						<div class="search-item-text">신청인</div>
						<select name="employeeCd" class="sumoEmp sumo">
							<option value="All"></option>
							<c:forEach var="employee" items="${employeeEx }">
								<option value="${employee.employeeCd }">${employee.employeeCd }(${employee.ename })</option>
							</c:forEach>
						</select>
					</div>
					<div class="search-item-div">			
						<div class="search-item-text">상품코드</div>
						<select name="productCd" class="sumoProd sumo">
							<option value="All"></option>
							<c:forEach var="product" items="${productEx }">
								<option value="${product.productCd }">${product.productCd }(${product.pname })</option>
							</c:forEach>
						</select>
					</div>
					<div class="search-item-div">
						<div class="search-item-text">요청일</div>
						<input type="date" name="requestFromDate" value="${orderHead.requestFromDate }">
						~<input type="date" name="requestToDate" value="${orderHead.requestToDate }">
					</div>
					<div class="search-item-div">
						<div class="search-item-text">삭제</div>
						<div class="boxx">
							<select name="del" class="search">
								<option value="N">X</option>
								<option value="Y" <c:if test="${orderHead.del == 'Y'}">selected="selected"</c:if> >O </option>
								<option value="All" <c:if test="${orderHead.del == 'All'}"> selected="selected" </c:if>>모두</option>
							</select>
						</div>
					</div>
				</div>
				
			</form>
		</div>
		<div class="search-btn">
			<button id="searchBtn">검색</button>
			<button id="initBtn">초기화</button>
		</div>
	</div>
	
	
	<div id="button-div">
		<button id="show">추가 </button>
		<c:if test="${orderHead.del != 'Y'}">
			<button type="button" onclick="deleteAction()">삭제</button>
		</c:if>
		<c:if test="${orderHead.del == 'Y'}">
			<button type="button" onclick="restoreAction()">복원</button>
		</c:if>
		<button id="excelBtn">Excel</button>
		
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
	</div>
	
	<div class="table">
		<table class="list">
			<tr>
				<th class="fixed">
					<c:if test="${orderHead.del =='Y'}">
						<input type="checkbox" name="deletedCheckAll" id="th_deletedCheckAll">
					</c:if>
					<c:if test="${orderHead.del =='N' or orderHead.del == 'All' }">
						<input type="checkbox" name="checkAll" id="th_checkAll" class="red-check">
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
				<tr class="itemRow" <c:if test="${head.del =='Y'}">style="background-color: silver;"</c:if> >
					<td>
						<c:if test="${head.del =='Y' and orderHead.del == 'Y'}">
							<input type="checkbox" name="deletedRow" class="excel" value="${head.orderNo }" >
						</c:if>
						<c:if test="${head.del =='N' and head.status == '승인대기'}">
							<input type="checkbox" name="checkRow" value="${head.orderNo }"  class="excel red-check">
						</c:if>
					</td>
					<td>${head.orderNo }<input type="hidden" value="${head.orderNo }"> </td>
					<td>${head.buyerCd }</td>
					<td>${head.orderdate }</td>
					<td>${head.employeeCd }</td>
					<td ><input type="hidden" value="${head.status }">${head.status }</td>
					<td><input type="hidden" value="${head.reason }">${head.statusdate }</td>
					<td>
						<c:if test="${sessionScope.employeeCd == head.employeeCd  and head.del != 'Y'}">
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
						</c:if>
					</td>
				</tr>
			</c:forEach>
		</table>
	</div>
	
	<div id="pageBtn">
		<form name="paging">
			<c:if test="${orderHead.currentPage != 1}">
				<div id="prev" class="paging-btn">◀</div>
			</c:if>
		 	<input type="number" name="currentPage" value="${orderHead.currentPage }" id="currentPage"> / ${orderHead.totalPage }
			<c:if test="${orderHead.currentPage != orderHead.totalPage}">
				<div id="next" class="paging-btn">▶</div>
			</c:if>
		</form>
	</div>
	
	<div class="table">
		<table class="list">
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
					<table id="insert-form">
						<tr>
							<td>주문번호<input type="text" name="orderNo" class="readonly" readonly="readonly"></td>
							<td>발주일<input type="date" id="orderdate" name="orderdate"></td>
						</tr>
						<tr>
							<td>고객코드
								<select name="buyerCd" class="sumo" id="buyerCd">
									<option value=""></option>
									<c:forEach var="buyer" items="${buyerEx }">
										<option value="${buyer.buyerCd }">${buyer.buyerCd }(${buyer.bname })</option>
									</c:forEach>
								</select>
							</td>
							<td>상품코드
								<select name="productCd" class="sumo" id="productCd">
									<option value=""></option>
								</select>
							</td>
						</tr>
						<tr>
							<td>수량<input type="number" name="requestqty"></td>
							<td>판매가<input type="number" name="price"></td>
						</tr>
						<tr>
							<td colspan="2">납품요청일<input type="date" name="requestdate"></td>
						</tr>
						<tr>
							<td colspan="2">비고<textarea rows="5" cols="40" name="remark"></textarea></td>
						</tr>
					</table>
				</form>
				
				<div class="insert-btn">
					<button id="addItem">추가</button>
				</div>				
				
				<div id="addItemDiv" class="table"  style="height: 200px;">
				
					<table id="addItemTable" class="list">
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
				
					
					 
				</div>
				
				<div class="insert-btn">
					<button id="reset">초기화</button>
				</div>
				<div class="insert-btn">
					<button id="insertOrder">등록</button>
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
							"<td>" + String(data[i].requestqty).replace(/\B(?=(\d{3})+(?!\d))/g, ",") + "</td>" +
							"<td>" + reqDate + "</td>" +
							"<td>" + String(data[i].price).replace(/\B(?=(\d{3})+(?!\d))/g, ",") + "</td>" +
							"<td>" + String(data[i].amount).replace(/\B(?=(\d{3})+(?!\d))/g, ",") + "</td>" +
							"<td>" + data[i].remark + "</td>" +
						"</tr>"
					);					
				
				}
				if (status == "승인" || status == "반려" ) {
					if (reason != "") {
							
						$('#area').append(
							"<tr>" +
							"<th colspan='2'>사유</th>" +
							"</tr>" +
							"<tr>" +
							"<td colspan='8'><textarea rows='5' cols='50' name='reason' id='reason' readonly></textarea></td>"+
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
		    	 if(result > 0){
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
			
			if (paging.currentPage.value < 1) {
				paging.currentPage.value = 1;
			}
			
			if (paging.currentPage.value > '${orderHead.totalPage }') {
				paging.currentPage.value = ${orderHead.totalPage };
			}
			
			search();
		}
	});
</script>

<script>
	function excel() {
		
		let checkRow = new Array();
		
		$( ".excel:checked" ).each (function (){
			 let thisRow = $(this).closest('tr');
			 
//			orderNo = thisRow.find('td:eq(2)').find('input').val();
//			productCD = thisRow.find('td:eq(3)').find('input').val();
			  
			 const item = {
				orderNo : thisRow.find('td:eq(1)').find('input').val()
			 }

			 checkRow.push(item);
		
		});
		
		  
		 console.log(checkRow);
		 
		 J300.ajax({
			  url : 'orderExcelDown.do',
			  method : 'post',
			  traditional : true,
			  data : {
				  items : JSON.stringify(checkRow)
			  },
			  xhr: function () {
                  var xhr = new XMLHttpRequest();
                  xhr.onreadystatechange = function () {
                      if (xhr.readyState == 2) {
                          if (xhr.status == 200) {
                              xhr.responseType = "blob";
                          } else {
                              xhr.responseType = "text";
                          }
                      }
                  };
                  return xhr;
			    },
			  success : function(data) {
				  console.log(data);
				//alert("엑셀다운완료?");
				//Convert the Byte Data to BLOB object.
                var blob = new Blob([data], { type: "application/octetstream" });

                //Check the Browser type and download the File.
                var isIE = false || !!document.documentMode;
                if (isIE) {
                    window.navigator.msSaveBlob(blob, fileName);
                } else {
                    var url = window.URL || window.webkitURL;
                    link = url.createObjectURL(blob);
                    var a = $("<a />");
                    a.attr("download", "test.xlsx");
                    a.attr("href", link);
                    $("body").append(a);
                    a[0].click();
                    $("body").remove(a);
                }
			}, error: function (xhr, status, error) {
				console.log("error");
			} 
		 });
		  
	}
	
	document.querySelector("#excelBtn").addEventListener("click", excel);
	
	
</script>



</html>