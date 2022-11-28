<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<style type="text/css">
	ul {
		list-style: none;
		text-align: center;
		
	}
	
	li {
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
				<li>고객</li>
				<li><a href="pricing.do">판매가</a></li>
				<li>승인</li>
			</ul>
			
			<ul>
				<li>주문</li>
				<li><button onclick="changeContent('order.do')">주문관리</button></li>
				<li>주문승인</li>
			</ul>
			
			<ul>
				<li>REPORT</li>
				<li>주문 현황</li>
			</ul>
	</div>

</body>
</html>