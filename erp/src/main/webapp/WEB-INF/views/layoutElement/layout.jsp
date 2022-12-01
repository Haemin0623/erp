<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ include file="taglib.jsp"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ERP</title>




<style type="text/css">

body {
	margin: 0;
}

#menu {
	float: left;
	width: 250px;
	height: 100vh;
	background-color: #5b6996;
}

#content {
/* 	position: relative; */
/* 	left: 15%; */
/* 	width: 85%; */
/* 	height: 100%; */ 
	height: 100vh;
}

</style>

</head>
<body>
	<div style="display:flex;">
		<div id="menu">
			<tiles:insertAttribute name="menu"></tiles:insertAttribute>
		</div>
		<div id="content">
			<tiles:insertAttribute name="content"></tiles:insertAttribute>
		</div>
<!-- 		<div class="footer"> -->
<%-- 			<tiles:insertAttribute name="footer"></tiles:insertAttribute> --%>
<!-- 		</div> -->
	</div>
</body>
</html>