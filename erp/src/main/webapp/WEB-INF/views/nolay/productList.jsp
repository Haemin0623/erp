<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ include file="../layoutElement/taglib.jsp"%>
    
    
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- <script src="http://ajax.googleapis.com/ajax/libs/jquery/3.0.3/jquery.min.js"></script> -->
<!-- <script type="text/javascript"> -->
<!--  	var J300 =  $.noConflict(true);	 -->
<!-- </script> -->
</head>
<body>
<div id="container">
	<h1 class="menuName">상품관리</h1>
	<div id="searchBox">
		<div class="searchInBox">
			<form id="searchBoxx">
				<input type="hidden" name="sortProductCd" value="${product.sortProductCd }">
				<input type="hidden" name="sortPname" value="${product.sortPname }">
				<input type="hidden" name="sortVolume" value="${product.sortVolume }" >
				<input type="hidden" name="sortUnit" value="${product.sortUnit }">
				<input type="hidden" name="sortCategory" value="${product.sortCategory }">
				<input type="hidden" name="sortAddDate" value="${product.sortAddDate }">
				<input type="hidden" name="sortStatusDate" value="${product.sortStatusDate }">
				<input type="hidden" name="sortDel" value="${product.sortDel }">
				
				<div class="search-sub-div">
					<div class="search-item-div">
						<div class="search-item-text">상품코드</div>
						<select name="productCd" class="productCd sumo">
							<option value=""></option>
							<c:forEach var="item" items="${allList }">
								<option value="${item.productCd }">${item.productCd }</option>
							</c:forEach>
						</select>
					</div>
					<div class="search-item-div">
						<div class="search-item-text">상품명</div>
						<select name="pname" class="pname sumo">
							<option value=""></option>
							<c:forEach var="item" items="${allList }">
								<option value="${item.pname }">${item.pname }</option>
							</c:forEach>
						</select>
					</div>
					<div class="search-item-div">
						<div class="search-item-text">용량</div>
						<select name="volume" class="volume sumo">
							<option value=""></option>
							<c:forEach var="item" items="${allList }">
								<option value="${item.volume }">${item.volume }</option>
							</c:forEach>
						</select>
					</div>
					<div class="search-sub-div">
						<div class="search-item-div">
							<div class="search-item-text">삭제여부 </div>
								<select name="del" >
									<c:if test="${product.del == null }">
										<option value="null" selected="selected">모두
									</c:if>
									<c:if test="${product.del != null }">
										<option value="null">모두
									</c:if>
									<c:if test="${product.del == 'N' }">
										<option value="N" selected="selected">O
									</c:if>
									<c:if test="${product.del != 'N' }">
										<option value="N">O
									</c:if>
									<c:if test="${product.del == 'Y' }">
										<option value="Y" selected="selected">X
									</c:if>
									<c:if test="${product.del != 'Y' }">
										<option value="Y">X
									</c:if>
								</select>
							</div>
						</div>
					</div>
					<div class="search-sub-div">
						<div class="search-item-text">상품카테고리</div>
						<select name="category" class="category sumo">
							<option value=""></option>
								<option value="스낵">스낵</option>
								<option value="라면">라면</option>
								<option value="음료">음료</option>
						</select>
					<div class="search-item-div" >			
						<div class="search-item-text" >등록일</div>
							<input type="date" name="adddate" value="${product.adddate }"> ~ <input type="date" name="adddate2" value="${product.adddate2 }">
						</div>
				</div>
			</form>
			</div>
			<div class="search-btn">
				<button id="searchBtn">검색</button>
				<button id="initBtn">초기화</button>
			</div>
	</div>
	

	<span id="CCD">
		<button id="show">상품등록  </button>
		<button type="button" onclick="deleteAction()">삭제</button>
		<button id="excelBtn">Excel</button>
	</span>	
	<div id="productList">
		<form name="page" >
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
	<div class="table">
	<form action="">
		<table class="list">
			<tr class="haeder">
				<th class="fixed"><input type="checkbox" name="checkAll" id="th_checkAll" ></th>
				<th class="fixed" id="sortProductCd">상품코드</th>
				<th class="fixed" id="sortPname">상품명</th>
				<th class="fixed" id="sortVolume">용량</th>
				<th class="fixed" id="sortUnit">단위</th>
				<th class="fixed" id="sortCategory">상품 카테고리</th>
				<th class="fixed" id="sortAddDate">등록일</th>
				<th class="fixed" id="sortStatusDate">최종수정일</th>
				<th class="fixed" id="sortDel">삭제여부</th>
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
				<td >${productList.productCd }</td>
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
	
	<div id="pageBtn" >
		<form name="paging">
			<c:if test="${pb.currentPage != 1}">
				<div id="prev" class="paging-btn">◀</div>
			</c:if>
		 	<input type="number" name="currentPage" value="${pb.currentPage }" id="currentPage"> / ${pb.totalPage }
			<c:if test="${pb.currentPage != pb.totalPage}">
				<div id="next" class="paging-btn">▶</div>
			</c:if>
		</form>
	</div>
