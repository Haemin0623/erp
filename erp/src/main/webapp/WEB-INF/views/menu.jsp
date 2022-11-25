<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="header.jsp" %>
<!DOCTYPE html><html><head><meta charset="UTF-8">
<title>Insert title here</title></head><body>
<h2 class="text-primary">메뉴</h2>
<table class="table">
	<tr><td><a class="btn btn-success" href="${path }/home/home">홈</a></td></tr>
	<tr><td><a class="btn btn-info" href="${path }/home/first">정은지</a></td></tr>
	<tr><td><a class="btn btn-warning" href="${path }/test/second">프로듀스</a></td></tr>
	<tr><td><a class="btn btn-danger" href="${path }/test/third">투아이스</a></td></tr>
	<tr><td><a class="btn btn-danger" href="${path }/nolay/test1">노레이아웃</a></td></tr>
</table>
</body>
</html>