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
	
	.statusWindow {
		overflow: auto;
		height: 40vh;
		width: 120vh;	
	}
	
	#statusList {
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
	
	.sumo {
		color : black;
	}
	li.opt {
		color : black;
	}
	
	
	
	
</style>

</head>
<body>
<div id="container">	
	<h1>주문 관리</h1>
	<div id="searchBox">
		<form name="searchBoxx">		
			주문번호<input type="text" name="orderNo" value="${orderHead.orderNo }">
			고객코드
			<select name="buyerCd" class="sumoBuy sumo">
				<option value="All"></option>
				<c:forEach var="buyer" items="${buyerEx }">
					<option value="${buyer.buyerCd }">${buyer.buyerCd }(${buyer.bname })</option>
				</c:forEach>
			</select>
			신청인
			<select name="employeeCd" class="sumoEmp sumo">
				<option value="All"></option>
				<c:forEach var="employee" items="${employeeEx }">
					<option value="${employee.employeeCd }">${employee.employeeCd }(${employee.ename })</option>
				</c:forEach>
			</select>
			
			신청일<input type="date" name="orderFromDate" value="${orderHead.orderFromDate }">
			~<input type="date" name="orderToDate" value="${orderHead.orderToDate }"><p>
			상태
			<select name="status">
				<option value="null">모두</option>		
				<option value="승인대기" <c:if test="${orderHead.status == '승인대기' }">selected="selected"</c:if>>승인대기</option>
				<option value="승인요청" <c:if test="${orderHead.status == '승인요청' }">selected="selected"</c:if>>승인요청</option>
				<option value="승인" <c:if test="${orderHead.status == '승인' }">selected="selected"</c:if>>승인</option>
				<option value="반려" <c:if test="${orderHead.status == '반려' }">selected="selected"</c:if>>반려</option>
			</select>
			
			<p>
			상품코드
			<select name="productCd" class="sumoProd sumo">
				<option value="All"></option>
				<c:forEach var="product" items="${productEx }">
					<option value="${product.productCd }">${product.productCd }(${product.pname })</option>
				</c:forEach>
			</select>
			
			납품요청일<input type="date" name="requestFromDate" value="${orderHead.requestFromDate }">
			~<input type="date" name="requestToDate" value="${orderHead.requestToDate }">


			삭제 된 주문 보기
			<select name="del">
				<option value="N">삭제 안된것</option>
				<c:if test="${orderHead.del == 'Y'}">
					<option value="Y" selected="selected">삭제 된것</option>
				</c:if>
				<c:if test="${orderHead.del != 'Y'}">
					<option value="Y">삭제 된것</option>
				</c:if>
				<c:if test="${orderHead.del == 'All'}">
					<option value="All" selected="selected">모두</option>
				</c:if>
				<c:if test="${orderHead.del != 'All'}">
					<option value="All">모두</option>
				</c:if>
			</select>
			
		</form>
		<button id="searchBtn">검색</button>
	</div>
	<p>
	<p>
	
	<button id="show">추가 </button>
	<c:if test="${orderHead.del != 'Y'}">
		<button type="button" onclick="deleteAction()">삭제</button>
	</c:if>
	<c:if test="${orderHead.del == 'Y'}">
		<button type="button" onclick="restoreAction()">복원</button>
	</c:if>
	
	<div id="table">
		<table id="list">
			<tr>
				<th>
					<c:if test="${orderHead.del =='Y'}">
						<input type="checkbox" name="deletedCheckAll" id="th_deletedCheckAll">
					</c:if>
					<c:if test="${orderHead.del =='N' or orderHead.del == 'All' }">
						<input type="checkbox" name="checkAll" id="th_checkAll">
					</c:if>
				</th>
				<th>주문번호</th>
				<th>고객코드</th>
				<th>신청일</th>
				<th>신청인</th>
				<th>상태</th>
				<th>상태변경일</th>
				<th>버튼</th>
			</tr>
			<c:forEach var="head" items="${headList }">			
				<tr class="itemRow">
					<td>
						<c:if test="${head.del =='Y'}">
							<input type="checkbox" name="deletedRow" value="${head.orderNo }" >
						</c:if>
						<c:if test="${head.del =='N' and head.status == '승인대기'}">
							<input type="checkbox" name="checkRow" value="${head.orderNo }" >
						</c:if>
					</td>
					<td>${head.orderNo }<input type="hidden" value="${head.orderNo }"> </td>
					<td class="editable">${head.buyerCd }</td>
					<td class="editable">${head.orderdate }</td>
					<td class="editable">${head.employeeCd }</td>
					<td class="editable"><input type="hidden" value="${head.status }">${head.status }</td>
					<td><input type="hidden" value="${head.reason }">${head.statusdate }</td>
					<td>
						<c:if test="${head.status == '승인대기'}">
							<button onclick="approvalRequest('${head.orderNo }')">요청</button>
						</c:if>
						<c:if test="${head.status == '승인요청'}">
							<button onclick="approvalCancel('${head.orderNo }')">취소</button>
						</c:if>
						<c:if test="${head.status == '승인'}">
						</c:if>
						<c:if test="${head.status == '반려'}">
							<button onclick="approvalRequest('${head.orderNo }')">재요청</button>
						</c:if>
					
					</td>
				</tr>
			</c:forEach>
		</table>
	</div>
	
	<div class="statusWindow">
			<table id="statusList">
				<tr>
					<th>No.</th>
					<th>상품코드</th>
					<th>상품명</th>
					<th>주문수량</th>
					<th>납품요청일</th>
					<th>가격</th>
					<th>합계</th>
					<th>비고</th>
				</tr>
				<tbody id="statusTable"/>
				<tbody id="area"/>
			</table>
		</div>
	


	<!-- 등록 창 팝업 -->
	<div class="background">
		<div class="window">
			<div class="popup">
			
				<button id="close">팝업닫기</button>
				
				<form action="" name="frm">
					주문번호<input type="text" name="orderNo" readonly="readonly"><br>
					발주일<input type="date" id="orderdate" name="orderdate"><br>
					고객코드
					<select name="buyerCd" class="sumo" id="buyerCd">
						<option value=""></option>
						<c:forEach var="buyer" items="${buyerEx }">
							<option value="${buyer.buyerCd }">${buyer.buyerCd }(${buyer.bname })</option>
						</c:forEach>
					</select>
					<br>
					상품코드
					<select name="productCd" class="sumo" id="productCd">
						<option value=""></option>
						<c:forEach var="product" items="${productEx }">
							<option value="${product.productCd }">${product.productCd }(${product.pname })</option>
						</c:forEach>
					</select>
					<br>
					수량<input type="number" name="requestqty"><br>
					판매가<input type="number" name="price"><br>
					납품요청일<input type="date" name="requestdate"><br>
					비고<textarea rows="5" cols="40" name="remark"></textarea>
				</form>
				<button id="addItem">추가</button>
				<div id="addItemDiv">
				
					<table id="addItemTable">
						<tr>
							<th>상품코드</th>
							<th>수량</th>
							<th>판매가</th>
							<th>총액</th>
							<th>납품요청일</th>
							<th>비고</th>
							<th>삭제</th>
						</tr>
					</table>
				
					
					<button id="insertOrder">등록</button>
					
					 
				</div>
				
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
	
	function changeTable() {
		document.querySelector('#orderdate').setAttribute("disabled", "disabled");
		document.querySelector('#buyerCd').setAttribute("disabled", "disabled");
		
		const productCd = frm.productCd.value;
		const requestqty = frm.requestqty.value;
		const price = frm.price.value;
		const amount = requestqty * price;
		const requestdate = frm.requestdate.value;
		const remark = frm.remark.value;
		
		if (productCd == '' || requestqty == '' || price == '' || 
				amount == '' || requestdate == '' || remark == ''){
			alert('값을 채워넣어주세요');
		} else {
			
			$('#addItemTable').append(
					"<tr>" +
						"<td>" + productCd + "</td>" +
						"<td>" + requestqty + "</td>" +
						"<td>" + price + "</td>" +
						"<td>" + amount + "</td>" +
						"<td>" + requestdate + "</td>" +
						"<td>" + remark + "</td>" +
						"<td><button onclick='deleteItem(this)'>삭제</button></td>" +
					"</tr>"
			);
			frm.productCd.value = '';
			frm.requestqty.value = '';
			frm.price.value = '';
			frm.remark.value = '';
			
		}
		
	}
	
	document.querySelector("#addItem").addEventListener("click", changeTable);
	
	function deleteItem(e) {
		e.parentNode.parentNode.parentNode.removeChild(e.parentNode.parentNode);
		
	}
	
	
	function insertOrder() {
		const table = document.querySelector('#addItemTable');
		const rows = table.getElementsByTagName("tr");
		const tableLength = table.rows.length-1;
		console.log(rows);
		
		const head = {
			orderNo: frm.orderNo.value,
			buyerCd: frm.buyerCd.value,
			orderdate: frm.orderdate.value
		};
		
		const items = new Array(tableLength);
		
		
		
		for (let i = 0; i < tableLength; i++) {
			let cells = rows[i+1].getElementsByTagName("td");
			
			items[i] = { 
				orderNo: frm.orderNo.value,
				productCd: cells[0].firstChild.data,
				requestqty: cells[1].firstChild.data,
				price: cells[2].firstChild.data,
				amount: cells[3].firstChild.data,
				requestdate: cells[4].firstChild.data,
				remark: cells[5].firstChild.data
			};
			console.log('야호');
			console.log(items[i]);
		};
		
		console.log(items);
		
		$.ajax({
		     method: 'post',
		     url: 'orderInsert.do',
		     traditional: true,
		     data: {
		    	 head: JSON.stringify(head),
		    	 items: JSON.stringify(items)
		     },
		     dataType: 'json',
		     success: function (result) {
		        if (result) {
					callView('order.do');
		        } else {
		        	alert("실패");
		        }
			}
	   });
	}
	
	document.querySelector("#insertOrder").addEventListener("click", insertOrder);
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
			del : searchBoxx.del.value,
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




