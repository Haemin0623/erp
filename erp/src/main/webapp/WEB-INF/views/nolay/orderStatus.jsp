<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../layoutElement/taglib.jsp"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<style type="text/css">

	.scrollwrap {position: relative; display: block; width: 100%; overflow-x: auto; overflow-y: scroll;  height: 600px;}
	.scrollcontent {width: 3000px;}

	.graph1{
	    position: relative;
	    
	    width: 400px;
/* 	    height: 500px; */
	    float: left;
	    padding: 40px;
	    
	    
	}
	#allGraph{
	    padding-top: 30px;
	    display: inline-block;
	    
	}

</style>



<script src="https://cdn.jsdelivr.net/npm/chart.js@3.7.1/dist/chart.min.js"></script>

<!-- <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.5.0/Chart.min.js"></script> -->
<!-- <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.5.0/Chart.js"></script> -->
</head>
<body>
<div id = "container">
	<h1>주문 현황</h1>

	<div id="searchBox">
		<div class="searchInBox">
			<form name="searchBoxx">	
				<!-- 정렬용 -->
				<input type="hidden" name="sortOrderNo" value="${orderItem.sortOrderNo }">
				<input type="hidden" name="sortBuyerCd" value="${orderItem.sortBuyerCd }">
				<input type="hidden" name="sortOrderDate" value="${orderItem.sortOrderDate }">
				<input type="hidden" name="sortEmployeeCd" value="${orderItem.sortEmployeeCd }">
				<input type="hidden" name="sortStatus" value="${orderItem.sortStatus }">
				<input type="hidden" name="sortStatusDate" value="${orderItem.sortStatusDate }">
				
				<div class="search-sub-div">
					<div class="search-item-div">
						<div class="search-item-text">주문번호</div>
						<input type="text" name="orderNo" value="${orderItem.orderNo }">
					</div>
					<div class="search-item-div">
						<div class="search-item-text">고객코드</div>
		 				<select name="buyerCd" class="sumoBuy sumo">
							<option value="All"></option>
							<c:forEach var="buyer" items="${buyerEx }">
								<option value="${buyer.buyerCd }">${buyer.buyerCd }(${buyer.bname })</option>
							</c:forEach>
						</select>
					</div>
					<div class="search-item-div">
						<div class="search-item-text">신청일</div>
							<input type="date" name="orderFromDate" value=${orderItem.orderFromDate }>
							-<input type="date" name="orderToDate" value=${orderItem.orderToDate }>
					</div>
					<div class="search-item-div">
						<div class="search-item-text">승인상태</div>
						<div class="boxx">
							<select name="status">
								<option value="null">모두</option>		
								<option value="승인대기" <c:if test="${orderItem.status == '승인대기' }">selected="selected"</c:if>>승인대기</option>
								<option value="승인요청" <c:if test="${orderItem.status == '승인요청' }">selected="selected"</c:if>>승인요청</option>
								<option value="승인" <c:if test="${orderItem.status == '승인' }">selected="selected"</c:if>>승인</option>
								<option value="반려" <c:if test="${orderItem.status == '반려' }">selected="selected"</c:if>>반려</option>
							</select>
						</div>
					</div>
				</div>
				<div class="search-sub-div">
					<div class="search-item-div">
						<div class="search-item-text">상품코드</div>
						<select name="productCd" class="sumoProd sumo">
							<option value="All"></option>
							<c:forEach var="product" items="${productEx }">
								<option value="${product.productCd }">${product.productCd }(${product.pname })</option>
							</c:forEach>
						</select>
					</div>
					
					<div class="search-item-div">
						<div class="search-item-text">영업담당자</div> 
						<select name="employeeCd" class="sumoEmp sumo">
							<option value="All"></option>
							<c:forEach var="employee" items="${employeeEx }">
								<option value="${employee.employeeCd }">${employee.employeeCd }(${employee.ename })</option>
							</c:forEach>
						</select>
					</div>
					<div class="search-item-div">
						<div class="search-item-text">납품요청일</div>
						<input type="date" name="requestFromDate" value="${orderItem.requestFromDate }">
						-<input type="date" name="requestToDate" value="${orderItem.requestToDate }">
					</div>
					<div class="search-item-div">
						<div class="search-item-text">국가코드</div>
							<select name="countryCd">
								<option value="All">모두</option>
								<c:forEach var="country" items="${countryEx }">
									<option value="${country.countryCd }" <c:if test="${orderItem.countryCd == country.countryCd }">selected="selected"</c:if>>${country.countryCd }(${country.cname })</option>
								</c:forEach>
						</select>
					</div>
				</div>
				
				<p>
			</form>
		</div>
		<button id="searchBtn">검색</button>
		<button id="initBtn">초기화</button>
	</div>	
	
