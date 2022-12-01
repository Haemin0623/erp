<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../layoutElement/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<style type="text/css">

	#container {
		margin-left: 50px;
	}

	#searchBox {
 		height: 150px;
 		width: 120vh;
		background: #5b6996;
		margin-top: 50px;
		color: white;
	}	
	
	#table{
		overflow: auto;
		height: 40vh;
		width: 120vh;
	}
	
	tr th {
		background: #5b6996;
		color: white;
	}
	
	#list {
		width: 100%;
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
<div id="container">
	<h1>승인 권한 관리</h1>
	
	<div id="searchBox">
		<form name="searchBoxx">		
			직원코드<input type="text" name="employeeCd" value="${employee.employeeCd }">
			직원명<input type="text" name="ename" value="${employee.ename }">
			직책<input type="text" name="job" value="${employee.job }">
			부서<input type="text" name="department" value="${employee.department }">
			등록일<input type="date" name="addFromDate" value=${employee.addFromDate }>
			~<input type="date" name="addToDate" value=${employee.addToDate }>
			
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
		<table id="list">
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
					<td><input type="checkbox" value="${emp.employeeCd }"></td>
					<td>${emp.employeeCd }</td>
					<td class="editable">${emp.ename }</td>
					<td class="editable">${emp.job }</td>
					<td class="editable">${emp.department }</td>
					<td>${emp.adddate }</td>
					<td class="editable">${emp.authority }</td>
					<td>${emp.statusdate }</td>
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
					직원코드<input type="text" name="employeeCd"><br>
					암호<input type="password" name="password"><br>
					직원명<input type="text" name="ename"><br>
					직책<input type="text" name="job"><br>
					부서<input type="text" name="department"><br>
					승인권한
					<select name="authority">
						<option value="N">없음</option>
						<option value="Y">있음</option>
					</select><br>
				</form>
				<button id="addEmp">등록</button>
				
				
			</div>
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

<script type="text/javascript">
	function addEmp() {
		$.ajax({
		     method: 'post',
		     url: 'empInsert.do',
		     traditional: true,
		     data: {
		    	 employeeCd : frm.employeeCd.value,
		    	 ename : frm.ename.value,
		    	 password : frm.password.value,
		    	 job : frm.job.value,
		    	 department : frm.department.value,
		    	 authority : frm.authority.value		    	 
		     },
		     dataType: 'json',
		     success: function (result) {
		        if (result) {
					callView('emp.do');
		        } else {
		        	alert("실패");
		        }
			}
	   });
		
	}
	
	document.querySelector("#addEmp").addEventListener("click", addEmp);
</script>

<!-- 검색용 -->
<script type="text/javascript">
	function search() {
				
		const keyword = {
				employeeCd : searchBoxx.employeeCd.value,	
				ename : searchBoxx.ename.value,	
				job : searchBoxx.job.value,	
				department : searchBoxx.department.value,	
				addFromDate : searchBoxx.addFromDate.value,	
				addToDate : searchBoxx.addToDate.value,	
				authority : searchBoxx.authority.value
		}
		console.log(keyword);
		
		$.ajax({
		     method: 'post',
		     url: 'empSearch.do',
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
<script type="text/javascript">
$(document).ready(function() {
	
	let initValue=""; //초기에 있던 값을 전역변수로 선언(수정하다가 커서가 다른곳 클릭하면 원래값으로 돌아가게). 새로불러오면서 다시 설정하므로 변수 설정위치도 중요
	
    $(document).on("dblclick", ".editable", function() { //editable 클래스를 더블클릭했을때 함수실행
     	 initValue=$(this).text(); //원래 있던 값을 value로 해서 input에 텍스트로 보여줘
         var input="<input type='text' class='input-data' value='"+initValue+"' class='form-control' id='focus'>";
         $(this).removeClass("editable")
         $(this).html(input);
         $('#focus').focus();
         
         $(".input-data").keypress(function(e) { //위의 해당 input-data 클래스의 키눌렀을떄 함수 실행
             var key=e.which;
         
             if(key==13) { //13은 enter키를 의미.테이블이 click을 받아 active 상태가 됐을때 enter눌러주면 그 값을 가지고 td로 
                 var value=$(this).val(); // 새로 입력한 값을 value에 
                 var td=$(this).parent("td"); 
                 td.html(value);
                 td.addClass("editable");
             
                 // 테이블의 Row 클릭시 값 가져오기
 	            $("#list tr").keypress(function(){    
 	
 		            const str = ""
 		            const tdArr = new Array(); // 배열 선언
 		             
 		             // 현재 클릭된 Row(<tr>)
 		            const tr = $(this);
 		            const tdd = tr.children();
 		             
 		             // tr.text()는 클릭된 Row 즉 tr에 있는 모든 값을 가져온다.
 		             console.log("클릭한 Row의 모든 데이터 : "+tr.text());
 		             
 		             // 반복문을 이용해서 배열에 값을 담아 사용할 수 도 있다.
 		             tdd.each(function(i){
  		             tdArr.push(tdd.eq(i).text());
 		             });
 		             
 		             console.log("배열에 담긴 값 : "+tdArr);
 		             
 		             // td.eq(index)를 통해 값을 가져올 수도 있다.
 		             employeeCd = tdd.eq(1).text();
 		             ename = tdd.eq(2).text();
 		             job = tdd.eq(3).text();
 		             department = tdd.eq(4).text();
 		             authority = tdd.eq(6).text();
 	             
               $.ajax({ //포스트 방식으로 아래의 주소에 데이터 전송
   			     method: 'post', 
   			     url: 'empUpdate.do', 
   			     traditional: true,
   			     data: { //서버로 데이터를 전송할때  키와 벨류로 전달. BuyerController로 buyer객체에 담겨서 보내짐
   			    	employeeCd: employeeCd,
   			    	ename: ename,
   			    	job: job,
   			    	department: department,
   			    	authority: authority
   			     },
   			     success: function (result) { //성공했을떄 호출할 콜백을 지정
   			    	 console.log(result);
   			        if (result) {
   						alert("수정성공");
   						search(); // 수정후에도 검색된 페이지 유지하게
   			        } else {
   			        	alert("수정실패");
   			        }
   				}
   		   	});
 	            });
            	}
         });
     });

     $(document).on("blur", ".input-data", function() { //그 칸에서 포커스out 되면 발생하는 함수
         alert(initValue);
         var td=$(this).parent("td"); // 해당 td를 td에 저장
         $(this).remove();
         td.html(initValue);
         td.addClass("editable")
         });
});
</script>

</html>