</div>
	<div class="background">
		<div class="window">
			<div class="popup">
				<form action="" name="frm">
					<table id="insert-form">
						<caption>상품 등록</caption>
							<tr>
								<td>카테고리<select name="category" id="codeMix" autofocus="autofocus">
									<option value="">선택</option>
									<option value="라면">라면</option>
									<option value="스낵">스낵</option>
									<option value="음료">음료</option>
								</select></td>
							
								<td>상품코드<input type="text" name="productCd" readonly="readonly"></td>
							</tr>
							<tr>
								<td>상품명<input type="text" name="pname" required="required"></td>
								<td>용량<input type="text" name="volume" required="required"></td>
							</tr>
							<tr>
								<td>단위<input type="text" name="unit" required="required"></td>
							</tr>
					</table>
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
   	 	 		del : searchBoxx.del.value,
	   	  		currentPage : paging.currentPage.value,
	   	  		
	   	  		sortProductCd : searchBoxx.sortProductCd.value,
				sortPname : searchBoxx.sortPname.value,
				sortVolume : searchBoxx.sortVolume.value,
				sortUnit : searchBoxx.sortUnit.value,
				sortCategory : searchBoxx.sortCategory.value,
				sortAddDate : searchBoxx.sortAddDate.value,
				sortStatusDate : searchBoxx.sortStatusDate.value,
				sortDel : searchBoxx.sortDel.value
   	  				
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
	
	// 	검색초기화
	document.querySelector("#initBtn").addEventListener("click",  function(){callView('productList.do')});
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
		            $(".list tr").keypress(function(){    
		
			            const str = ""
			            const tdArr = new Array(); // 배열 선언
			             
			             // 현재 클릭된 Row(<tr>)
			            const tr = $(this);
			            const tdd = tr.children();
			             
			             
			             // 반복문을 이용해서 배열에 값을 담아 사용할 수 도 있다.
			             tdd.each(function(i){
	    		             tdArr.push(tdd.eq(i).text());
			             });
			             console.log(tdArr);
			             
			             
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
		    			        if (result == -1) {
		    			        	alert("중복된 상품이 있습니다.")
		    			        } else {
		    			        	search();
		    			        	alert("수정완료")
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
			del : searchBoxx.del.value,
			currentPage : paging.currentPage.value,
			
			sortProductCd : searchBoxx.sortProductCd.value,
			sortPname : searchBoxx.sortPname.value,
			sortVolume : searchBoxx.sortVolume.value,
			sortUnit : searchBoxx.sortUnit.value,
			sortCategory : searchBoxx.sortCategory.value,
			sortAddDate : searchBoxx.sortAddDate.value,
			sortStatusDate : searchBoxx.sortStatusDate.value,
			sortDel : searchBoxx.sortDel.value
			
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
<script type="text/javascript">
$(document).ready(function() {
	$('.sumo').SumoSelect({
		search: true,
		searchText: '검색어 입력',
	});
	$('select.productCd')[0].sumo.selectItem("${product.productCd }");
	
	$('select.pname')[0].sumo.selectItem("${product.pname }");
	
	$('select.volume')[0].sumo.selectItem("${product.volume }");
	
	$('select.category')[0].sumo.selectItem("${product.category }");
	
});

</script>
<script type="text/javascript">

	function initSort() {
		searchBoxx.sortProductCd.value=0;
		searchBoxx.sortPname.value=0;
		searchBoxx.sortVolume.value=0;
		searchBoxx.sortUnit.value=0;
		searchBoxx.sortCategory.value=0;
		searchBoxx.sortAddDate.value=0;
		searchBoxx.sortStatusDate.value=0;
		searchBoxx.sortDel.value=0;
	}
	$('#sortProductCd').on('click', function(){
		if(searchBoxx.sortProductCd.value==0 || searchBoxx.sortProductCd.value == 2){
			initSort();
			searchBoxx.sortProductCd.value = 1;
		}else if (searchBoxx.sortProductCd.value == 1){
			initSort();
			searchBoxx.sortProductCd.value = 2;
		}
		search();
	});
	$('#sortPname').on('click', function(){
		if(searchBoxx.sortPname.value==0 || searchBoxx.sortPname.value == 2){
			initSort();
			searchBoxx.sortPname.value = 1;
		}else if (searchBoxx.sortPname.value == 1){
			initSort();
			searchBoxx.sortPname.value = 2;
		}
		search();
		
	});
	$('#sortVolume').on('click', function(){
		if(searchBoxx.sortVolume.value==0 || searchBoxx.sortVolume.value == 2){
			initSort();
			searchBoxx.sortVolume.value = 1;
		}else if (searchBoxx.sortVolume.value == 1){
			initSort();
			searchBoxx.sortVolume.value = 2;
		}
		search();
	});
	$('#sortUnit').on('click', function(){
		if(searchBoxx.sortUnit.value==0 || searchBoxx.sortUnit.value == 2){
			initSort();
			searchBoxx.sortUnit.value = 1;
		}else if (searchBoxx.sortUnit.value == 1){
			initSort();
			searchBoxx.sortUnit.value = 2;
		}
		search();
	});
	$('#sortCategory').on('click', function(){
		if(searchBoxx.sortCategory.value==0 || searchBoxx.sortCategory.value == 2){
			initSort();
			searchBoxx.sortCategory.value = 1;
		}else if (searchBoxx.sortCategory.value == 1){
			initSort();
			searchBoxx.sortCategory.value = 2;
		}
		search();
	});
	$('#sortAddDate').on('click', function(){
		if(searchBoxx.sortAddDate.value==0 || searchBoxx.sortAddDate.value == 2){
			initSort();
			searchBoxx.sortAddDate.value = 1;
		}else if (searchBoxx.sortAddDate.value == 1){
			initSort();
			searchBoxx.sortAddDate.value = 2;
		}
		search();
	});
	$('#sortStatusDate').on('click', function(){
		if(searchBoxx.sortStatusDate.value==0 || searchBoxx.sortStatusDate.value == 2){
			initSort();
			searchBoxx.sortStatusDate.value = 1;
		}else if (searchBoxx.sortStatusDate.value == 1){
			initSort();
			searchBoxx.sortStatusDate.value = 2;
		}
		search();
	});
	$('#sortDel').on('click', function(){
		if(searchBoxx.sortDel.value==0 || searchBoxx.sortDel.value == 2){
			initSort();
			searchBoxx.sortDel.value = 1;
		}else if (searchBoxx.sortDel.value == 1){
			initSort();
			searchBoxx.sortDel.value = 2;
		} 
		search();
	});
</script>
<script type="text/javascript">
	$('#prev').on('click', function() {
		paging.currentPage.value--;
		if (paging.currentPage.value < 1) {
			paging.currentPage.value = 1;
		}
		search();
	});
	$('#next').on('click', function() {
		paging.currentPage.value++;
		
		if (paging.currentPage.value > '${pb.totalPage }') {
			paging.currentPage.value = ${pb.totalPage };
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
</script>
<script type="text/javascript">
function excel() {
// 	var checkRow = new Array();
// 	  $( "input[name='checkRow']:checked" ).each (function (){
// 	    checkRow.push($(this).val()) ;
// 	  });
	  
// 	  console.log(checkRow);
	let checkRow = new Array();
	
	$( "input[name='checkRow']:checked" ).each (function (){
		 let thisRow = $(this).closest('tr');
		 
		  
		 const item = {
					productCd : thisRow.find('td:eq(0)').find('input').val()
				}
		 
		 checkRow.push(item);
	
	});
	
	  
	 console.log(checkRow);
	 
	 J300.ajax({
		  url : 'productExcelDown.do',
		  method : 'post',
		  traditional : true,
		  data : {
			  items : JSON.stringify(checkRow)
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


</body>
</html>