<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<form action="login.do">
		<table>
			<tr>
				<th>사번</th>
				<td>
					<input type="text" name="employeeCd">
				</td>
			</tr>
			<tr>
				<th>패스워드</th>
				<td>
					<input type="password" name="password">
				</td>
			</tr>
			<tr>
				<td>
					<input type="submit" value="로그인">
				</td>
			</tr>	
		</table>
	</form>
</body>
</html>