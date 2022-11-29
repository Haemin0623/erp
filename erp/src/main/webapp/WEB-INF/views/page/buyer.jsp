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
		고객명 <input type="text" name="bname">
		담당자 <input type="text" name="manager">
		국가코드
			<select>
				<c:forEach var="countryCd" items="${countryCdList}">
					<option selected="selected">${countryCd.cname}(${countryCd.countryCd})</option>
				</c:forEach>
			</select><br>
		전화번호<input type="text" name="tel">
		이메일 <input type="text" name="email">
		주소 <input type="text" name="address">
		<input type="submit" value="검색">
		</form>	
	</div>
	
	<button id="show">신규등록</button>
	<button id="delBuyer">삭제</button>

	<div id="table">
	<form action="" name="bt">
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
			<th>등록일</th>
			<th>최종수정일</th>
			<th>수정</th>
		</tr>
		<c:forEach var="buyer" items="${buyerList }">
			<tr>
				<td>
					<c:if test="${buyer.del =='Y'}"> <!-- del값이 Y이면 보여주지않고, N이면 보여준다 -->
						<input type="checkbox" name="del" value="${buyer.buyerCd}" disabled="disabled">
					</c:if>
					<c:if test="${buyer.del =='N'}">
						<input type="checkbox" name="del" value="${buyer.buyerCd}">
					</c:if>
				</td>
				<td>${buyer.buyerCd }</td>
				<td>${buyer.bname }</td>
				<td>${buyer.manager}</td>
				<td>${buyer.tel}</td>
				<td>${buyer.email}</td>
				<td>${buyer.address}</td>
				<td>${buyer.countryCd}</td>
				<td>${buyer.adddate}</td>
				<td>${buyer.statusdate}</td>
				<td><button id="update">수정</button></td>
			</tr>
		</c:forEach>
	</table>
	</form>
	</div>
	
<!-- 	등록 창 팝업 -->
	<div class="background">
		<div class="window">
			<div class="popup">
				<button id="close">취소</button>	
				<form action="" name="frm">
				<h1> 고객등록 </h1>
				<table> 
					<tr>
						<th>고객코드</th>
						<td><input type="text" name="buyerCd"></td>
					</tr>
					<tr>
						<th>고객명</th>
						<td><input type="text" name="bname"></td>
					</tr>
					<tr>
						<th>담당자</th>
						<td><input type="text" name="manager"></td>
					</tr>
					<tr>
						<th>전화번호</th>
						<td><input type="text" name="tel"></td>
					</tr>
					<tr>
						<th>이메일</th>
						<td><input type="text" name="email"></td>
					</tr>
					<tr>
						<th>주소</th>
						<td><input type="text" name="address"></td>
					</tr>
					<tr>
						<th>국가코드</th>
						<td>
							<select name="countryCd"> <!-- countryCd.countryCd을 값으로, countryCd를 키로 보냄 -->
								<c:forEach var="countryCd" items="${countryCdList}">
									<option value="${countryCd.countryCd}">${countryCd.cname}(${countryCd.countryCd})</option>
								</c:forEach>
							</select>
						</td>
					</tr>
				</table>

				</form>
					<button id="addBuyer">등록</button>
			</div>
		</div>
	</div>
	
	<!-- 	수정 창 팝업 -->
<!-- 	<div class="background"> -->
<!-- 		<div class="window"> -->
<!-- 			<div class="popup"> -->
<!-- 				<button id="close">취소</button>	 -->
<!-- 				<h1> 고객수정 </h1> -->
				
