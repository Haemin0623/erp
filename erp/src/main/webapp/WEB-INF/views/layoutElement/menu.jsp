<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../layoutElement/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<style type="text/css">

	.text-primary {
		font-family: 'KyoboHandwriting2020A';
		font-size: 50px;
		margin-left: 30px;
		color: white;
	}
	
	.text-member {
		font-size: 11px;
		margin-left: 30px;
		color: white;
	}
	
	.line {
	
	}
	
	.line2 {
		margin-top: 120%;
	}

	.menuList {
		font-family: 'GmarketSansMedium';
		margin-right: 10px;
		margin-top: 40px;		
		list-style: none;
		font-weight: bold;
		text-align: right;
		font-size: 30px;
		color: white;
	}
	
	.subMenu {
		font-family: 'BCcardB';
		margin-top: 5px;
		margin-right: 10px;
		list-style: none;
		text-align: right;
		font-size: 20px;
		color: white;
	}
	
	.subMenu:hover {
		background-color: #fcfaee;
	}
	
	a {
		text-decoration-line: none;
        color: #41814e;
	}
	
	a:hover {
		color: black;
	} 
</style>

<script type="text/javascript">
	function changeContent(data) {
		var addr = data;
	
		var ajaxOption = {
			url : addr,
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
</script>

<script type="text/javascript">

</script>

</head>
<body>

	<h1 class="text-primary">쉐어드투</h1>
	<h6 class="text-member">
		<c:if test="${sessionScope.employeeCd != null }">
			${sessionScope.employeeCd }(${sessionScope.ename })
			<a href="logout.do">로그아웃</a>
		</c:if>
	</h6>
	<hr class="line">

	<div>
			<ul>
				<li class="menuList">마스터</li>
				<li id="menu1" class="subMenu"><a href="javascript:void(0);" onclick="changeContent('productList.do')">상품</a></li>
				<li id="menu2" class="subMenu"><a href="javascript:void(0);" onclick="changeContent('buyer.do')">고객</a></li>
				<li id="menu3" class="subMenu"><a href="javascript:void(0);" onclick="changeContent('pricing.do')">판매가</a></li>
				<li id="menu4" class="subMenu"><a href="javascript:void(0);" onclick="changeContent('emp.do')">직원</a></li>
			</ul>
			
			<ul>
				<li class="menuList">주문</li>
				<li id="menu5" class="subMenu"><a href="javascript:void(0);" onclick="changeContent('order.do')">주문 관리</a></li>
				<li id="menu6" class="subMenu"><a href="javascript:void(0);" onclick="changeContent('orderApprovalWindow.do')">주문 승인</a></li>
			</ul>   
			
			<ul>
				<li class="menuList">REPORT</li>
				<li id="menu7" class="subMenu"><a href="javascript:void(0);" onclick="changeContent('orderStatus.do')">주문 현황</a></li>
			</ul>
	</div>
	<hr class="line2">
</body>
</html>