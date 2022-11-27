<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../layoutElement/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<style type="text/css">
	.menuName {
/* 		align-content: center; */
	}

	.searchBox {
		width: 90%;
		height: 200px;
		background: gray;
		margin-left: 50px;
		margin-top: 50px;
	}
	
	.listBox {
		width: 90%;
		height: 600px;
		margin-top: 120px;
		margin-left: 50px;
	}
	
	.keyword {
		font-size: large;
		margin-top: 10px;
		margin-left: 20px;
	}
	
	.submitBtn {
		background: navy;
		color: white;
		cursor: pointer;
	}
	
	table {
		width: 100%;
		border: black;
/* 		background: gray; */
	}
	
	.header {
		background: gray;
	}
	
</style>

</head>
<body>
	<h1 class="menuName">판매가 관리</h1>
	
	<div class="searchBox">
		<form action="search" id="searchList">
			고객코드<input type="text" name="buyerCd" class="keyword">
			상품코드<input type="text" name="productCd" class="keyword">
			판매가<input type="number" name="price" class="keyword">
			유효기간<input type="date" name="validDate" class="keyword">
			할인율<input type="number" name="discountrate" class="keyword">
			통화단위<select name="currency" class="keyword">
					<option>통화단위 선택</option>
					<option value="won">원(₩)</option>
					<option value="dollar">달러($)</option>
					<option value="yen">앤(¥)</option>
					<option value="yuan">위안(元)</option>
				</select>
		<div>
			<input type="submit" value="검색" class="submitBtn">
		</div>
		</form>
	</div>
	
	<div class="listBox">
		<table class="tableList">
			<tr class="header">
				<td>선택</td><td>번호</td><td>고객코드</td><td>상품코드</td><td>판매가</td>
				<td>계약시작일</td><td>계약종료일</td><td>할인율</td><td>최종판매가</td><td>통화단위</td>
			</tr>
			<c:forEach var="pricing" items="">
				<tr>
					<td></td><td></td><td></td><td></td><td></td>
					<td></td><td></td><td></td><td></td><td></td>
				</tr>
			</c:forEach>
		</table>
	</div>
	
</body>
</html>