<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ include file="taglib.jsp"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ERP</title>

<link rel="stylesheet" type="text/css" href="/erp/resources/css/common.css">


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

#content {
	margin-left: 200px;
	padding-left: 20px;
	padding-right: 20px;
	
	height: 100%;
}

</style>

</head>
<body>
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