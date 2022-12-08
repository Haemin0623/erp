<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ include file="../layoutElement/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<link rel="stylesheet" type="text/css" href="/erp/resources/css/common.css">


<style type="text/css">
	body {
	margin: 0;
    background-color: #fcfaee;	
	}
	
	#menu {
		position:fixed;
		width: 200px;
		height: 100%;
		
	/* 	float: left; */
	/* 	width: 250px; */
	/* 	height: 100vh; */
	    background-color: #c3d4ae;
	}
	.text-primary {
		margin-left: 30px;
		color: white;
	}
	
	.line {
	
	}
	
	.line2 {
		margin-top: 120%;
	}

	.menuList {
		margin-right: 10px;
		margin-top: 40px;		
		list-style: none;
		font-weight: bold;
		text-align: right;
		font-size: 30px;
		color: white;
	}
	
	.subMenu {
		margin-top: 5px;
		margin-right: 10px;
		list-style: none;
		text-align: right;
		font-size: 20px;
		color: white;
	}
	
	.subMenu:hover {
		background-color: #E6E6FA;
	}
	
	a {
		text-decoration-line: none;
        color: #41814e;
	}
	
	a:hover {
		color: black;
	} 
	
	#container {
		position: fixed;
		top: 0;
		left: 0;
		width: 100%;
		height: 100vh;
		background-color: rgba(0, 0, 0, 0.3);	
	}
	
	.window {
	  position: relative;
	  width: 100%;
	  height: 100%;
	  opacity: 1;
	  z-index: 1000;
	}
	
	.popup {
	  position: absolute;
	  top: 50%;
	  left: 50%;
	  transform: translate(-50%, -50%);
	  background-color: #ffffff;
	  box-shadow: 0 2px 7px rgba(0, 0, 0, 0.3);
	  
	  /* 임시 지정 */
	  width: 800px;
	  height: 500px;
	  
	  /* 초기에 약간 아래에 배치 */
	  transform: translate(-50%, -40%);
	}
	
	.show {
	  opacity: 1;
	  z-index: 1000;
	}
	
	.show .popup {
	  transform: translate(-50%, -50%);
	}
	
	.login-form {
	    top: 50%;
	    left: 8%;
	    position: relative;
	}
	
	table {
		border : 1px solid black;
		width : 100%;
	}
	th {
		border : none;
	}
	td {
		border : none;
	}
	
	div#btn {
	    position: absolute;
	    left: 43%;
	    bottom: 0%;
    }
</style>
</head>
<body>
<div id="menu">
	<h1 class="text-primary">2조</h1>
	<h6 class="text-primary">
		<c:if test="${sessionScope.employeeCd != null }">
			${sessionScope.employeeCd }(${sessionScope.ename })
			<a href="logout.do">로그 아웃</a>
		</c:if>
	</h6>
	<hr class="line">


	<div>
			<ul>
				<li class="menuList">마스터</li>
				<li class="subMenu"><a href="javascript:void(0);" onclick="changeContent('productList.do')">상품</a></li>
				<li class="subMenu"><a href="javascript:void(0);" onclick="changeContent('buyer.do')">고객</a></li>
				<li class="subMenu"><a href="javascript:void(0);" onclick="changeContent('pricing.do')">판매가</a></li>
				<li class="subMenu"><a href="javascript:void(0);" onclick="changeContent('emp.do')">직원</a></li>
			</ul>
			
			<ul>
				<li class="menuList">주문</li>
				<li class="subMenu"><a href="javascript:void(0);" onclick="changeContent('order.do')">주문 관리</a></li>
				<li class="subMenu"><a href="javascript:void(0);" onclick="changeContent('orderApprovalWindow.do')">주문 승인</a></li>
			</ul>
			
			<ul>
				<li class="menuList">REPORT</li>
				<li class="subMenu"><a href="javascript:void(0);" onclick="changeContent('orderStatus.do')">주문 현황</a></li>
			</ul>
	</div>
	<hr class="line2">
</div>

<div id="container">
		
	</div>

	<div class="background show">
		<div class="window">
			<div class="popup">	
			
				<div id="head">
					<form name="order">
						<input type="hidden" name="orderNo" value="${head.orderNo }">
						<table>
							<tr>
								<th>주문번호</th>
								<td>${head.orderNo }</td>
								<th>반려자</th>
								<td>${head.employeeCd }</td>
							</tr>
							<tr>
								<th>고객코드</th>
								<td>${head.buyerCd }</td>		
								<th>발주일</th>
								<td>${head.orderdate }</td>			
							</tr>
							<tr>
								<td colspan="4">
									<textarea rows="5" cols="80" readonly="readonly">${head.reason }</textarea>
								</td>
							</tr>
						</table>
					</form>
				</div>
				<div id="head-item">
					<table id="items">
						<tr>
							<th>상품코드</th>
							<th>수량</th>
							<th>판매가</th>
							<th>납품요청일</th>
							<th>비고</th>
							<th>삭제</th>
						</tr>
						<c:forEach var="item" items="${itemList }">			
							<tr class="row">
								<td>
									<input type="hidden" name="productCd" value="${item.productCd }">
									${item.productCd }
								</td>
								<td>
									<input type="number" name="requestqty" value="${item.requestqty }">
								</td>
								<td>
									<input type="number" name="price" value="${item.price }">
								</td>
								<td>
									<input type="date" name="requestdate" value="${item.requestdate }">
								</td>
								<td>
									<input type="text" name="remark" value="${item.remark }">
								</td>
								<td><button onclick="deleteItem(this)" value="${head.orderNo }&${item.productCd }">삭제</button></td>
							</tr>
						</c:forEach>
					</table>					
				</div>
				<div id="btn">
					<button onclick="request()">재요청</button>
					<button onclick="back()">취소</button>
				</div>
			</div>
		</div>
	</div>
	
	
	<script type="text/javascript">
		function back() {
			callView('order.do');
		}
	
	
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
	
		function request() {
			let items = new Array();
			
			$(".row").each (function() {
				let thisRow = $(this);
				
				console.log(thisRow);
				
				const item = {
					orderNo: order.orderNo.value,
					productCd: thisRow.find('td:eq(0)').find('input').val(),
					requestqty: thisRow.find('td:eq(1)').find('input').val(),
					price: thisRow.find('td:eq(2)').find('input').val(),
					requestdate: thisRow.find('td:eq(3)').find('input').val(),
					remark: thisRow.find('td:eq(4)').find('input').val()
				}
				console.log(item);
				
				items.push(item);
			});
			
			$.ajax({
				url : 'requestAgain.do',
				method : 'post',
				traditional : true,
				data : {
					item : JSON.stringify(items)
				},
				success: function (result) {
					if (result) {
						callView('order.do');
					} else {
					    alert("실패");
					}
				}
			});
			
		}
		
		function deleteItem(e) {
			const check = confirm("정말로 해당 주문을 삭제 할까요?");
			
			if(check){
				e.parentNode.parentNode.parentNode.removeChild(e.parentNode.parentNode);
				
				$.ajax({
					url : 'deleteItem.do',
					method : 'post',
					traditional : true,
					data : {
						code : e.value
					},
					success: function (result) {
						if(result){
						} else{
							alert("실패");
						}
					}
				});
			}
			
			
		}
	</script>

</body>
</html>