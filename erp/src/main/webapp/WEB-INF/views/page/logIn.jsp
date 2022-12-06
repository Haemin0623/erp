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
	<div id="container">
		
	</div>
	
	<div class="background show">
		<div class="window">
			<div class="popup">
				<div class="login-form">
					<form action="login.do">
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