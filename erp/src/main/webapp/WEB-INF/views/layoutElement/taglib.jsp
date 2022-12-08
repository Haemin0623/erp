<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<!-- 반응형 웹 : 장비에 맞게 폭 설정 -->
<meta name="viewport" content="width=device-width, initialscale=1">
<c:set var="path" value="${pageContext.request.contextPath }"></c:set>
<script type="text/javascript" src="${path }/resources/javaScript/jquery.js"></script>
<!-- 
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.13.1/jquery.min.js"></script> -->
<!-- <script src="http://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script> -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>
<script type="text/javascript">
	var J300 =  $.noConflict(true);	
</script>

<%-- <script type="text/javascript" src="${path }/resources/javaScript/sumoselect/jquery.sumoselect.min.js"></script> --%>
<%-- <link href="${path }/resources/javaScript/sumoselect/sumoselect.min.css" rel="stylesheet" /> --%>

<!-- Latest compiled and minified CSS -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery.sumoselect/3.1.6/sumoselect.min.css">

<!-- Latest compiled and minified JavaScript -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery.sumoselect/3.1.6/jquery.sumoselect.min.js"></script>