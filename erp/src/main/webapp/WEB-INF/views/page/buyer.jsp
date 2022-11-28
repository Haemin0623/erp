<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../layoutElement/taglib.jsp"%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">

	#searchBox{
		margin: 0 auto;
		width: 90%;
		height: 100px;
		background-color: gray;
		color: white;
	}
	
	table {
		border: 1px solid;
	}
	

	
	.background {
	  position: fixed;
	  top: 0;
	  left: 0;
	  width: 100%;
	  height: 100vh;
	  background-color: rgba(0, 0, 0, 0.3);
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
	  width: 500px;
	  height: 500px;
	  
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
	
	#item {
		border: 1px solid;
	}
	
</style>

</head>
<body>
	
	<h1> 고객 관리</h1>
	<div id="searchBox">
		<form action = "">
		
		고객코드 <input type="text" name="buyerCd">
		고객명 <input type="text" name="name">
		담당자 <input type="text" name="manager">
		국가코드
			<select>
				<c:forEach var="countryCd" items="${countryCdList}">
					<option selected="selected">${countryCd.name}(${countryCd.countryCd})</option>
				</c:forEach>
			</select><br>
		전화번호<input type="text" name="tel">
		이메일 <input type="text" name="email">
		주소 <input type="text" name="address">
		<input type="submit" value="검색">
		</form>	
	</div>
	
	<button id="show">신규등록</button>
	<button id="show">삭제</button>

	<div id="table">
	<table >
		<tr>
			<th>선택</th>
			<th>고객코드</th>
			<th>고객명</th>
			<th>담당자</th>
			<th>전화번호</th>
			<th>이메일</th>
			<th>주소</th>
			<th>국가코드</th>
			<th>수정</th>
		</tr>
		<c:forEach var="buyer" items="${buyerList }">
			<tr>
				<td><input type="checkbox" value="${buyer.del}"></td>
				<td>${buyer.buyerCd }</td>
				<td>${buyer.name }</td>
				<td>${buyer.manager}</td>
				<td>${buyer.tel}</td>
				<td>${buyer.email}</td>
				<td>${buyer.address}</td>
				<td>${buyer.countryCd}</td>
				<td><button id="update">수정</button></td>
			</tr>
		</c:forEach>
	</table>
	</div>
	
<!-- 	등록 창 팝업 -->
	<div class="background">
		<div class="window">
			<div class="popup">
				<button id="close">취소</button>	
				<h1> 고객등록 </h1>
				
				<form action="">
					고객코드<input type="text" name="buyerCd"><br>
					고객명<input type="text" name="name"><br>
					담당자<input type="text" name="manager"><br>
					국가코드
						<select>
							<c:forEach var="countryCd" items="${countryCdList}">
								<option>${countryCd.name}(${countryCd.countryCd})</option>
							</c:forEach>
						</select><br>
					전화번호<input type="text" name="tel"><br>
					이메일<input type="text" name="email"><br>
					주소<input type="text" name="address"><br>
				<button id="addBuyer">등록</button>	
				</form>
				
			</div>
		</div>
	</div>
	
	<!-- 	수정 창 팝업 -->
	<div class="background">
		<div class="window">
			<div class="popup">
				<button id="close">취소</button>	
				<h1> 고객수정 </h1>
				
				<form action="">
					<c:forEach var="buyer" items="${buyerList }">
					활성여부
<!-- 						<select> -->
<%-- 							<c:if test="${buyer.del =='N'}"> --%>
<%-- 								<option c:if test="${buyer.del =='N'}">활성</option> --%>
<%-- 							</c:if> --%>
<!-- 							<option>비활성</option> -->
<!-- 						</select> -->
					고객코드<input type="text" value="${buyer.buyerCd}" name="buyerCd"><br>
					고객명<input type="text" value="${buyer.name}" name="name"><br>
					담당자<input type="text" value="${buyer.manager}" name="manager"><br>
					전화번호<input type="text" value="${buyer.name}" name="tel"><br>
					이메일<input type="text" value="${buyer.email}" name="email"><br>
					주소<input type="text" value="${buyer.address}" name="address"><br>
					국가코드
						<select>
							<c:forEach var="countryCd" items="${countryCdList}">
								<option>${countryCd.name}(${countryCd.countryCd})</option>
							</c:forEach>
						</select><br>
					</c:forEach>
					<button id="updateBuyer">수정</button>	
				</form>
				
			</div>
		</div>
	</div>

</body>

<script type="text/javascript">
	// 등록 팝업 열기 닫기
	function show() {
		document.querySelector(".background").className = "background show";
	}
	
	function close() {
		document.querySelector(".background").className = "background";
	}
	
// 	function update() {
// 		document.querySelector(".background").className = "background update";
// 	}
	
	document.querySelector("#show").addEventListener("click", show);
	document.querySelector("#close").addEventListener("click", close);
// 	document.querySelector("#update").addEventListener("click", update);
	  
</script>

</html>

