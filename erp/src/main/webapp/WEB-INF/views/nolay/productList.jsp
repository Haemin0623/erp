<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
    
    
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
	#productList{
		margin-left: 80%
	}
		margin-left: 72%
	}
	
	table {
		width: 100%;
		border: black;
		position: absolute;
		    width: inherit;
	}
	tr th {
		background: #5b6996;
		color: white;
	}
	#table{
		 
		overflow: auto;
		height: 40vh;
		width: 120vh;
	}
	
	#list {
		width: 100%;
		border: 1px solid;
		
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
	.list {
 		background: silver;
	}
</style>


</head>
<body>
<div id="container">
	<h1 class="menuName">상품관리</h1>
	<div id="searchBox">
		<form id="searchBoxx">
				<span>
					상품코드 <input type="text" name="productCd" value="${product.productCd }">
				</span>
				<span>
					상품명 <input type="text" name="pname" value="${product.pname }">
				</span>
				<span>
					용량 <input type="text" name="volume" value="${product.volume }" >
				</span>
				<span>
					상품카테고리 <input type="text" name="category" value="${product.category }">
				</span>
				<span>
					등록일 <input type="date" name="adddate"> ~ <input type="date" name="adddate2">
				</span>
				<span>
				상태 <select name="del">
						<c:if test="${product.del == null }">
							<option value="null" selected="selected">모두보기
						</c:if>
						<c:if test="${product.del != null }">
							<option value="null">모두보기
						</c:if>
						<c:if test="${product.del == 'N' }">
							<option value="N" selected="selected">등록중
						</c:if>
						<c:if test="${product.del != 'N' }">
							<option value="N">등록중
						</c:if>
						<c:if test="${product.del == 'Y' }">
							<option value="Y" selected="selected">삭제완료
						</c:if>
						<c:if test="${product.del != 'Y' }">
							<option value="Y">삭제완료
						</c:if>
						
					</select>
				</span>
		</form>
		<button id="searchBtn" >검색</button>
	</div>
	

	<span id="CCD">
		<button id="show">상품등록 </button>
		<button type="button" onclick="deleteAction()">삭제</button>
		<button>엑셀 대량등록</button>
	</span>	
	<div id="productList">
	<form name="page">
		<span>
			<select id="listview">
			<c:if test="${rowPerPage ==10}">
				<option value="10" selected="selected">10개씩보기</option>
			</c:if>
			<c:if test="${rowPerPage !=10}">
				<option value="10">10개씩보기</option>
			</c:if>
			
			<c:if test="${rowPerPage ==50}">
				<option value="50" selected="selected">50개씩보기</option>
			</c:if>
			<c:if test="${rowPerPage !=50}">
				<option value="50">50개씩보기</option>
			</c:if>
			
			<c:if test="${rowPerPage ==100}">
				<option value="100" selected="selected">100개씩보기</option>
			</c:if>
			<c:if test="${rowPerPage !=100}">
				<option value="100">100개씩보기</option>
			</c:if>
			
			<c:if test="${rowPerPage ==300}">
				<option value="300" selected="selected">300개씩보기</option>
			</c:if>
			<c:if test="${rowPerPage !=300}">
				<option value="300">300개씩보기</option>
			</c:if>
			
			<c:if test="${rowPerPage ==500}">
				<option value="500" selected="selected">500개씩보기</option>
			</c:if>
			<c:if test="${rowPerPage !=500}">
				<option value="500">500개씩보기</option>
			</c:if>
			</select>
		</span>
	</form>
	</div>
	<div id="table">
	<form action="">
		<table id="list">
			<tr class="haeder">
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
			<tr class="itemRow">
				<td>
				<c:if test="${productList.del=='Y'}">
					<input type="checkbox" name="checkRow" value="${productList.productCd }" disabled="disabled" >
				</c:if>
				<c:if test="${productList.del!='Y'}">
					<input type="checkbox" name="checkRow" value="${productList.productCd }" >
				</c:if>
				</td>
				<td>${productList.productCd }</td>
				<td class="editable">${productList.pname}</td>
				<td class="editable">${productList.volume}</td>
				<td class="editable">${productList.unit}</td>
				<td>${productList.category}</td>
				<td>${productList.adddate}</td>
				<td>${productList.statusdate}</td>
				<td>${productList.del}</td>
			</tr>
			</c:forEach> 
		</table>
	</form>
	</div>
	<div align="center">
			<!-- 시작페이지가 pagePerBlock(10)보다 크면 앞에 보여줄 것이 있다 -->		
		<c:if test="${pb.startPage > pb.pagePerBlock}">
			<a href="productList.do?pageNum=1 ">
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
						<option value="">선택</option>
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
		  if(confirm("선택한 상품을 삭제하시겠습니까?")){
			  
		  }else return false;

		  $.ajax({
			    url : "productDelete.do",
			    type : "post",
			    traditional : true,
			    data : { checkRows : checkRow },
			    
			    success : function(result){
			    	if(result ==1){
			    		search();
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
		    		search();
		    		alert("등록완료");
		    		
		    	}else if(result== -1){
		    		alert("이미 등록된 상품입니다.");
		    	}else
		    	alert("등록실패");
		    }
	  	});
	}
	
	
	
	
        document.querySelector("#listview").addEventListener("change", listview);
    	
    	function listview() {
    		let target = document.getElementById("listview");
    	      page= target.options[target.selectedIndex].value;     // 옵션 value 값
    	      const keyword = {
    	  			productCd : searchBoxx.productCd.value,	
    	  			pname : searchBoxx.pname.value,	
    	  			volume : searchBoxx.volume.value,	
    	  			category : searchBoxx.category.value,	
    	  			adddate : searchBoxx.adddate.value,	
    	  			adddate2 : searchBoxx.adddate2.value,	
    	  			del : searchBoxx.del.value	
    	  		} 
    		$.ajax({ //포스트 방식으로 아래의 주소에 데이터 전송
   		     method: 'post', 
   		     url: 'productSearch.do', 
   		     traditional: true,
   		 	 data: {
		    	keyword: JSON.stringify(keyword),
		    	page : page
   		     },
   		     success: function (result) { //성공했을떄 호출할 콜백을 지정
   		    	$('#content').children().remove();
   				$('#content').html(result);
   			}
   	   	});
    }
    	
