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
	width: 15%;
	height: 100%;
	background-color: silver;
}

#content {
	position: relative;
	left: 15%;
	width: 85%;
	height: 100%;
}

</style>

</head>
<body style="overflow-y: scroll; overflow-x: hidden; align-content: center;">
	<div>
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