<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
		color: white;
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
<<<<<<< HEAD
=======
			<!-- 	<li><a href="orderApprovalWindow.do">주문 승인</a></li> -->
>>>>>>> 50c6a6c (주문현황 엑셀파일로 다운로드 완료)
			</ul>
			
			<ul>
				<li class="menuList">REPORT</li>
				<li class="subMenu"><a href="javascript:void(0);" onclick="changeContent('orderStatus.do')">주문 현황</a></li>
<<<<<<< HEAD
=======
				<!-- <li><a href="orderStatus.do">주문 현황</a></li> -->
>>>>>>> 50c6a6c (주문현황 엑셀파일로 다운로드 완료)
			</ul>
	</div>
	<hr class="line2">
</body>
</html>