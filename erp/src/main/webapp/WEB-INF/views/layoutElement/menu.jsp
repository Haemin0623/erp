<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<style type="text/css">
	.menuList {
		list-style: none;
		text-align: center;
		
	}
	
	.subMenu {
		font-weight: bold;
		font-size: 40px;
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

	<h2 class="text-primary">2조</h2>

	<!-- <table class="table"> -->
	<%-- 	<tr><td><a class="btn btn-success" href="${path }/home/home">홈</a></td></tr> --%>
	<%-- 	<tr><td><a class="btn btn-info" href="${path }/home/first">정은지</a></td></tr> --%>
	<%-- 	<tr><td><a class="btn btn-warning" href="${path }/test/second">프로듀스</a></td></tr> --%>
	<%-- 	<tr><td><a class="btn btn-danger" href="${path }/test/third">투아이스</a></td></tr> --%>
	<%-- 	<tr><td><a class="btn btn-danger" href="${path }/nolay/test1">노레이아웃</a></td></tr> --%>
	<!-- </table> -->

	<div>
		

			<ul>
				<li>마스터</li>
				<li><a href="productList.do">상품</a></li>
				<li><a href="buyer.do">고객</a></li>
				<li><a href="#" onclick="changeContent('pricing.do')">판매가</a></li>
				<li><button onclick="changeContent('emp.do')">승인</button></li>
			</ul>
			
			<ul class="menuList">
				<li class="subMenu">주문</li>
				<li class="subMenu"><button onclick="changeContent('order.do')">주문 관리</button></li>
				<li class="subMenu"><button onclick="changeContent('orderApprovalWindow.do')">주문 승인</button></li>
				<li class="subMenu">주문승인</li>
			</ul>
			
			<ul class="menuList">
				<li class="subMenu">REPORT</li>
				<li class="subMenu"><button onclick="changeContent('orderStatus.do')">주문 현황</button></li>
				<!-- <li><a href="orderStatus.do">주문 현황</a></li> -->
			</ul>
	</div>

</body>
</html>