<!-- 월 별 매출 합계 / 우선 처음에 보여지고 검색결과 나오면 숨겨지도록 -->
	<div id=allGraph>
		<div class="graph1">
			<canvas id="amountGraph"></canvas>
		</div>
		<div class="graph1">
			<canvas id="amountBySalespersonGraph"></canvas>
		</div>
		<div class="graph1">
			<canvas id="amountByProductGraph"></canvas>
			 <div id='legend-div' class="legend-div"></div>
		</div>
	</div>
<script>
$(document).ready(function(){
	
	setTimeout(function(){
		// graph1 - amountGraph 월 별 매출
		$.ajax({
			url: 'monthAmount.do',
			type : "POST",
			async : true,
			traditional: true,
			dataType : "json",
			cache : false,
	        success: function (data) {
	        	var labels = ['7월', '8월', '9월', '10월', '11월', '12월'];
	        	var datas = [];
	        	for(var i=0 in data) {
	        		datas[i] = data[i];
	        		//console.log(data[i]);
	        		//console.log(datas[i]);
	        	}
	        	new Chart(document.getElementById("amountGraph"), {
	        		type: 'line',
        		    data: {
        		      labels: labels,
        		      datasets: [
        		        {
        		          label: "월 별 매출",
        		          borderColor: 'rgba(75, 192, 192, 1)',
        	              backgroundColor: 'rgba(75, 192, 192, 0.2)',
        		          data: datas
        		        }
        		      ]
        		    },
        		    options: {
        		      legend: { display: false },
        		      subtitle: {
        		        display: true,
        		        text: '월 별 매출'
        		      }
	        		}
	        	})
			
	        }//success 닫기
	        
		}); //월 별 매출 ajax 닫기
		
		// graph2 - amountBySalespersonGraph 당월 영업사원별 매출
		$.ajax({
			
		    url: 'amountBySalesperson.do',
			type : "POST",
			async : true,
			traditional: true,
			dataType : "json",
			cache : false,
	        success: function (data) {
	        	var labels = [];
	        	//console.log(data.emp);
	        	for(var i=0 in data.emp) {
	        		labels[i] = data.emp[i].ename;
	        		//console.log(data.emp[i].ename);
	        	}
	        	//console.log(labels);
	        	
        		var datas = [];
        		for(var i=0 in data.amount) {
        			datas[i] = data.amount[i];
	        		//console.log(data.amount[i]);
	        	}
        		//console.log(datas);
        		
        		new Chart(document.getElementById("amountBySalespersonGraph"), {
        		    type: 'bar',
        		    data: {
        		      labels: labels,
        		      datasets: [
        		        {
        		          label: "12월 영업사원 별 매출",
        		          backgroundColor: [
                              'rgba(54, 162, 235, 0.5)',
                              'rgba(255, 206, 86, 0.5)',
                              'rgba(75, 192, 192, 0.5)',
                              'rgba(153, 102, 255, 0.5)',
                              'rgba(255, 159, 64, 0.5)'],
                          borderColor: [
                              'rgba(54, 162, 235, 1.5)',
                              'rgba(255, 206, 86, 1.5)',
                              'rgba(75, 192, 192, 1.5)',
                              'rgba(153, 102, 255, 1.5)',
                              'rgba(255, 159, 64, 1.5)'],
        		          data: datas
        		        }
        		      ]
        		    },
        		    options: {
        		      legend: { display: true },
        		      title: {
        		        display: true,
        		        text: '당월 영업사원별 매출'
        		      }
        		    }
        		});
	        }//success 닫기
		
		}); //당월 영업사원별 매출 닫기
		
		// graph3 - amountByProductGraph 당월 영업사원별 매출
		$.ajax({

		    url: 'amountByProduct.do',
			type : "POST",
			async : true,
			traditional: true,
			dataType : "json",
			cache : false,
	        success: function (data) {
	        	var labels = [];
	        	for(var i=0 in data.product) {
	        		labels[i] = data.product[i].pname;
	        	}
	        	
        		var datas = [];
        		for(var i=0 in data.amount) {
        			datas[i] = data.amount[i];
	        	}
        		
        		let pieChartData = {
        			    labels: labels,
        			    datasets: [{
        			        data: datas,
        			        backgroundColor: ['rgb(255, 99, 132)', 'rgb(255, 159, 64)', 'rgb(255, 205, 86)', 'rgb(75, 192, 192)', 'rgb(54, 162, 235)', 
        			        	'rgb(153, 102, 255)', 'rgba(54, 162, 235, 0.5)',
                                'rgba(255, 206, 86, 0.5)',
                                'rgba(75, 192, 192, 0.5)',
                                'rgba(153, 102, 255, 0.5)']
        			    }] 
        		};
        		
        		new Chart(document.getElementById("amountByProductGraph"), {
        		    type: 'pie',
        		    data: pieChartData,
        		    options: {
        		    	plugins: {
	        		    	title:{
	        		    		display: true,
	             	            text: '12월 상품 별 매출'
	        		    	 }	
             	        },
        		    	
        	            responsive: false,
        	            legend: {
        	                display: false
        	            },
        	            legendCallback: customLegend
        	        }
        		});
	        } //success 닫기
		}); // 당월 상품별 판매량 
		
		let customLegend = function (chart) {
		    let ul = document.createElement('ul');
		    let color = chart.data.datasets[0].backgroundColor;

		    chart.data.labels.forEach(function (label, index) {
		        ul.innerHTML += `<li><span style="background-color: ${color[index]}"></span>${label}</li>`;
		    });
		    return ul.outerHTML;
		};
		
	},100);
});	//function닫기
</script>

	<div id="button-div">
		<button id="excelBtn">Excel</button>
		
		<div id="page">
			<form name="itemLimit">
				<select name="rowPerPage" id="limit">
					<option value="20" <c:if test="${orderItem.rowPerPage == 20 }">selected="selected"</c:if> >
						20개씩보기
					</option>
					<option value="50" <c:if test="${orderItem.rowPerPage == 50 }">selected="selected"</c:if> >
						50개씩보기
					</option>
					<option value="100" <c:if test="${orderItem.rowPerPage == 100 }">selected="selected"</c:if> >
						100개씩보기
					</option>
					<option value="300" <c:if test="${orderItem.rowPerPage == 300 }">selected="selected"</c:if> >
						300개씩보기
					</option>
					<option value="500" <c:if test="${orderItem.rowPerPage == 500 }">selected="selected"</c:if> >
						500개씩보기
					</option>
				</select>
			</form>
		</div>
	</div>
		
	<div class="scrollwrap">
		<table class="scrollcontent">
			<tr>
				<th class="fixed"><input type="checkbox" name="checkAll" id="th_checkAll"></th>
				<th class="fixed" id="sortOrderDate">주문일</th>
				<th class="fixed" id="sortOrderNo">주문번호</th>
				<th class="fixed">상품코드</th>
				<th class="fixed">상품명</th>
				<th class="fixed">주문수량</th>
				<th class="fixed">판매가</th>
				<th class="fixed">금액 합계</th>
				<th class="fixed" id="sortEmployeeCd">영업담당자</th>
				<th class="fixed" id="sortStatus">상태</th>
				<th class="fixed" id="sortStatusDate">상태변경일</th>
				<th class="fixed">승인자</th>
				<th class="fixed">납품요청일</th>
				<th class="fixed" id="sortBuyerCd">고객코드</th>
				<th class="fixed">고객명</th>
				<th class="fixed">고객담당자</th>
				<th class="fixed">고객연락처</th>
				<th class="fixed">고객이메일</th>
				<th class="fixed">비고</th>
