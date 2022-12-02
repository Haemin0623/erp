<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../layoutElement/taglib.jsp"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<style type="text/css">

	#container {
		margin-left: 100px;
	}
	#searchBox {
		width: 120vh;
		height: 150px;
		background: #5b6996;
		padding: 30px;
		color: white;
	}
	#searchBtn{
		background: #d9dbe1;
		color: black;
		float: right;
		margin-top: 20px;
		margin-right: 100px;

	}

	#table {
		margin-top: 50px;
		overflow: auto;
		height: 60vh;
		width: 120vh;
	}
	#table th {
		background-color: #5b6996;
		color: white;
	}

	.scrollwrap {position: relative; display: block; width: 1100px; overflow-x: auto;}
	.scrollcontent {width: 2200px;}
	
</style>
	
</head>
<body>
<div id = "container">
	<h1>주문 현황</h1>

	<div id="searchBox">
		<form name="searchBoxx">		
			<div>
				주문번호 <input type="text" name="orderNo" value="${orderItem.orderNo }" >
				고객코드
 					<select name="buyerCd">
						<c:if test="${orderItem.buyerCd != null}">
							<option value="${orderItem.buyerCd}">${orderItem.buyerCd}</option>
						</c:if>
						<c:if test="${orderItem.buyerCd == null}">
							<option></option>
						</c:if>
						<c:forEach var="buyer" items="${buyerList}">
							<option value="${buyer.buyerCd}">${buyer.buyerCd}</option>
						</c:forEach>
					</select>
				고객명 
					<select name="bname">
						<c:if test="${orderItem.bname != null}">
							<option value="${orderItem.bname}">${orderItem.bname}</option>
						</c:if>
						<c:if test="${orderItem.bname == null}">
							<option></option>
						</c:if>
						<c:forEach var="buyer" items="${buyerList}">
							<option value="${buyer.bname}">${buyer.bname}</option>
						</c:forEach>
					</select> 
				상품코드 <input type="text" name="productCd" value="${orderItem.productCd }" >
				상품명 <input type="text" name="pname" value="${orderItem.pname }">
				<br>
				영업담당자 
					<select name="employeeCd">
						<c:if test="${orderItem.employeeCd != null}">
							<option value="${orderItem.employeeCd}">${orderItem.ename} ${orderItem.job}(${orderItem.department})</option>
						</c:if>
						<c:if test="${orderItem.employeeCd == null}">
							<option></option>
						</c:if>
						<c:forEach var="emp" items="${empList}">
							<c:if test="${emp.department=='영업'}">
								<option value="${emp.employeeCd }">${emp.ename} ${emp.job}(${emp.department})</option>
							</c:if>
						</c:forEach>
					</select>
				<%-- 승인자
					<select name="signempCd">
						<c:if test="${orderItem.signempCd != null}">
							<option value="${orderItem.signempCd}">${orderItem.signempName} ${orderItem.job}(${orderItem.department})</option>
						</c:if>
						<c:if test="${orderItem.signempCd == null}">
							<option></option>
						</c:if>
						
						<c:forEach var="emp" items="${empList}">
							<c:if test="${emp.department=='관리'}">
								<option value="${emp.employeeCd}">${emp.ename} ${emp.job}(${emp.department})</option>
							</c:if>
						</c:forEach>
					</select> --%>
				신청일<input type="date" name="orderFromDate" value=${orderItem.orderFromDate }>
					-<input type="date" name="orderToDate" value=${orderItem.orderToDate }>
				납품요청일<input type="date" name="requestFromDate" value="${orderItem.requestFromDate }">
					-<input type="date" name="requestToDate" value="${orderItem.requestToDate }">
				<br>
				상태 
					<select name="status">
						<c:if test="${orderItem.status != null}">
							<option value="${orderItem.status}">${orderItem.status}</option>
						</c:if>
						<c:if test="${orderItem.status == null}">
							<option></option>
						</c:if>			
						<option value="승인요청">승인요청</option>
						<option value="승인">승인</option>
						<option value="반려">반려</option>
					</select>
				국가코드
					<select name="countryCd">
							<c:if test="${orderItem.countryCd != null}">
								<option value="${orderItem.countryCd}">${orderItem.cname}(${orderItem.countryCd})</option>
							</c:if>
							<c:if test="${orderItem.countryCd == null}">
								<option></option>
							</c:if>
							<c:forEach var="country" items="${countryList}">
									<option value="${country.countryCd}">${country.cname}(${country.countryCd})</option>
							</c:forEach>
					</select>
			</div>
		</form>
	</div>	
			<button id="excelBtn">Excel</button>
			<button id="searchBtn">검색</button>
			<button id="initBtn">검색결과 초기화</button>
	
		
	<div class="scrollwrap" id="table">
		<table class="scrollcontent" id="list">
			<tr>
				<th><input type="checkbox" name="checkAll" id="th_checkAll"></th>
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
			<tr class="itemRow">
				<td><input type="checkbox" name="checkRow" value="${item.orderNo }"></td>
				<td>${item.orderdate }</td>
				<td><input type="hidden" value="${item.orderNo }">${item.orderNo }</td>
				<td><input type="hidden" value="${item.productCd }">${item.productCd }</td>
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
	
	document.querySelector("#initBtn").addEventListener("click",  function(){callView('orderStatus.do')});
	
	
	function search() {
		const keyword = {
			orderNo : searchBoxx.orderNo.value,	
			buyerCd : searchBoxx.buyerCd.value,	
			bname : searchBoxx.bname.value,
			productCd : searchBoxx.productCd.value,	
			pname : searchBoxx.pname.value,	
			employeeCd : searchBoxx.employeeCd.value,
		/* 	ename : searchBoxx.ename.value, */
			/* signempCd : searchBoxx.signempCd.value, */
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
		     url: 'orderSearch2.do',
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
	
	function checkAll(){
	    if( $("#th_checkAll").is(':checked') ){
	      $("input[name=checkRow]").prop("checked", true);
	    }else{
	      $("input[name=checkRow]").prop("checked", false);
	    }
	}
	
	document.querySelector("#th_checkAll").addEventListener("click", checkAll);
	
	
	function excel() {
		
		let checkRow = new Array();
		
		$( "input[name='checkRow']:checked" ).each (function (){
			 let thisRow = $(this).closest('tr');
	/* 		 
			orderNo = thisRow.find('td:eq(2)').find('input').val();
			productCD = thisRow.find('td:eq(3)').find('input').val();
			  */
			 const item = {
						orderNo : thisRow.find('td:eq(2)').find('input').val(),	
						productCd : thisRow.find('td:eq(3)').find('input').val()
					}
			 

			 checkRow.push(item);
		
		});
		
		  
		 console.log(checkRow);
		 
		 $.ajax({
			  url : 'excelDown.do',
			  method : 'post',
			  traditional : true,
			  data : {
				  items : JSON.stringify(checkRow)
			  },
			  
			  success : function(result) {
				alert("엑셀다운완료?!");
				
			}, error: function (xhr, status, error) {
				console.log("error");
			} 
		 });
		  
	}
	
	document.querySelector("#excelBtn").addEventListener("click", excel);
	
	
</script>
</html>