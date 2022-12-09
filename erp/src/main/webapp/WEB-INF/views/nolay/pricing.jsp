<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../layoutElement/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>판매가</title>
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
	<div id="searchBox">
		<div class="searchInBox">
			<form name="searchBoxx">
			
			<!-- 정렬용 -->
				<input type="hidden" name="sortBuyerCd" value="${pricing.sortBuyerCd }">
				<input type="hidden" name="sortProductCd" value="${pricing.sortProductCd }">
				<input type="hidden" name="sortPrice" value="${pricing.sortPrice }">
				<input type="hidden" name="sortStartdate" value="${pricing.sortStartdate }">
				<input type="hidden" name="sortEnddate" value="${pricing.sortEnddate }">
				<input type="hidden" name="sortDiscountrate" value="${pricing.sortDiscountrate }">
				<input type="hidden" name="sortFinalPrice" value="${pricing.sortFinalPrice }">
				<input type="hidden" name="sortCurrency" value="${pricing.sortCurrency }">
				<input type="hidden" name="sortAdddate" value="${pricing.sortAdddate }">
				<input type="hidden" name="sortStatusdate" value="${pricing.sortStatusdate }">
			
				<div class="search-sub-div">
					<div class="search-item-div">
						<div class="search-item-text">고객코드</div>
							<input type="text" name="buyerCd" value="${pricing.buyerCd }" list="buyerList">
							<datalist id="buyerList">
								<c:forEach var="pricing" items="${buyerEx }">
								
								</c:forEach>
							</datalist>
					
					</div>
					<div class="search-item-div">
						<div class="search-item-text">상품코드</div>
							<select name="productCd" class="keyword sumo sumoProd">
								<option value="All"></option>
								<c:forEach var="pricing" items="${productList }">
									<option value="${pricing.productCd }">${pricing.productCd }(${pricing.pname })</option>
								</c:forEach>
							</select>
					</div>
					<div class="search-item-div">
						<div class="search-item-text">판매가</div>
							<input type="number" name="startPrice" value="${pricing.startPrice }" class="keyword price">
							~
							<input type="number" name="endPrice" value="${pricing.endPrice }" class="keyword price"><p>
					</div>
				</div>
				<div class="search-sub-div">
					<div class="search-item-div">
						<div class="search-item-text">기준일</div>
							<input type="date" name="validDate" value="${pricing.validDate }" class="keyword validDate">
					</div>
					<div class="search-item-div">
						<div class="search-item-text">할인율</div>
							<input type="number" name="discountrate" value="${pricing.discountrate }" class="keyword discountrate">
					</div>
					<div class="search-item-div">
						<div class="search-item-text">통화단위</div>
							<select name="currency" class="keyword">
								<option value="All" <c:if test="${pricing.currency == 'All'}">selected="selected"</c:if>>선택</option>
								<option value="원(₩)" <c:if test="${pricing.currency == '원(₩)'}">selected="selected"</c:if>>원(₩)</option>
								<option value="달러($)" <c:if test="${pricing.currency == '달러($)'}">selected="selected"</c:if>>달러($)</option>
								<option value="앤(¥)" <c:if test="${pricing.currency == '앤(¥)'}">selected="selected"</c:if>>앤(¥)</option>
								<option value="위안(元)" <c:if test="${pricing.currency == '위안(元)'}">selected="selected"</c:if>>위안(元)</option>
							</select>
					</div>
					<div class="search-item-div">
						<div class="search-item-text">활성상태</div>
							<select name="del">
								<option value="N">활성</option>
								<c:if test="${pricing.del == 'Y'}">
									<option value="Y" selected="selected">비활성</option>
								</c:if>
								<c:if test="${pricing.del != 'Y'}">
									<option value="Y">비활성</option>
								</c:if>
								<c:if test="${pricing.del == 'All'}">
									<option value="All" selected="selected">모두</option>
								</c:if>
								<c:if test="${pricing.del != 'All'}">
									<option value="All">모두</option>
								</c:if>
							</select>
					</div>
				</div>
			</form>
		</div>
			<div class="search-btn">
			<button id="searchBtn">검색</button>
			<button id="initBtn">초기화</button>
			</div>
	</div>
	
	
	<!-- 판매가 등록 -->
	<div id="button-div">
		<button id="show" class="btn">등록</button>
		<c:if test="${pricing.del != 'Y'}">
			<button type="button" onclick="deleteAction()" class="btn">삭제</button>
		</c:if>
		<c:if test="${pricing.del == 'Y'}">
			<button type="button" onclick="restoreAction()" class="btn">복원</button>
		</c:if>
		<button id="excelBtn"><img alt="" src="/erp/resources/image/Excel.png" id="excelImg"></button>
	
		<div id="page">
			<form name="itemLimit">
				<select name="rowPerPage" id="limit">
					<option value="10" <c:if test="${pricing.rowPerPage == 10 }">selected="selected"</c:if> >
						10개씩보기
					</option>
					<option value="50" <c:if test="${pricing.rowPerPage == 50 }">selected="selected"</c:if> >
						50개씩보기
					</option>
					<option value="100" <c:if test="${pricing.rowPerPage == 100 }">selected="selected"</c:if> >
						100개씩보기
					</option>
					<option value="300" <c:if test="${pricing.rowPerPage == 300 }">selected="selected"</c:if> >
						300개씩보기
					</option>
					<option value="500" <c:if test="${pricing.rowPerPage == 500 }">selected="selected"</c:if> >
						500개씩보기
					</option>
				</select>
			</form>
		</div>
	</div>
	
	<!-- 리스트 박스 -->
	<div class="table">
		<table class="list">
			<tr>
				<th class="fixed">
					<c:if test="${pricing.del == 'Y'}">
						<input type="checkbox" name="deletedCheckAll" id="th_deletedCheckAll">
					</c:if>
					<c:if test="${pricing.del == 'N' or pricing.del == 'All'}">
						<input type="checkbox" name="checkAll" id="th_checkAll">
					</c:if>
				</th>
				<th class="fixed">번호</th>
				<th class="fixed" id="sortBuyerCd">고객코드</th>
				<th class="fixed" id="sortProductCd">상품코드</th>
				<th class="fixed" id="sortPrice">판매가</th>
				<th class="fixed" id="sortStartdate">계약시작일</th>
				<th class="fixed" id="sortEnddate">계약종료일</th>
				<th class="fixed" id="sortDiscountrate">할인율(%)</th>
				<th class="fixed" id="sortFinalPrice">최종판매가</th>
				<th class="fixed" id="sortCurrency">통화단위</th>
				<th class="fixed" id="sortAdddate">등록일</th>
				<th class="fixed" id="sortStatusdate">최종수정일</th>
			</tr>
			<c:if test="${empty pricingList}">
				검색 결과가 없습니다
			</c:if>
			<c:if test="${not empty pricingList}">
				<c:forEach var="pricing" items="${pricingList}" varStatus="status">
					<tr class="itemRow">
						<td>
							<c:if test="${pricing.del == 'Y'}">
								<input type="checkbox" name="deletedRow" 
									value="${pricing.buyerCd }&${pricing.productCd }&${pricing.startdate }&${pricing.enddate }">
							</c:if>
							<c:if test="${pricing.del == 'N'}">
								<input type="checkbox" name="checkRow" 
									value="${pricing.buyerCd }&${pricing.productCd }&${pricing.startdate }&${pricing.enddate }">
							</c:if>
						</td>
						<td>${status.count }</td>
						<td><input type="hidden" value="${pricing.buyerCd }">${pricing.buyerCd }(${pricing.bname})</td>
						<td><input type="hidden" value="${pricing.productCd }">${pricing.productCd }(${pricing.pname })</td>
						<td class="editable"><fmt:formatNumber value="${pricing.price }" pattern="#,###.##"/></td>
						<td><input type="hidden" value="${pricing.startdate }">${pricing.startdate }</td>
						<td><input type="hidden" value="${pricing.enddate }">${pricing.enddate }</td>
						<td class="editable">${pricing.discountrate }</td>
						<td><fmt:formatNumber value="${pricing.finalPrice }" pattern="#,###.##"/></td>
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
			<div class="popup" align="center">
				<button id="close">X</button>
				<div class="writeForm">
				<form action="" name="pricing">
				<br><h1 class="addSub"> 판매가 등록 </h1><br>
				<table>
					<tr>
						<th>고객코드</th>
						<td>	
							<select name="buyerCd" class="keyword sumo sumoBuy">
								<option value="All"></option>
								<c:forEach var="pricing" items="${buyerList }">
									<option value="${pricing.buyerCd }">${pricing.buyerCd }(${pricing.bname })</option>
								</c:forEach>
							</select>
						</td>
						<th>상품코드</th>
						<td>
							<select name="productCd" class="keyword sumo sumoProd">
								<option value="All"></option>
								<c:forEach var="pricing" items="${productList }">
									<option value="${pricing.productCd }">${pricing.productCd }(${pricing.pname })</option>
								</c:forEach>
							</select>
						</td>
					</tr>
					<tr>
						<th>판매가</th>
						<td><input type="number" name="price"></td>
						<th>할인율</th>
						<td><input type="number" name="discountrate"></td>
					</tr>
					<tr>
						<th>계약시작일</th>
						<td><input type="date" name="startdate"></td>
						<th>계약종료일</th>
						<td><input type="date" name="enddate"></td>
					</tr>
					<tr>
						<th>통화단위</th>
						<td colspan="3">
							<select name="currency" class="sumo">
								<option value=""></option>
								<option value="원(₩)">원(₩)</option>
								<option value="달러($)">달러($)</option>
								<option value="앤(¥)">앤(¥)</option>
								<option value="위안(元)">위안(元)</option>
							</select>
						</td>
					</tr>
				</table>	
				</form>
				
				<div class="insert-btn">
					<button id="addItem" class="btn">추가</button>
				</div>
				<div id="addItemDiv" class="table" style="height: 200px;">
				
					<table id="addItemTable" class="list">
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
					
				</div>
					<div class="insert-btn">
						<button id="pricingInsert" class="btn">등록</button>
					</div>
				
				</div>
			</div>
		</div>
	</div>
	
	<!-- 페이징 -->
	<div id="pageBtn">
		<c:if test="${pricing.currentPage != 1}">
			<h5 id="prev">◀</h5>
		</c:if>
		&nbsp;&nbsp;
		<form name="paging">
		 	<input type="number" name="currentPage" value="${pricing.currentPage }" 
		 		id="currentPage"> / ${pricing.totalPage }
		</form>
		&nbsp;&nbsp;
		<c:if test="${pricing.currentPage != pricing.totalPage}">
			<h5 id="next">▶</h5>
		</c:if>
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
		}
		else {
			$.ajax({
			     method: 'post',
			     url: 'overlapCheck.do',
			     traditional: true,
			     data: {
			    	 buyerCd: buyerCd,
			    	 productCd: productCd,
			    	 startdate: startdate,
			    	 enddate: enddate
			     },
			     dataType: 'json',
			     success: function (result) {
			        if (result == 0) {
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
						pricing.price.value = '';
						pricing.startdate.value = '';
						pricing.enddate.value = '';
						pricing.discountrate.value = '';
			        } else {
			        	alert("계약일이 중복되었습니다");
			        }
				}
		   });
		}
	}
	document.querySelector("#addItem").addEventListener("click", changeTable);
	
	//등록창 리스트에서 삭제
	function deleteItem(e) {
		e.parentNode.parentNode.parentNode.removeChild(e.parentNode.parentNode);
	}
	
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
					alert("등록 성공");
		        } else {
		        	alert("데이터를 추가해 주세요");
		        }
			}
	   });
	}
	
	document.querySelector("#pricingInsert").addEventListener("click", pricingInsert);
	</script>
	