<!-- 헤드의 아이템들 불러오기 -->
<script type="text/javascript">
	$("#table tr").on( "click", function() {
		$(".itemRow").removeClass('clickColor');
	    $(this).addClass('clickColor');
	});
	
	
	$('.itemRow').on('click', function() {
		
		$('#statusTable').empty();
		$('#area').empty();
		
		let thisRow = $(this).closest('tr');
		let orderNo = thisRow.find('td:eq(1)').find('input').val();
		let status = thisRow.find('td:eq(5)').find('input').val();
		let reason = thisRow.find('td:eq(6)').find('input').val();
		
		$.ajax({
			method: 'post',
			url: 'orderItemList.do',
			data: {"orderNo":orderNo},
			
			success: function(data) {
				for(var i=0 in data) {
					var x = parseInt(i)+1;
					
					let dateFormat = new Date(data[i].requestdate);
					let year = dateFormat.getFullYear();
					let month = dateFormat.getMonth() + 1;  /* 월은 0부터 시작, +1 */
					let date = dateFormat.getDate(); 
					
					/* let reqDate = year+"-"+month+"-"+date; */
					let reqDate = year+"-"+(("00"+month.toString()).slice(-2))+"-"+(("00"+date.toString()).slice(-2));
					
					$('#statusTable').append(
						"<tr>" +
							"<td>" + x + "</td>" +
							"<td>" + data[i].productCd + "</td>" +
							"<td>" + data[i].pname + "</td>" +
							"<td>" + data[i].requestqty + "</td>" +
							"<td>" + reqDate + "</td>" +
							"<td>" + data[i].price + "</td>" +
							"<td>" + data[i].amount + "</td>" +
							"<td>" + data[i].remark + "</td>" +
						"</tr>"
					);					
				
				}
				if (status == "승인" || status == "반려" ) {
					if (reason != "") {
							
						$('#area').append(
							"<tr>" +
							"<td colspan='8'><textarea rows='5' cols='70' name='reason' id='reason' readonly style='background-color:silver;'></textarea></td>"+
							"</tr>"
						);
						$('#reason').val(reason);
					}
				} 
	
				
				
				
			}, error : function(error) {
					alert("error"+error);
					console.log("에러");
			}
		})
	});