</tr>
		<c:forEach var="item" items="${orderStatusList}">
			<tr class="itemRow">
				<td><input type="checkbox" name="checkRow" value="${item.orderNo }"></td>
				<td>${item.orderdate }</td>
				<td><input type="hidden" value="${item.orderNo }">${item.orderNo }</td>
				<td><input type="hidden" value="${item.productCd }">${item.productCd }</td>
				<td>${item.pname }</td>
				<td>${item.unitedrequestqty }</td>
				<td>${item.price }</td>
				<td>${item.unitedAmount }</td>
				<td>${item.ename }</td>
				<td>${item.status }</td>
				<td>${item.hstatusdate }</td>
		 		<c:if test="${item.auth==null }">
		 			<td>예정</td>
		 		</c:if>
		 		<c:if test="${item.auth!=null }">
		 			<td>${item.auth }</td>
		 		</c:if>
				<td>${item.requestdate }</td>
				<td>${item.buyerCd }</td>
				<td>${item.bname }</td>
				<td>${item.manager }</td>
				<td>${item.tel }</td>
				<td>${item.email }</td>
				<td>${item.remark }</td>
			</tr>
		</c:forEach>
		</table>
	</div>
	<p class="scroll"></p>

<div id="pageBtn">
		<form name="paging">
			<c:if test="${orderItem.currentPage != 1}">
				<div id="prev" class="paging-btn">◀</div>
			</c:if>
		 	<input type="number" name="currentPage" value="${orderItem.currentPage }" id="currentPage"> / ${orderItem.totalPage }
			<c:if test="${orderItem.currentPage != orderItem.totalPage}">
				<div id="next" class="paging-btn">▶</div>
			</c:if>
		</form>
	</div>
