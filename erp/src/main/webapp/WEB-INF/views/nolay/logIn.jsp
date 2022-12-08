<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../layoutElement/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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
	  width: 400px;
	  height: 200px;
	  
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
	}
	th {
		border : none;
	}
	td {
		border : none;
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
				<div class="login-form">
					<form action="login.do" method="post">
						<table>
							<tr>
								<th>사번</th>
								<td>
									<input type="text" name="employeeCd">
								</td>
								<td rowspan="2">
									<input type="submit" value="로그인">
								</td>
							</tr>
							<tr>
								<th>패스워드</th>
								<td>
									<input type="password" name="password">
								</td>
							</tr>	
						</table>
					</form>
				</div>			
			</div>
		</div>
	</div>
</body>
</html>