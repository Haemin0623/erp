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
	
		/* 마우스 오버(마우스 올렸을때) */
	tr{
	color: black;
	}
	tr:hover{
	    background-color: #f4f4f4;
	    cursor: pointer;
	}
	/* 마우스 클릭하고있을때 */
	tr:active{
	    background-color: #B9E2FA;
	}
	
	.clickColor {
		background-color: #B9E2FA;
		
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
	<h1>승인 권한 관리</h1>
	
	<div id="searchBox">
		<form name="searchBoxx">		
			직원코드<input type="text" name="employeeCd" value="${employee.employeeCd }">
			직원명<input type="text" name="ename" value="${employee.ename }">
			직책<input type="text" name="job" value="${employee.job }">
			부서<input type="text" name="department" value="${employee.department }">
			
			승인권한
			<select name="authority">
				<option value="null">모두</option>			
				<option value="Y">있음</option>			
				<option value="N">없음</option>
			</select>
			
		</form>
			<button id="searchBtn">검색</button>
	</div>
	
	<button id="show">추가 </button>
	
	<div id="table">
		<table>
			<tr>
				<th>선택</th>
				<th>직원코드</th>
				<th>직원명</th>
				<th>직책</th>
				<th>부서</th>
				<th>등록일</th>
				<th>승인권한</th>
				<th>상태변경일</th>
			</tr>
			<c:forEach var="emp" items="${empList }">			
				<tr class="itemRow">
					<td class="editable"><input type="checkbox" value="${emp.employeeCd }"></td>
					<td class="editable">${emp.employeeCd }</td>
					<td class="editable">${emp.ename }</td>
					<td class="editable">${emp.job }</td>
					<td class="editable">${emp.department }</td>
					<td class="editable">${emp.adddate }</td>
					<td class="editable">${emp.authority }</td>
					<td class="editable">${emp.statusdate }</td>
				</tr>
			</c:forEach>
		</table>
	</div>
	


	<!-- 등록 창 팝업 -->
	<div class="background">
		<div class="window">
			<div class="popup">
			
				<button id="close">팝업닫기</button>
				
				<form action="" name="frm">
					직원코드<input type="text" name="employeeCd" readonly="readonly"><br>
					직원명<input type="text" name="ename"><br>
					직책<input type="text" name="job"><br>
					부서<input type="text" name="department"><br>
					승인권한
					<select name="authority">
						<option value="N">없음</option>
						<option value="Y">있음</option>
					</select><br>
				</form>
				<button id="addItem">추가</button>
				
				
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
	
	document.querySelector("#show").addEventListener("click", show);
	document.querySelector("#close").addEventListener("click", close);
	
	function callView(request) {
		var addr = request;
	
		var ajaxOption = {
			url : request,
			async : true,
			type : "POST",
			dataType : "html",
			cache : false
		};
	
		$.ajax(ajaxOption).done(function(data) {
			$('#content').children().remove();
			$('#content').html(data);
		});
	}
	
</script>

<!-- 검색용 -->
<script type="text/javascript">
	function search() {
				
		const keyword = {
			orderNo : searchBoxx.orderNo.value,	
			buyerCd : searchBoxx.buyerCd.value,	
			orderFromDate : searchBoxx.orderFromDate.value,	
			orderToDate : searchBoxx.orderToDate.value,	
			employeeCd : searchBoxx.employeeCd.value,	
			status : searchBoxx.status.value,	
			productCd : searchBoxx.productCd.value,	
			requestFromDate : searchBoxx.requestFromDate.value,
			requestToDate : searchBoxx.requestToDate.value,
			window : '주문관리'
		}
		console.log(keyword);
		
		$.ajax({
		     method: 'post',
		     url: 'orderSearch.do',
		     traditional: true,
		     data: {
		    	keyword: JSON.stringify(keyword)
		     },
		     success: function (result) {
		    	 $('#content').children().remove();
				 $('#content').html(result);
			 }
	   });

	};

document.querySelector("#searchBtn").addEventListener("click", search);
</script>

<!-- 테이블 요소 더블클릭 하면 수정 가능 input으로 변경 -->
<script>
    $(document).ready(function() {
        $(document).on("dblclick", ".editable", function() {
            var value=$(this).text();
            var input="<input type='text' class='input-data' value='"+value+"' class='form-control'>";
            $(this).html(input);
            $(this).removeClass("editable")
        });
        $(document).on("blur", ".input-data", function() {
            var value=$(this).val();
            var td=$(this).parent("td");
            $(this).remove();
            td.html(value);
            td.addClass("editable")
            });
        $(document).on("keypress", ".input-data", function(e) {
            var key=e.which;
            if(key==13) {
                var value=$(this).val();
                var td=$(this).parent("td");
                $(this).remove();
                td.html(value);
                td.addClass("editable");
            }
        });
   });
</script>

</html>