</div>
</body>

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
	
	document.querySelector("#initBtn").addEventListener("click",  function(){callView('orderStatus.do')});
	
	
	function search() {
		
		
		const keyword = {
			orderNo : searchBoxx.orderNo.value,	
			buyerCd : searchBoxx.buyerCd.value,	
			productCd : searchBoxx.productCd.value,	
			employeeCd : searchBoxx.employeeCd.value,
			orderFromDate : searchBoxx.orderFromDate.value,	
			orderToDate : searchBoxx.orderToDate.value,	
			requestFromDate : searchBoxx.requestFromDate.value,
			requestToDate : searchBoxx.requestToDate.value,
			status : searchBoxx.status.value,
			countryCd : searchBoxx.countryCd.value,
			
			sortOrderNo : searchBoxx.sortOrderNo.value,
			sortBuyerCd : searchBoxx.sortBuyerCd.value,
			sortOrderDate : searchBoxx.sortOrderDate.value,
			sortEmployeeCd : searchBoxx.sortEmployeeCd.value,
			sortStatus : searchBoxx.sortStatus.value,
			sortStatusDate : searchBoxx.sortStatusDate.value,
			
			rowPerPage : itemLimit.rowPerPage.value,
			currentPage : paging.currentPage.value,
			
		}
		console.log(keyword);
		
		$.ajax({
		     method: 'post',
		     url: 'orderSearch2.do',
		     traditional: true,
		     data: {
		    	keyword: JSON.stringify(keyword)
		     },
		     success: function (result) {
		    	 $('#content').children().remove();
				 $('#content').html(result);
				 $('#allGraph').hide();
			 }
	   });
	
	}
	
	document.querySelector("#searchBtn").addEventListener("click", search);
	
	function checkAll(){
	    if( $("#th_checkAll").is(':checked') ){
	      $("input[name=checkRow]").prop("checked", true);
	    }else{
	      $("input[name=checkRow]").prop("checked", false);
	    }
	}
	
	document.querySelector("#th_checkAll").addEventListener("click", checkAll);

	
	function excel() {
		
		let checkRow = new Array();
		
		$( "input[name='checkRow']:checked" ).each (function (){
			 let thisRow = $(this).closest('tr');
			 
//			orderNo = thisRow.find('td:eq(2)').find('input').val();
//			productCD = thisRow.find('td:eq(3)').find('input').val();
			  
			 const item = {
						orderNo : thisRow.find('td:eq(2)').find('input').val(),	
						productCd : thisRow.find('td:eq(3)').find('input').val()
					}
			 

			 checkRow.push(item);
		
		});
		
		  
		 console.log(checkRow);
		 
		 J300.ajax({
			  url : 'excelDown.do',
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
                    a.attr("download", "orderStatus.xlsx");
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
<script type="text/javascript">
$(document).ready(function() {
	$('.sumo').SumoSelect({
		search: true,
		searchText: '검색어 입력',
	});
	$('select.sumoBuy')[0].sumo.selectItem("${orderItem.buyerCd }");
	
	$('select.sumoEmp')[0].sumo.selectItem("${orderItem.employeeCd }");
	
	$('select.sumoProd')[0].sumo.selectItem("${orderItem.productCd }");
	
});

</script>


<!-- 페이지 버튼 / 페이지 당 요소 갯수 -->
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
		
		if (paging.currentPage.value > '${orderItem.totalPage }') {
			paging.currentPage.value = ${orderItem.totalPage };
		}
		search();
	});
	
	$('#limit').on('change', function() {
		search();
	});
	$('#currentPage').keydown(function(key) {
		/* 입력받은게 13(enter)면 원래 예정된 form action 실행하지마 */
		if(key.keyCode == 13) {
			key.preventDefault();			
			
			if (paging.currentPage.value < 1) {
				paging.currentPage.value = 1;
			}
			
			if (paging.currentPage.value > '${orderItem.totalPage }') {
				paging.currentPage.value = ${orderItem.totalPage };
			}
			
			search();
		}
	});
</script>

</html>