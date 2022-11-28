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
		height: 150px;
		background: gray;
		margin-left: 50px;
		margin-top: 50px;
		color: white;
	}
	
	.listBox {
		width: 90%;
		height: 600px;
		margin-top: 50px;
		margin-left: 50px;
	}
	
	.keyword {
		margin-top: 10px;
		margin-left: 20px;
	}
	
	.submitBtn {
		background: navy;
		color: white;
		cursor: pointer;
		float: right;
		margin-right: 50px;
	}
	
	table {
		width: 100%;
		border: black;
		position: absolute;
		    width: inherit;
	}
	
	.header td {
		background: gray;
		color: white;
	}
	
	.list {
 		background: silver;
	}
	
	
	/* 팝업 추가창 start*/
	.background {
	  position: fixed;
	  top: 0;
	  left: 0;
	  width: 100%;
	  height: 100vh;
	  background-color: rgba(0, 0, 0, 0.5);
	  z-index: 1000;
	  
	  /* 숨기기 */
	  z-index: -1;
	  opacity: 0;
	}
	
	.window {
	  position: relative;
	  width: 100%;
	  height: 100%;
	}
	
	.popup {
	  position: absolute;
	  top: 50%;
	  left: 50%;
	  transform: translate(-50%, -50%);
	  background-color: #ffffff;
	  box-shadow: 0 2px 7px rgba(0, 0, 0, 0.3);
	  
	  /* 임시 지정 */
	  width: 750px;
	  height: 600px;
	  
	  /* 초기에 약간 아래에 배치 */
	  transform: translate(-50%, -40%);
	}
	
	.show {
	  opacity: 1;
	  z-index: 1000;
	  transition: all .5s;
	}
	
	.show .popup {
	  transform: translate(-50%, -50%);
	  transition: all .5s;
	}
	
	#close {
		float: right;
		font-size: x-large;
	}
	
	.writeForm {
		margin-left: 50px;
		margin-top: 50px;
	}
	/* 팝업 추가창 end*/
	
</style>

<script type="text/javascript">

/* function searchList(){
	$.ajax({
		type: 'GET',
		url : "/searchList",
		data : $("form[name=search-form]").serialize(),
		success : function(result){
			//테이블 초기화
			$('#boardtable > tbody').empty();
			if(result.length>=1){
				result.forEach(function(item){
					str='<tr>'
					str += "<td>"+item.idx+"</td>";
					str+="<td>"+item.writer+"</td>";
					str+="<td><a href = '/board/detail?idx=" + item.idx + "'>" + item.title + "</a></td>";
					str+="<td>"+item.date+"</td>";
					str+="<td>"+item.hit+"</td>";
					str+="</tr>"
					$('#boardtable').append(str);
        		})				 
			}
		}
	})
} */

</script>

</head>
<body>
	<h1 class="menuName">판매가 관리</h1>
	
	<!-- 검색 박스 -->
	<div class="searchBox">
		<form action="pricing.do" id="searchList">
			<p>고객코드<input type="text" name="buyerCd" class="keyword">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				상품코드<input type="text" name="productCd" class="keyword"></p><p>
			<p>판매가<input type="number" name="price" class="keyword">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				유효기간<input type="date" name="validDate" class="keyword"></p><p>
				할인율<input type="number" name="discountrate" class="keyword">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<select name="currency" class="keyword">
					<option>통화단위 선택</option>
					<option value="won">원(₩)</option>
					<option value="dollar">달러($)</option>
					<option value="yen">앤(¥)</option>
					<option value="yuan">위안(元)</option>
				</select>
			
				<input type="submit" value="검색" class="submitBtn">
			
		</form>
	</div>
	<br>
	<button id="show">추가 </button>
	
	<!-- 리스트 박스 -->
	<div class="listBox">
		<table class="tableList">
			<tr class="header">
				<td>선택<input type="checkbox"></td><td>번호</td><td>고객코드</td><td>상품코드</td><td>판매가</td>
				<td>계약시작일</td><td>계약종료일</td><td>할인율</td><td>최종판매가</td><td>통화단위</td>
			</tr>
			<c:if test="${empty pricingList}">
				검색 결과가 없습니다
			</c:if>
			<c:if test="${not empty pricingList}">
				<c:forEach var="pricing" items="${pricingList}">
					<tr class="list">
						<td><input type="checkbox"></td><td><%-- ${pricing.count } --%></td><td>${pricing.buyerCd }</td>
						<td>${pricing.productCd }</td><td>${pricing.price }</td><td>${pricing.startdate }</td>
						<td>${pricing.enddate }</td><td>${pricing.discountrate }</td><td>${pricing.price }</td>
						<td>${pricing.currency }</td>
					</tr>
				</c:forEach>
			</c:if>
		</table>
	</div>
	
	
	<!-- 등록 창 팝업 -->
	<div class="background">
		<div class="window">
			<div class="popup">
				<button id="close">X</button>
				<div class="writeForm">
				
				<form action="insert" name="frm">
					<p>고객명<input type="text" name="buyerName">&nbsp;&nbsp;&nbsp;&nbsp;
					고객코드<input type="text" name="buyerCd"></p><p>
					<p>상품명<input type="text" name="productName">&nbsp;&nbsp;&nbsp;&nbsp;
					상품코드<input type="text" name="productCd"></p><p>
					판매가<input type="number" name="price"><br>
					<p>계약시작일<input type="date" name="startdate">&nbsp;&nbsp;&nbsp;&nbsp;
					계약종료일<input type="date" name="enddate"></p><p>
					<p>할인율<input type="number" name="discountrate">&nbsp;&nbsp;&nbsp;&nbsp;
					<select name="currency">
						<option>통화단위 선택</option>
						<option value="won">원(₩)</option>
						<option value="dollar">달러($)</option>
						<option value="yen">앤(¥)</option>
						<option value="yuan">위안(元)</option>
					</select><p>
					비고<textarea rows="5" cols="40" name="remark"></textarea>
				</form>
				<button id="addItem">추가</button>
				<div id="addItemTable">
					 
				</div>
				
				</div>
			</div>
		</div>
	</div>
	
</body>

<script type="text/javascript">

	//등록 팝업 열기 닫기
	function show() {
		document.querySelector(".background").className = "background show";
	}
	
	function close() {
		document.querySelector(".background").className = "background";
	}
	
	document.querySelector("#show").addEventListener("click", show);
	document.querySelector("#close").addEventListener("click", close);
</script>

</html>