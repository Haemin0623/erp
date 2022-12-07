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

</head>
<body>

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
</body>
</html>