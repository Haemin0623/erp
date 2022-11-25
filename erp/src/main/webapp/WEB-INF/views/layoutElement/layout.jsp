<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ include file="taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>타일즈 테스트</title>

<style type="text/css">

body {
	margin: 0;
}

.menu {
	float: left;
	width: 280px;
	height: 100%;
	background-color: silver;
}

.body {
	height: 100%;
}

</style>

</head>
<body style="overflow-y: scroll; overflow-x: hidden; align-content: center;">
	<div>
		<div class="menu">
			<tiles:insertAttribute name="menu"></tiles:insertAttribute>
		</div>
		<div class="body">
			<tiles:insertAttribute name="body"></tiles:insertAttribute>
		</div>
<!-- 		<div class="footer"> -->
<%-- 			<tiles:insertAttribute name="footer"></tiles:insertAttribute> --%>
<!-- 		</div> -->
	</div>
</body>
</html>