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
		margin: 0 auto;
		width: 90%;
		height: 100px;
		background-color: gray;
		color: white;
	}
	
	#productList{
		width: 70%;
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
</style>


</head>
<body>
	<h2>상품관리</h2>
	<div id="searchBox">
		<form action="productList.do">
				<span>
					상품코드 <input type="text" name="productCd">
				</span>
				<span>
					상품명 <input type="text" name="pname">
				</span>
				<span>
					용량 <input type="text" name="volume">
				</span>
				<span>
					상품카테고리 <input type="text" name="category">
				</span>
				<span>
					등록일 <input type="text" name="adddDate"> ~ <input type="text" name="adddDate2">
				</span>
				<span>
				상태 <select name="del">
						<option value="null">모두보기
						<option value="N" selected="selected">등록중
						<option value="Y">삭제완료
					</select>
				</span>
				<input type="submit" value="검색" >
		</form>
	</div>
	
<div id="productList">
	<span>
		<button id="show">상품등록 </button>
		<button type="button" onclick="deleteAction()">삭제</button>
		<button>엑셀로 대량등록</button>
	</span>	
	<span>
		<select name="listNum">
			<option id="listview" value="10">10개씩보기</option>
			<option id="listview" value="50">50개씩보기</option>
			<option id="listview" value="100">100개씩보기</option>
			<option id="listview" value="300">300개씩보기</option>
			<option id="listview" value="500">500개씩보기</option>
		</select>
	</span>
	<form action="">
		<table id="list">
			<tr>
				<th><input type="checkbox" name="checkAll" id="th_checkAll"></th>
				<th>상품코드</th>
				<th>상품명</th>
				<th>용량</th>
				<th>단위</th>
				<th>상품 카테고리</th>
				<th>등록일</th>
				<th>최종수정일</th>
				<th>삭제여부</th>
			</tr>
			<c:forEach var="productList" items="${productList }">
			<tr>
				<td>
				<c:if test="${productList.del=='Y'}">
					<input type="checkbox" name="checkRow" value="${productList.productCd }" disabled="disabled" >
				</c:if>
				<c:if test="${productList.del!='Y'}">
					<input type="checkbox" name="checkRow" value="${productList.productCd }" >
				</c:if>
				</td>
				<td>${productList.productCd }</td>
				<td id="editable">${productList.pname}</td>
				<td id="editable">${productList.volume}</td>
				<td id="editable">${productList.unit}</td>
				<td id="editable">${productList.category}</td>
				<td>${productList.adddate}</td>
				<td>${productList.statusdate}</td>
				<td>${productList.del}</td>
			</tr>
			</c:forEach> 
		</table>
	</form>
	<div align="center">
			<!-- 시작페이지가 pagePerBlock(10)보다 크면 앞에 보여줄 것이 있다 -->		
		<c:if test="${pb.startPage > pb.pagePerBlock}">
			<a href="productList.do?pageNum=1">
				<span class="glyphicon glyphicon-fast-backward"></span></a>
			<a href="productList.do?pageNum=${pb.startPage-1 }">
				<span class="glyphicon glyphicon-triangle-left"></span></a>
		</c:if>
		<c:forEach var="i" begin="${pb.startPage }" end="${pb.endPage }">
			<c:if test="${pb.currentPage == i }">
				<a href="productList.do?pageNum=${i }">${i }</a>
			</c:if>
			<c:if test="${pb.currentPage != i }">
				<a href="productList.do?pageNum=${i }">${i }</a>
			</c:if>		
		</c:forEach>
		<!-- endPage보다 totalPage가 크면 보여줄 것이 뒤에 남아 있다 -->
		<c:if test="${pb.endPage < pb.totalPage}">
			<a href="productList.do?pageNum=${pb.endPage+1 }">
				<span class="glyphicon glyphicon-triangle-right"></span></a>
			<a href="productList.do?pageNum=${pb.totalPage }">
				<span class="glyphicon glyphicon-fast-forward"></span></a>
		</c:if>		
	</div>
