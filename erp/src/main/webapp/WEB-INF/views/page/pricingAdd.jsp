<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../layoutElement/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<c:if test="${result > 0 }">
	<script type="text/javascript">
		alert("등록 완료")
		location.reload();
	</script>
</c:if>
<c:if test="${!(result == 0) }">
	<script type="text/javascript">
		alert("등록 실패")
		location.href="pricing.do"
	</script>
</c:if>
</body>
</html>