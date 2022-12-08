<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../layoutElement/taglib.jsp"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
	.orderApprovalBtnBox {
		text-align: center;
		/* display: none; */
		
	}
	.orderApproval {
		display :inline-block;
	}
	.itemTable {
		background-color: #fff;
	    overflow-x: hidden;
	    resize: both;
	    box-shadow: 2px -1px 4px #b1b1b1;
	    /* overflow-y: scroll; */
	    height: 260px;
	}
	.itemList {
		margin: 4px 10px 0 10px;
		border-collapse: collapse;
		font-size: 12px;
 		width: 100%;
	}
	.hiding {
		display: none;
	}
	#button-div {
    /* margin-bottom: 15px; common */
    padding-bottom: 25px;
	}


</style>

</head>
<body>
<div id="container">
	<h1 class="menuName">주문 승인</h1>
	
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
						<div class="search-item-text">승인상태</div>
						<div class="boxx">
							<select name="status">
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
						<div class="search-item-text">납품요청일</div>
						<input type="date" name="requestFromDate" value="${orderHead.requestFromDate }">
						~<input type="date" name="requestToDate" value="${orderHead.requestToDate }">
					</div>
					<div class="search-item-div">
						<div class="search-item-text">활성상태</div>
							<select name="del">
								<option value="N">활성</option>
								<option value="Y" <c:if test="${orderHead.del == 'Y'}">selected="selected"</c:if> >비활성 </option>
								<option value="All" <c:if test="${orderHead.del == 'All'}"> selected="selected" </c:if>>모두</option>
							</select>
					</div>
				</div>
			
				<p>
				
			</form>
		</div>
		<button id="searchBtn">검색</button>
		<button id="initBtn">초기화</button>
	</div>
	
	
	<div id="button-div">
		
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
					<td><input type="hidden" value="${head.orderNo }">${head.orderNo }</td>
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


	<div class="itemTable">
		<table class="itemList">
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
		<div class="orderApprovalBtnBox">
			<button class='orderApproval' name='btn' value='승인'>승인</button>
			<button class='orderApproval' name='btn' value='반려'>반려</button>
		</div>
		
</div>	
</body>

		
<script type="text/javascript">
$(document).ready(function(){
	$('.orderApprovalBtnBox').hide();
	
});
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
	$(".table tr").on( "click", function() {
		$(".itemRow").removeClass('clickColor');
	    $(this).addClass('clickColor');
	});

	/* head 행 클릭시 itemList */
	$('.itemRow').on('click', function() {
		
		$('#statusTable').empty();
		$('#area').empty();
		
		let thisRow = $(this).closest('tr');
		let orderNo = thisRow.find('td:eq(0)').find('input').val();
		let status = thisRow.find('td:eq(4)').find('input').val();
		let reason = thisRow.find('td:eq(6)').find('input').val();
		
		/* console.log(reason); */
		console.log(status);
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
							"<td>" + data[i].unitedrequestqty + "</td>" +
							"<td>" + reqDate + "</td>" +
							"<td>" + data[i].price + "</td>" +
							"<td>" + data[i].unitedAmount + "</td>" +
							"<td>" + data[i].remark + "</td>" +
						"</tr>"
					);
				
					
				
				}
					if (status == "승인요청") {
						
						$('#area').append(
							"<tr>" +
							"<td colspan='8'>comment</td>" +
							"</tr>" +
							"<tr>" +
								"<td colspan='8'><textarea rows='5' cols='70' name='reason' id='reason' style='width:99%; resize: none; text-align: center;'></textarea></td>"+
							"</tr>"
						);
						$(".orderApprovalBtnBox").removeClass('hiding');
						$(".orderApprovalBtnBox").show();
	
					} else if (status == "승인" || status == "반려" ) {
						if (reason != "") {
								
							$('#area').append(
								"<tr>" +
								"<td colspan='8'>comment</td>" +
								"</tr>" +
								"<tr>" +
									"<td colspan='8'><textarea rows='5' cols='70' name='reason' id='textarea' readonly style='background-color:silver; width:99%; resize: none; text-align: center;'></textarea></td>"+
								"</tr>"
							);
							$('#textarea').val(reason);
							$(".orderApprovalBtnBox").addClass('hiding');
						}
					} else if (status == "승인대기" ) {
						if (reason == "") {
								
							$('#area').append(
								"<tr>" +
								"<td colspan='8'>comment</td>" +
								"</tr>" +
								"<tr>" +
									"<td colspan='8'><textarea rows='5' cols='70' name='reason' id='textarea' readonly style='background-color:silver; width:99%; resize: none; text-align: center;'></textarea></td>"+
								"</tr>"
							);
							$('#textarea').val("승인 대기 중");
							$(".orderApprovalBtnBox").addClass('hiding');
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
		var btn = $(this).val();
		console.log(btn);
		console.log("4");
		
		var cf = confirm("정말 "+btn+"하시겠습니까?");
		
		if (cf == true) {
			$.ajax({
				method: 'post',
				url: 'orderApproval.do',
				data: {
					"orderNo":orderNo,
					"reason":writeReason,
					"btnValue":btn
					},
					
				success: function(data) {
					console.log("된듯");
					callView('orderApprovalWindow.do');
					
				}, error: function (xhr, status, error) {
					console.log("error");
				}
			});
		} 
	
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


</html>