<c:if test="${pricing.del =='N' or pricing.del == 'All' }">
	<script type="text/javascript">
// 	체크박스 모두선택
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
	</script>
	
	
<!-- 	삭제 항목 복원 -->
	<c:if test="${pricing.del =='Y'}">
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
		  
		  if(checkRow == ''){
		    alert("복원할 대상을 선택하세요.");
		    return false;
		  }
		  $.ajax({
			    url : "pricingRestore.do",
			    type : "post",
			    traditional : true,
			    data : { checkRows : checkRow },
			    
			    success : function(result){
			    	if(result ==1){
			    		alert("복원완료");
			    		search();
			    		
			    	}else
			    		alert("복원실패");
			    }
		  });
	};
	</script>
	
	
	<script type="text/javascript">
	
	
	
// 	테이블 더블클릭하여 수정
	$(document).ready(function() {
		let initValue=""; //초기에 있던 값을 전역변수로 선언(수정하다가 커서가 다른곳 클릭하면 원래값으로 돌아가게)
        $(document).on("dblclick", ".editable", function() { //editable 클래스를 더블클릭했을때 함수실행
        	initValue=$(this).text(); //원래 있던 값을 value로 해서 input에 텍스트로 보여줘
            var input="<input type='text' class='input-data' value='"+initValue+"' class='form-control' id='focus' style='width: 45px;'>";
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
    	            $(".list tr").keypress(function(){    
    	
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
	
 	
//  	검색
 	function search() {
		
		const keyword = {
			buyerCd : searchBoxx.buyerCd.value,	
			productCd : searchBoxx.productCd.value,	
			startPrice : searchBoxx.startPrice.value,	
			endPrice : searchBoxx.endPrice.value,	
			validDate : searchBoxx.validDate.value,	
			discountrate : searchBoxx.discountrate.value,	
			currency : searchBoxx.currency.value,
			del : searchBoxx.del.value,
			
			sortBuyerCd : searchBoxx.sortBuyerCd.value,
			sortProductCd : searchBoxx.sortProductCd.value,
			sortPrice : searchBoxx.sortPrice.value,
			sortStartdate : searchBoxx.sortStartdate.value,
			sortEnddate : searchBoxx.sortEnddate.value,
			sortDiscountrate : searchBoxx.sortDiscountrate.value,
			sortFinalPrice : searchBoxx.sortFinalPrice.value,
			sortCurrency : searchBoxx.sortCurrency.value,
			sortAdddate : searchBoxx.sortAdddate.value,
			sortStatusdate : searchBoxx.sortStatusdate.value,
			
			rowPerPage : itemLimit.rowPerPage.value,
			currentPage : paging.currentPage.value
		}
		console.log(keyword);
		
		$.ajax({
		     method: 'post',
		     url: 'pricingSearch.do',
		     traditional: true,
		     data: {
		    	keyword: JSON.stringify(keyword)
		     },
		     success: function (result) {
		    	 $('#content').children().remove();
				 $('#content').html(result);
			 },
			 error: function () {
				 alert('실패');
			 }
	   });

	};

document.querySelector("#searchBtn").addEventListener("click", search);



//	검색초기화
document.querySelector("#initBtn").addEventListener("click",  function(){callView('pricing.do')});
	
	
// 	정렬
	function initSort() {
		searchBoxx.sortBuyerCd.value = 0;
		searchBoxx.sortProductCd.value = 0;
		searchBoxx.sortPrice.value = 0;
		searchBoxx.sortStartdate.value = 0;
		searchBoxx.sortEnddate.value = 0;
		searchBoxx.sortDiscountrate.value = 0;
		searchBoxx.sortFinalPrice.value = 0;
		searchBoxx.sortCurrency.value = 0;
		searchBoxx.sortAdddate.value = 0;
		searchBoxx.sortStatusdate.value = 0;
	}

	$('#sortBuyerCd').on('click', function() {
		if (searchBoxx.sortBuyerCd.value == 0 || searchBoxx.sortBuyerCd.value == 2) {
			initSort();
			searchBoxx.sortBuyerCd.value = 1;			
		} else if (searchBoxx.sortBuyerCd.value == 1) {
			initSort();
			searchBoxx.sortBuyerCd.value = 2;
		}		
		search();
	});
	$('#sortProductCd').on('click', function() {
		if (searchBoxx.sortProductCd.value == 0 || searchBoxx.sortProductCd.value == 2) {
			initSort();
			searchBoxx.sortProductCd.value = 1;			
		} else if (searchBoxx.sortProductCd.value == 1) {
			initSort();
			searchBoxx.sortProductCd.value = 2;
		}		
		search();
	});
	$('#sortPrice').on('click', function() {
		if (searchBoxx.sortPrice.value == 0 || searchBoxx.sortPrice.value == 2) {
			initSort();
			searchBoxx.sortPrice.value = 1;		
		} else if (searchBoxx.sortPrice.value == 1) {
			initSort();
			searchBoxx.sortPrice.value = 2;
		}		
		search();
	});
	$('#sortStartdate').on('click', function() {
		if (searchBoxx.sortStartdate.value == 0 || searchBoxx.sortStartdate.value == 2) {
			initSort();
			searchBoxx.sortStartdate.value = 1;			
		} else if (searchBoxx.sortStartdate.value == 1) {
			initSort();
			searchBoxx.sortStartdate.value = 2;
		}		
		search();
	});
	$('#sortEnddate').on('click', function() {
		if (searchBoxx.sortEnddate.value == 0 || searchBoxx.sortEnddate.value == 2) {
			initSort();
			searchBoxx.sortEnddate.value = 1;			
		} else if (searchBoxx.sortEnddate.value == 1) {
			initSort();
			searchBoxx.sortEnddate.value = 2;
		}		
		search();
	});
	$('#sortDiscountrate').on('click', function() {
		if (searchBoxx.sortDiscountrate.value == 0 || searchBoxx.sortDiscountrate.value == 2) {
			initSort();
			searchBoxx.sortDiscountrate.value = 1;			
		} else if (searchBoxx.sortDiscountrate.value == 1) {
			initSort();
			searchBoxx.sortDiscountrate.value = 2;
		}		
		search();
	});
	$('#sortFinalPrice').on('click', function() {
		if (searchBoxx.sortFinalPrice.value == 0 || searchBoxx.sortFinalPrice.value == 2) {
			initSort();
			searchBoxx.sortFinalPrice.value = 1;			
		} else if (searchBoxx.sortFinalPrice.value == 1) {
			initSort();
			searchBoxx.sortFinalPrice.value = 2;
		}		
		search();
	});
	$('#sortCurrency').on('click', function() {
		if (searchBoxx.sortCurrency.value == 0 || searchBoxx.sortCurrency.value == 2) {
			initSort();
			searchBoxx.sortCurrency.value = 1;			
		} else if (searchBoxx.sortCurrency.value == 1) {
			initSort();
			searchBoxx.sortCurrency.value = 2;
		}		
		search();
	});
	$('#sortAdddate').on('click', function() {
		if (searchBoxx.sortAdddate.value == 0 || searchBoxx.sortAdddate.value == 2) {
			initSort();
			searchBoxx.sortAdddate.value = 1;			
		} else if (searchBoxx.sortAdddate.value == 1) {
			initSort();
			searchBoxx.sortAdddate.value = 2;
		}		
		search();
	});
	$('#sortStatusdate').on('click', function() {
		if (searchBoxx.sortStatusdate.value == 0 || searchBoxx.sortStatusdate.value == 2) {
			initSort();
			searchBoxx.sortStatusdate.value = 1;			
		} else if (searchBoxx.sortStatusdate.value == 1) {
			initSort();
			searchBoxx.sortStatusdate.value = 2;
		}		
		search();
	});
	
// 		페이지 버튼, 페이지 당 요소 갯수
		$('#prev').on('click', function() {
			paging.currentPage.value--;
			if (paging.currentPage.value < 1) {
				paging.currentPage.value = 1;
			}
			search();
		});
		$('#next').on('click', function() {
			paging.currentPage.value++;
			
			if (paging.currentPage.value > '${pricing.totalPage }') {
				paging.currentPage.value = ${pricing.totalPage };
			}
			search();
		});
		
		$('#limit').on('change', function() {
			search();
		});
		
		$('#currentPage').keydown(function(key) {
			if(key.keyCode == 13) {
				key.preventDefault();
				search();
			}
		});
		
		
// 		엑셀 입출력
	function excel() {
		
		let checkRow = new Array();
		
		$( "input[name='checkRow']:checked" ).each (function (){
			 let thisRow = $(this).closest('tr');
			  
			 const pricing = {
				buyerCd : thisRow.find('td:eq(2)').find('input').val(),
				productCd : thisRow.find('td:eq(3)').find('input').val(),
				startdate : thisRow.find('td:eq(5)').find('input').val(),
				enddate : thisRow.find('td:eq(6)').find('input').val()
			 }

			 checkRow.push(pricing);
		
		});
		
		  
		 console.log(checkRow);
		 
		 J300.ajax({
			  url : 'pricingExcelDown.do',
			  method : 'post',
			  traditional : true,
			  data : {
				  pricings : JSON.stringify(checkRow)
			  },
			  xhr: function () {
                  var xhr = new XMLHttpRequest();
                  xhr.onreadystatechange = function () {
                      if (xhr.readyState == 2) {
                          if (xhr.status == 200) {
                              xhr.responseType = "blob";
                          } else {
                              xhr.responseType = "text";
                          }
                      }
                  };
                  return xhr;
			    },
			  success : function(data) {
				  console.log(data);
				//alert("엑셀다운완료?");
				//Convert the Byte Data to BLOB object.
                var blob = new Blob([data], { type: "application/octetstream" });

                //Check the Browser type and download the File.
                var isIE = false || !!document.documentMode;
                if (isIE) {
                    window.navigator.msSaveBlob(blob, fileName);
                } else {
                    var url = window.URL || window.webkitURL;
                    link = url.createObjectURL(blob);
                    var a = $("<a />");
                    a.attr("download", "test.xlsx");
                    a.attr("href", link);
                    $("body").append(a);
                    a[0].click();
                    $("body").remove(a);
                }
			}, error: function (xhr, status, error) {
				console.log("error");
			} 
		 });
		  
	}
	
	document.querySelector("#excelBtn").addEventListener("click", excel);
</script>

</html>