</div>
<div class="background">
	<div class="window">
		<div class="popup">
			<form action="" name="frm">
			<p>상품등록</p>
				카테고리<select name="category" id="codeMix" autofocus="autofocus">
					<option value="라면">라면</option>
					<option value="스낵">스낵</option>
					<option value="음료">음료</option>
				</select><br>
				상품코드<input type="text" name="productCd" readonly="readonly"><br>
				상품명<input type="text" name="pname" required="required"><br>
				용량<input type="text" name="volume" required="required"><br>
				단위<input type="text" name="unit" required="required"><br>
				
			</form>
			<button id="addItem">추가</button>
			<button id="close">닫기</button>
		</div>
	</div>
</div>
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
	
	
	function checkAll(){
	    if( $("#th_checkAll").is(':checked') ){
	      $("input[name=checkRow]").prop("checked", true);
	    }else{
	      $("input[name=checkRow]").prop("checked", false);
	    }
	}
	
	document.querySelector("#th_checkAll").addEventListener("click", checkAll);

	function deleteAction(){
		  var checkRow = new Array();
		  $( "input[name='checkRow']:checked" ).each (function (){
		    checkRow.push($(this).val()) ;
		  });
		  
		  console.log(checkRow);
		  
		  if(checkRow == ''){
		    alert("삭제할 대상을 선택하세요.");
		    return false;
		  }
		  $.ajax({
			    url : "productDelete.do",
			    type : "post",
			    traditional : true,
			    data : { checkRows : checkRow },
			    
			    success : function(result){
			    	if(result ==1){
			    		document.location.reload();
			    		alert("삭제완료");
			    		
			    	}else
			    		alert("삭제실패");
					console.log(result);
			    }
		  });
	};
	document.querySelector("#codeMix").addEventListener("change", codeMix);
	
	function codeMix() {
		const categorys= frm.category.value;
		
		console.log(categorys);
	
		$.ajax({
		    url : "codeMix.do",
		    type : "post",
		    traditional : true,
		    data : { category: categorys  },
		    success : function(data){
		    	console.log(data);
		    	frm.productCd.value=data;
		    	frm.th_volume.value=data;
		    }
	  	});
	};
	document.querySelector("#listview").addEventListener("change", listview);
	
	function listview() {
		const listNums = listNum.value;
		console.log(listNums);
	}
	
	
	
	
	document.querySelector("#addItem").addEventListener("click", insert);
	  
	function insert() {
		const item={
			category: frm.category.value,
			productCd: frm.productCd.value,
			pname: frm.pname.value,
			volume: frm.volume.value,
			unit: frm.unit.value
			};
		
		$.ajax({
		    url : "productInsert.do",
		    type : "post",
		    traditional : true,
		    data : { items: JSON.stringify(item)
		    },
		     dataType: 'json',
		    success : function(result){
		    	if(result ==1){
		    		document.location.reload();
		    		alert("등록완료");
		    		
		    	}else
		    		alert("등록실패");
				console.log(result);
		    }
	  	});
	}
	
	
	
	$(document).ready(function() {
		 // 테이블의 Row 클릭시 값 가져오기
         let first = ""; 
         let last ="";
		$(document).on("dblclick", "#editable", function() {
        	let value=$(this).text();
   //     	alert(value);
        	let input="<input type='text' class='input-data' value='"+value+"' class='form-control' id='focuss' >";
        	$(this).html(input);
            $(this).removeClass("editable")
            $('#focuss').focus();
            first = value;
            console.log(first);
        });
		$("#list tr").click(function(){    

            const str = ""
            let tdArr = new Array(); // 배열 선언
            
            // 현재 클릭된 Row(<tr>)
            const tr = $(this);
            const td = tr.children();
            
            
            // 반복문을 이용해서 배열에 값을 담아 사용할 수 도 있다.
            td.each(function(i){
             tdArr.push(td.eq(i).text());
          });
		  
        $(document).on("blur", ".input-data", function() {
        	const value=$(this).val();
        	const td=$(this).parent("td");
            td.html(value);
            td.addClass("editable")
            });
        
        $(document).on("keypress", ".input-data", function(e) {
        	const key=e.which;
            if(key==13) {
            	const value=$(this).val();
            	const td=$(this).parent("td");
            	$(this).remove();
                td.html(value);
                td.addClass("editable");
                last = value;
            }
        });
        });
   });
</script>
</body>
</html>