</script>

<!-- 승인대기 -> 승인요청  -->
<script type="text/javascript">
	function approvalRequest(orderNo) {				
		$.ajax({
		     method: 'post',
		     url: 'approvalRequest.do',
		     traditional: true,
		     data: {
		    	 orderNo: orderNo
		     },
		     success: function (result) {
		    	 if(result){
			    	 search();
		    	 } else {
		    		 alert('실패');
		    	 }
			 }		     
	   });
	}
</script>

<!-- 승인요청 -> 승인대기  -->
<script type="text/javascript">
	function approvalCancel(orderNo) {
		$.ajax({
		     method: 'post',
		     url: 'approvalCancel.do',
		     traditional: true,
		     data: {
		    	 orderNo: orderNo
		     },
		     success: function (result) {
		    	 if(result){
			    	 search();
		    	 } else {
		    		 alert('실패');
		    	 }

		    	 
			 }		     
	   });
	}
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
 		             orderNo = tdd.eq(1).text();
 		             buyerCd = tdd.eq(2).text();
 		             orderdate = tdd.eq(3).text();
 		             employeeCd = tdd.eq(4).text();
 		             
 		             console.log(buyerCd);
 	             
               $.ajax({ //포스트 방식으로 아래의 주소에 데이터 전송
   			     method: 'post', 
   			     url: 'orderUpdate.do', 
   			     traditional: true,
   			     data: { //서버로 데이터를 전송할때  키와 벨류로 전달. BuyerController로 buyer객체에 담겨서 보내짐
   			    	orderNo: orderNo,
   			    	buyerCd: buyerCd,
   			    	orderdate: orderdate,
   			    	employeeCd: employeeCd
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

<!-- 주문번호 생성 -->
<script type="text/javascript">


	var insertorderdate = "";
	var insertbuyerCd = "";
	var insertorderNo = "";
	var insertproductCd = "";
	
	$('#orderdate').on("change", function() {
		insertorderdate = frm.orderdate.value;
		insertorderdate = insertorderdate.charAt(2) + insertorderdate.charAt(2) + 
						insertorderdate.charAt(5) + insertorderdate.charAt(6) + 
						insertorderdate.charAt(8) + insertorderdate.charAt(9);
		insertorderNo = insertorderdate + insertbuyerCd;
		frm.orderNo.value = insertorderNo;
		console.log(insertorderNo.length);
		
		if(insertorderNo.length == 12){
			console.log('조건');
			console.log(insertorderNo);
			const count = getOrderCount(insertorderNo);
			insertorderNo = insertorderNo + count;
			frm.orderNo.value = insertorderNo;
			
		}
	});
	
	$('#buyerCd').on("change", function() {
		insertbuyerCd = frm.buyerCd.value;
		insertorderNo = insertorderdate + insertbuyerCd
		frm.orderNo.value = insertorderNo;
		console.log(frm.orderNo.value.length);
		
		if(insertorderNo.length == 12){
			console.log('조건');
			console.log(insertorderNo);
			const count = getOrderCount(insertorderNo);
			insertorderNo = insertorderNo + count;
			frm.orderNo.value = insertorderNo;
		}
		
		insertproductCd = frm.productCd.value;
		
		console.log('되냐?' + insertbuyerCd + insertproductCd);
		if(insertproductCd != "" && insertbuyerCd != ""){
			frm.price.value = getPrice(insertbuyerCd, insertproductCd);
		}
	});
	
	$('#productCd').on("change", function() {
		insertproductCd = frm.productCd.value;
		
		console.log('되냐?' + insertbuyerCd + insertproductCd);
		if(insertproductCd != "" && insertbuyerCd != ""){
			frm.price.value = getPrice(insertbuyerCd, insertproductCd);
		}
	})
	
	function getOrderCount(orderNo) {
		let count = "";
		$.ajax({
		     method: 'post', 
		     url: 'getOrderCount.do', 
		     traditional: true,
		     async: false,
		     data: {
		    	orderNo: orderNo
		     },
		     success: function (result) {
		    	 count = result;
			}
	   	});
		return count;
	}
	
	function getPrice(buyerCd, productCd){
		let price = "";
		$.ajax({
		     method: 'post', 
		     url: 'getPrice.do', 
		     traditional: true,
		     async: false,
		     data: {
		    	 buyerCd: buyerCd,
		    	 productCd: productCd
		     },
		     success: function (result) {
		    	 price = result;
			}
	   	});
		return price;
	}
	
	
</script>

<!-- 전체 선택 / 삭제  -->
<c:if test="${orderHead.del =='N' or orderHead.del == 'All' }">
	<script type="text/javascript">
		function checkAll(){
		    if( $("#th_checkAll").is(':checked') ){
		      $("input[name=checkRow]").prop("checked", true);
		    }else{
		      $("input[name=checkRow]").prop("checked", false);
		    }
		}
		
		document.querySelector("#th_checkAll").addEventListener("click", checkAll);
	</script>
</c:if>
<script type="text/javascript">
	
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
			    url : "orderDelete.do",
			    type : "post",
			    traditional : true,
			    data : { checkRows : checkRow },
			    
			    success : function(result){
			    	if(result){
			    		alert("삭제완료");
			    		search();
			    		
			    	}else
			    		alert("삭제실패");
					console.log(result);
			    }
		  });
	};
	