</script>
<script type="text/javascript">
	$(document).ready(function() {
		var initvalue = "";
	    $(document).on("dblclick", ".editable", function() { //editable 클래스를 더블클릭했을때 함수실행
	    	initvalue = $(this).text(); //원래 있던 값을 value로 해서 input에 텍스트로 보여줘
	    	console.log(initvalue);
	        var input="<input type='text' class='input-data' value='"+initvalue+"' class='form-control' id='focus'>";
	        $(this).removeClass("editable")
	        $(this).html(input);
	        $('#focus').focus();
	        
	        $(".input-data").keypress(function(e) { //위의 해당 input-data 클래스의 키눌렀을떄 함수 실행
	            var key=e.which;
	            if(key==13) { //13은 enter키를 의미.테이블이 click을 받아 active 상태가 됐을때 enter눌러주면 그 값을 가지고 td로 
	                var value=$(this).val();
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
			             
			             
			             // 반복문을 이용해서 배열에 값을 담아 사용할 수 도 있다.
			             tdd.each(function(i){
	    		             tdArr.push(tdd.eq(i).text());
			             });
			             
			             
			             // td.eq(index)를 통해 값을 가져올 수도 있다.
			             productCd = tdd.eq(1).text();
			             pname = tdd.eq(2).text();
			             volume = tdd.eq(3).text();
			             unit = tdd.eq(4).text();
			             category = tdd.eq(5).text();
		             
		                $.ajax({ //포스트 방식으로 아래의 주소에 데이터 전송
		    			     method: 'post', 
		    			     url: 'productUpdate.do', 
		    			     traditional: true,
		    			     data: { //서버로 데이터를 전송할때  키와 벨류로 전달. 
		    			    	productCd: productCd,
		    			    	pname: pname,
		    			    	volume: volume,
		    			    	unit: unit,
		    			    	category: category
		    			     },
		    			     success: function (result) { //성공했을떄 호출할 콜백을 지정
		    			    	 console.log(result);
		    			        if (result) {
		    			        	search();
		    			        } else {
		    			        }
		    				}
		    		   	});
		            });
	           	}
	        });
	    });
	
	    $(document).on("blur", ".input-data", function() { //그 칸에서 포커스out 되면 발생하는 함수
	        
	        var td=$(this).parent("td");
	        $(this).remove();
	        td.html(initvalue);
	        td.addClass("editable")
	       });
	    
	});
</script>
<script type="text/javascript">
	function search() {
				
		const keyword = {
			productCd : searchBoxx.productCd.value,	
			pname : searchBoxx.pname.value,	
			volume : searchBoxx.volume.value,	
			category : searchBoxx.category.value,	
			adddate : searchBoxx.adddate.value,	
			adddate2 : searchBoxx.adddate2.value,	
			del : searchBoxx.del.value	
		}
		let target = document.getElementById("listview");
	      page= target.options[target.selectedIndex].value;
		console.log(keyword);
		
		$.ajax({
		     method: 'post',
		     url: 'productSearch.do',
		     traditional: true,
		     data: {
		    	keyword: JSON.stringify(keyword),
		    	page : page
		     },
		     success: function (result) {
		    	 $('#content').children().remove();
				 $('#content').html(result);
			 }
	   });

	};

document.querySelector("#searchBtn").addEventListener("click", search);
</script>
</body>
</html>