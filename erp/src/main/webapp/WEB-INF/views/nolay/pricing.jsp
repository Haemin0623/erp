<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../layoutElement/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<style type="text/css">

	.pricingPage {
		margin-left: 300px;
	}
	.menuName {
/* 		align-content: center; */
	}

	.searchBox {
 		height: 150px;
		background: #5b6996;
		margin-top: 50px;
		color: white;
	}
	
	#searchList {
	margin-left: 20px;
	}
	
	.btn {
 	margin-top: 50px;
	}
	
	.listCount {
		float: right;
	}
	
	.listBox {
		height: 280;
		margin-top: 10px;
		overflow:auto;
		width: 100%;
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

	}
	
	.header td {
		background: #5b6996;
		color: white;
	}
	
	.list {
 		background: #e5ebff;
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
	
	
	/* 페이징 시작 */
	.paging-div{
		margin-top: 28px;
	}
	
	/* 페이징 부분 가운데 정렬 */
	.pagination-ul{
		justify-content: right;
    	margin-right: 100px;
		display: flex;
	}
	.pagination-ul>li{
		margin-right:5px;
	}
	/* 현재 눌려있는 페이지 버튼 */
	.active-btn{
		border: 1px solid #5055b1;
	    border-radius: 6px;
	    width: 35px;
	    height: 35px;
		display: flex;
	    justify-content: center;
	    align-items: center;
	}
	
	.active-btn>a{
		font-size:16px;
		color: #5055b1;
		text-decoration: none;
	    font-weight: 700;
	}
	
	/* 눌려있지 않은 페이지 버튼 */
	.non-active-btn{
		/* border: 1px solid #c8c8c8; */
	    border-radius: 6px;
	    width: 35px;
	    height: 35px;
	    display: flex;
	    justify-content: center;
	    align-items: center;
	}
	
	.non-active-btn>a{
		font-size:16px;
		color: #b1b1b1;
		text-decoration: none;
	}
	/* 한 row 이전으로 가는 <버튼 */
	.pre-btn{
		border-radius: 6px;
	    width: 35px;
	    height: 35px;
	    display: flex;
	    justify-content: center;
	    align-items: center;	
	}
	.pre-btn>a{
			font-size: 16px;
		color: #5055b1;
	    text-decoration: none;
	}
	
	/* 한 row 다음으로 가는 >버튼 */
	.next-btn{
		border-radius: 6px;
	    width: 35px;
	    height: 35px;
	    display: flex;
	    justify-content: center;
	    align-items: center;
	}
	
	.next-btn>a{
		font-size: 16px;
		color: #5055b1;
	    text-decoration: none;
	}
	/* 페이징 끝 */
</style>

<script type="text/javascript">

function changeContent(data) {
	var addr = data;

	var ajaxOption = {
		url : addr,
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




</head>
<body>
<div class="pricingPage">
	<h1 class="menuName">판매가 관리</h1>
	
	<!-- 검색 박스 -->
	<div class="searchBox">
		<form action="pricing.do?buyerCd=${buyerCd }&productCd=${productCd}&startPrice=${startPrice}&endPrice=${endPrice}&validDate=${validDate}&discountrate=${discountrate}" id="searchList">
			<p>고객코드<input type="text" name="buyerCd" class="keyword">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				상품코드<input type="text" name="productCd" class="keyword"></p><p>
			<p>판매가<input type="number" name="startPrice" class="keyword">&nbsp;&nbsp;&nbsp;&nbsp;~
			<input type="number" name="endPrice" class="keyword">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				유효기간<input type="date" name="validDate" class="keyword"></p><p>
				할인율<input type="number" name="discountrate" class="keyword">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<select name="currency" class="keyword">
<!-- 					<option>통화단위 선택</option> -->
					<option value="won">원(₩)</option>
					<option value="dollar">달러($)</option>
					<option value="yen">앤(¥)</option>
					<option value="yuan">위안(元)</option>
				</select>
			
				<input type="submit" value="검색" class="submitBtn">
			
		</form>
	</div>
	
	<div class="btn">
	<button id="show">추가 </button>
	<button type="button" onclick="deleteAction()">삭제</button>
	
	<form name="page" class="listCount">
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
	
	<!-- 리스트 박스 -->
	<div class="listBox">
		<table class="tableList">
			<tr class="header">
				<td><input type="checkbox" name="checkAll" id="th_checkAll"></td><td>번호</td><td>고객코드</td><td>상품코드</td><td>판매가</td>
				<td>계약시작일</td><td>계약종료일</td><td>할인율(%)</td><td>최종판매가</td><td>통화단위</td><td>등록일</td><td>상태변경일</td>
			</tr>
			<c:if test="${empty pricingList}">
				검색 결과가 없습니다
			</c:if>
			<c:if test="${not empty pricingList}">
				<c:forEach var="pricing" items="${pricingList}" varStatus="status">
					<tr class="list">
						<td><input type="checkbox" name="checkRow" 
								value="${pricing.buyerCd }&${pricing.productCd }&${pricing.startdate }&${pricing.enddate }"></td>
						<td>${status.count }</td>
						<td>${pricing.buyerCd }</td>
						<td>${pricing.productCd }</td>
						<td class="editable">${pricing.price }</td>
						<td class="editable">${pricing.startdate }</td>
						<td class="editable">${pricing.enddate }</td>
						<td class="editable">${pricing.discountrate }</td>
						<td>${pricing.finalPrice }</td>
						<td class="editable">${pricing.currency }</td>
						<td>${pricing.adddate }</td>
						<td>${pricing.statusdate }</td>
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
				
				<form action="" name="pricing">
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
						<option value="원(₩)">원(₩)</option>
						<option value="달러($)">달러($)</option>
						<option value="앤(¥)">앤(¥)</option>
						<option value="위안(元)">위안(元)</option>
					</select><p>
				</form>
				<button id="addItem">추가</button>
				<div id="addItemDiv">
				
					<table id="addItemTable">
						<tr>
							<th>고객코드</th>
							<th>상품코드</th>
							<th>판매가</th>
							<th>계약시작일</th>
							<th>계약종료일</th>
							<th>할인율</th>
							<th>통화단위</th>
							<th>삭제</th>
						</tr>
					</table>
					<br><br><br><br><br><br><br>
					<button id=pricingInsert>등록</button>
					
				</div>
				
				</div>
			</div>
		</div>
	</div>
	
	<!-- 페이징 -->
		<div class="paging-div">
 				<c:if test="${empty pricingList }">
				</c:if> 
				<c:if test="${not empty pricingList }">
					
					<ul class="pagination-ul">
						<c:if test="${pb.startPage > pb.pagePerBlock }">
							<li class="pre-btn">
								<a href="#" onclick="changeContent('pricing.do?pageNum=1')">
<!-- 									<span class="glyphicon glyphicon-chevron-left"></span> -->
								</a>
							</li>
							<li class="pre-btn">
								<a href="#" onclick="changeContent('pricing.do?pageNum=${pb.startPage-1 }')">
<!-- 									<span class="glyphicon glyphicon-chevron-left"></span> -->
								</a>
							</li>							
						</c:if>
						<c:forEach var="i" begin="${pb.startPage }" end="${pb.endPage }">
							<c:if test="${pb.currentPage == i }">
								<li class="active-btn">
									<a href="#" onclick="changeContent('pricing.do?pageNum=${i }')">${i }</a>
								</li>
							</c:if>
							<c:if test="${pb.currentPage != i }">
								<li class="non-active-btn">
									<a href="#" onclick="changeContent('pricing.do?pageNum=${i }')">${i }</a>
								</li>
							</c:if>
						</c:forEach>
						<c:if test="${pb.endPage < pb.totalPage }">
							<li class="next-btn">
								<a href="#" onclick="changeContent('pricing.do?pageNum=${pb.endPage }')">
<!-- 									<span class="glyphicon glyphicon-chevron-right"></span> -->
								</a>
							</li>
							<li class="next-btn">
								<a href="#" onclick="changeContent('pricing.do?pageNum=${pb.totalPage+1 }')">
<!-- 									<span class="glyphicon glyphicon-chevron-right"></span> -->
								</a>
							</li>
						</c:if>
					</ul>
					
				</c:if>
		</div>
		<!-- 페이징 끝 -->
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
	
	
	//콜뷰
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
	
	
	
	// 체크박스 모두선택
	function checkAll(){
	    if( $("#th_checkAll").is(':checked') ){
	      $("input[name=checkRow]").prop("checked", true);
	    }else{
	      $("input[name=checkRow]").prop("checked", false);
	    }
	}
	document.querySelector("#th_checkAll").addEventListener("click", checkAll);
	
	
	
	// 등록창에 판매가리스트 추가
	function changeTable() {
		const buyerCd = pricing.buyerCd.value;
		const productCd = pricing.productCd.value;
		const price = pricing.price.value;
		const startdate = pricing.startdate.value;
		const enddate = pricing.enddate.value;
		const discountrate = pricing.discountrate.value;
		const currency = pricing.currency.value;
		
		if (buyerCd == '' || productCd == '' || price == '' || 
				startdate == '' || enddate == '' || discountrate == '' 
				|| currency == ''){
			alert('값을 채워넣어주세요');
		} else {
			
			$('#addItemTable').append(
					"<tr>" +
						"<td>" + buyerCd + "</td>" +
						"<td>" + productCd + "</td>" +
						"<td>" + price + "</td>" +
						"<td>" + startdate + "</td>" +
						"<td>" + enddate + "</td>" +
						"<td>" + discountrate + "</td>" +
						"<td>" + currency + "</td>" +
						"<td><button onclick='deleteItem(this)'>삭제</button></td>" +
					"</tr>"
			);
			pricing.buyerCd.value = '';
			pricing.productCd.value = '';
			pricing.price.value = '';
			pricing.startdate.value = '';
			pricing.enddate.value = '';
			pricing.discountrate.value = '';
			pricing.currency.value = '';
			
		}
		
	}
	
	document.querySelector("#addItem").addEventListener("click", changeTable);
	
	//등록창 리스트에서 삭제
	function deleteItem(e) {
		e.parentNode.parentNode.parentNode.removeChild(e.parentNode.parentNode);
	}
	
	// 체크박스 선택시 삭제
	function deleteAction(){
		  var checkRow = new Array();
		  $( "input[name='checkRow']:checked" ).each (function (){
		    checkRow.push($(this).val());
		  });
		  
		  console.log(checkRow);
		  
		  if(checkRow == ''){
		    alert("삭제할 대상을 선택하세요.");
		    return false;
		  }
		  $.ajax({
			    url : "pricingDelete.do",
			    type : "post",
			    traditional : true,
			    data : { checkRows : checkRow },
			    
			    success : function(result){
			    	if(result ==1){
			    		callView('pricing.do');
			    		alert("삭제완료");
			    		
			    	}else
			    		alert("삭제실패");
					console.log(result);
			    }
		  });
	};
	
	
	//등록창 리스트 전체 등록
	function pricingInsert() {
		const table = document.querySelector('#addItemTable');
		const rows = table.getElementsByTagName("tr");
		const tableLength = table.rows.length-1;
		console.log(rows);
		
		const items = new Array(tableLength);
		
		for (let i = 0; i < tableLength; i++) {
			let cells = rows[i+1].getElementsByTagName("td");
			
			items[i] = { 
				buyerCd: cells[0].firstChild.data,
				productCd: cells[1].firstChild.data,
				price: cells[2].firstChild.data,
				startdate: cells[3].firstChild.data,
				enddate: cells[4].firstChild.data,
				discountrate: cells[5].firstChild.data,
				currency: cells[6].firstChild.data
			};
			console.log('성공');
			console.log(items[i]);
		};
		
		console.log(items);
		
		$.ajax({
		     method: 'post',
		     url: 'pricingInsert.do',
		     traditional: true,
		     data: {
		    	 items: JSON.stringify(items)
		     },
		     dataType: 'json',
		     success: function (result) {
		        if (result) {
					callView('pricing.do');
					alert("삭제 성공");
		        } else {
		        	alert("실패");
		        }
			}
	   });
	}
	
	document.querySelector("#pricingInsert").addEventListener("click", pricingInsert);
	
	
	
// 	테이블 더블클릭하여 수정
	$(document).ready(function() {
		let initValue=""; //초기에 있던 값을 전역변수로 선언(수정하다가 커서가 다른곳 클릭하면 원래값으로 돌아가게)
        $(document).on("dblclick", ".editable", function() { //editable 클래스를 더블클릭했을때 함수실행
        	initValue=$(this).text(); //원래 있던 값을 value로 해서 input에 텍스트로 보여줘
            var input="<input type='text' class='input-data' value='"+initValue+"' class='form-control' id='focus'>";
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
    	            $(".tableList tr").keypress(function(){    
    	
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
    		             buyerCd = tdd.eq(2).text();
    		             productCd = tdd.eq(3).text();
    		             price = tdd.eq(4).text();
    		             startdate = tdd.eq(5).text();
    		             enddate = tdd.eq(6).text();
    		             discountrate = tdd.eq(7).text();
    		             currency = tdd.eq(9).text();
    		             
		                $.ajax({ //포스트 방식으로 아래의 주소에 데이터 전송
		    			     method: 'post', 
		    			     url: 'pricingUpdate.do', 
		    			     traditional: true,
		    			     data: { //서버로 데이터를 전송할때  키와 벨류로 전달. BuyerController로 buyer객체에 담겨서 보내짐
		    			    	 buyerCd: buyerCd,
		    			    	 productCd: productCd,
		    			    	 price: price,
		    			    	 startdate: startdate,
		    			    	 enddate: enddate,
		    			    	 discountrate: discountrate,
		    			    	 currency: currency
		    			     },
		    			     success: function (result) { //성공했을떄 호출할 콜백을 지정
		    			    	 console.log(result);
		    			        if (result) {
		    			        	callView('pricing.do');
		    						alert("수정성공");
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
            
            var td=$(this).parent("td"); // 해당 td를 td에 저장
            $(this).remove();
            td.html(initValue);
            td.addClass("editable")
            });
   });
	
// 	리스트 보기 갯수변경
	 document.querySelector("#listview").addEventListener("change", listview);
 	
 	function listview() {
 		let target = document.getElementById("listview");
 	      page= target.options[target.selectedIndex].value;     // 옵션 value 값
 	      
 		$.ajax({ //포스트 방식으로 아래의 주소에 데이터 전송
		     method: 'post', 
		     url: 'pricing.do', 
		     traditional: true,
		     data: { //서버로 데이터를 전송할때  키와 벨류로 전달. BuyerController로 buyer객체에 담겨서 보내짐
		    	 page: page
		     },
		     success: function (result) { //성공했을떄 호출할 콜백을 지정
		    	$('#content').children().remove();
				$('#content').html(result);
				 console.log(page);
				{
					
				}
			}
	   	});
 	}
	
</script>

</html>