</script>

<!-- 삭제 항목 복원  -->
<c:if test="${orderHead.del =='Y'}">
	<script type="text/javascript">
		function delCheckAll(){
		    if( $("#th_deletedCheckAll").is(':checked') ){
		      $("input[name=deletedRow]").prop("checked", true);
		    }else{
		      $("input[name=deletedRow]").prop("checked", false);
		    }
		}
	
		document.querySelector("#th_deletedCheckAll").addEventListener("click", delCheckAll);
	</script>
</c:if>
<script type="text/javascript">


function restoreAction(){
	  var checkRow = new Array();
	  $( "input[name='deletedRow']:checked" ).each (function (){
	    checkRow.push($(this).val());
	  });
	  
	  console.log(checkRow);
	  
	  if(checkRow == ''){
	    alert("복원할 대상을 선택하세요.");
	    return false;
	  }
	  $.ajax({
		    url : "orderRestore.do",
		    type : "post",
		    traditional : true,
		    data : { checkRows : checkRow },
		    
		    success : function(result){
		    	if(result ==1){
		    		alert("복원완료");
		    		search();
		    		
		    	}else
		    		alert("복원실패");
				console.log(result);
		    }
	  });
};
</script>

<script type="text/javascript">
$(document).ready(function() {
	$('.sumo').SumoSelect({
		search: true,
		searchText: '검색어 입력',
	});
	$('select.sumoBuy')[0].sumo.selectItem("${orderHead.buyerCd }");
	
	$('select.sumoEmp')[0].sumo.selectItem("${orderHead.employeeCd }");
	
	$('select.sumoProd')[0].sumo.selectItem("${orderHead.productCd }");
});

	
</script>

</html>