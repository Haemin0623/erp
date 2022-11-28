<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
    
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
    


<style type="text/css">
	th{
		border: 1px solid green;
		margin: 0;
	}
	td{
		border: 1px solid green;
		margin: 0;
	}
	
	
	#searchBox{
		width:70%; 
		border: 1px solid green;
		margin-left: 20%;
	}
	#productList{
		width: 70%;
	}
</style>

</head>
<body>
	<h2>상품관리</h2>
	<div id="searchBox">
		<form action="">
				<span>
					상품코드 <input type="text" name="productCodeSearch">
				</span>
				<span>
					상품명 <input type="text" name="productNameSearch">
				</span>
				<span>
					용량 <input type="text" name="productVolumeSearch">
				</span>
				<span>
					상품카테고리 <input type="text" name="productCategorySearch">
				</span>
				<span>
					등록일 <input type="text" name="productAdddDateSearch1"> ~ <input type="text" name="productAdddDateSearch2">
				</span>
				<span>
					상태 <select>
							<option value="" selected="selected">모두보기
							<option value="N">등록중
							<option value="Y">삭제완료
						</select>
				</span>
				<input type="submit" value="검색" style="float: right;">
		</form>
	</div>
	
<div id="productList">
	<span>
		<button>등록</button>
		<button>삭제</button>
	</span>	
	<span>
		<select>
			<option>10개씩보기</option>
			<option>50개씩보기</option>
			<option>100개씩보기</option>
			<option>300개씩보기</option>
			<option>500개씩보기</option>
		</select>
	</span>
	<form action="">
		<table>
			<tr>
				<th>선택</th>
				<th>판매부번코드</th>
				<th>상품명</th>
				<th>용량</th>
				<th>단위</th>
				<th>상품 카테고리</th>
				<th>등록일</th>
				<th>상품 수정</th>
			</tr>
			<c:forEach var="productList" items="${productList }">
			<tr>
					<td><input type="checkbox"></td>
					<td>${productList.productCd }</td>
					<td>${productList.name}</td>
					<td>${productList.volume}</td>
					<td>${productList.unit}</td>
					<td>${productList.category}</td>
					<td>${productList.adddate}</td>
					<td>수정버튼</td>
			</tr>
			</c:forEach>
		</table>
	</form>
</div>
</body>
</html>