<!-- 				<form action=""> -->
<%-- 					<c:forEach var="buyer" items="${buyerList }"> --%>
<!-- 					활성여부 -->
<!-- <!-- 						<select> -->
<%-- <%-- 							<c:if test="${buyer.del =='N'}"> --%>
<%-- <%-- 								<option c:if test="${buyer.del =='N'}">활성</option> --%>
<%-- <%-- 							</c:if> --%>
<!-- <!-- 							<option>비활성</option> -->
<!-- <!-- 						</select> -->
<%-- 					고객코드<input type="text" value="${buyer.buyerCd}" name="buyerCd"><br> --%>
<%-- 					고객명<input type="text" value="${buyer.bname}" name="bname"><br> --%>
<%-- 					담당자<input type="text" value="${buyer.manager}" name="manager"><br> --%>
<%-- 					전화번호<input type="text" value="${buyer.tel}" name="tel"><br> --%>
<%-- 					이메일<input type="text" value="${buyer.email}" name="email"><br> --%>
<%-- 					주소<input type="text" value="${buyer.address}" name="address"><br> --%>
<!-- 					국가코드 -->
<!-- 						<select> -->
<%-- 							<c:forEach var="countryCd" items="${countryCdList}"> --%>
<%-- 								<option>${countryCd.cname}(${countryCd.countryCd})</option> --%>
<%-- 							</c:forEach> --%>
<!-- 						</select><br> -->
<%-- 					</c:forEach> --%>
<!-- 					<button id="updateBuyer">수정</button>	 -->
<!-- 				</form> -->
				
<!-- 			</div> -->
<!-- 		</div> -->
<!-- 	</div> -->
	
	
</body>


<script type="text/javascript">
	// 등록 팝업 열기 닫기
	function show() {
		document.querySelector(".background").className = "background show";
	}
	function close() {
		document.querySelector(".background").className = "background";
	}
	// 신규등록 팝업 열기
	function addBuyer() {
			$.ajax({ //포스트 방식으로 아래의 주소에 데이터 전송
			     method: 'post', 
			     url: 'buyerInsert.do', 
			     traditional: true,
			     data: { //서버로 데이터를 전송할때  키와 벨류로 전달. BuyerController로 buyer객체에 담겨서 보내짐
			    	buyerCd: frm.buyerCd.value,
					bname: frm.bname.value,
					manager: frm.manager.value,
					tel: frm.tel.value,
					email: frm.email.value,
					address: frm.address.value,
					countryCd: frm.countryCd.value
			     },
			     success: function (result) { //성공했을떄 호출할 콜백을 지정
			    	 console.log(result);
			        if (result) {
						alert("입력성공");
			        } else {
			        	alert("실패");
			        }
				}
		   });
		}
	
	function delBuyer() {
		var cdArr = new Array(); //del 체크가 여러개일수도 있기에 배열로 받음
		$("input[name='del']:checked").each(function() { //input태그의 이름이 del인 것이 check되면 아래 함수 실행
			cdArr.push($(this).val()); //value는 buyerCd
		});
		console.log(cdArr);
		
		if(cdArr=='') {
			alert("삭제할 고객을 선택하세요");
			return false;
		}
		$.ajax({ //포스트 방식으로 아래의 주소에 데이터 전송
		     method: 'post', 
		     url: 'buyerDelete.do', 
		     traditional: true,
		     data: { //서버로 데이터를 전송할때  키와 벨류로 전달. BuyerController로 buyer객체에 담겨서 보내짐
		    	delBuyers : cdArr
			 },
		     success: function (result) { //성공했을떄 호출할 콜백을 지정
		        if (result > 0) {
		        	document.location.reload(); // 삭제성공시, 페이지 새로고침
					alert("삭제완료");
		        } else {
		        	alert("삭제실패");
		        	console.log(result);
		        }
			},
			 error: function(a, b, c) {
				 console.log(a);
				 console.log(b);
				 console.log(c);
			 }
	   });
	};

	document.querySelector("#addBuyer").addEventListener("click", addBuyer); 
	//아이디 addBuyer를 클릭하면 addBuyer함수를 호출 
	
	document.querySelector("#show").addEventListener("click", show);
	document.querySelector("#close").addEventListener("click", close);
// 	document.querySelector("#update").addEventListener("click", update);
	document.querySelector("#delBuyer").addEventListener("click", delBuyer);
	  
</script>

</html>

