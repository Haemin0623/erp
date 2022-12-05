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
/* 	#searchBtn{
		background: #d9dbe1;
		color: black;
		float: right;
		margin-top: 20px;
		margin-right: 100px;

	} */

	#table {
		margin-top: 100px;
		overflow: auto;
		height: 40vh;
		width: 120vh;
	}
	tr th {
		background-color: #5b6996;
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
	.fixed {
		position: sticky;
		top: 0;
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
				<th class="fixed">선택</th>
				<th class="fixed" id="sortOrderNo">주문번호</th>
				<th class="fixed" id="sortBuyerCd">고객코드</th>
				<th class="fixed" id="sortOrderDate">신청일</th>
				<th class="fixed" id="sortEmployeeCd">신청인</th>
				<th class="fixed" id="sortStatus">상태</th>
				<th class="fixed" id="sortStatusDate">상태변경일</th>
				<th class="fixed">사유</th>
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


		<div class="statusWindow" >
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
	document.querySelector("#initBtn").addEventListener("click",  function(){callView('orderApprovalWindow.do')});
	
	
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
						"<tr class='itemRow'>" +
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