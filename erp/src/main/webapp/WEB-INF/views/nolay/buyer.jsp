<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../layoutElement/taglib.jsp"%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<script type="text/javascript">
	function dupChk() {
		if(!frm.buyerCd.value) {
			alert("입력한 후에 체크하시오");
			frm.buyerCd.focus(); 
			return false;
		}
		$.post('dupChk.do', "buyerCd="+frm.buyerCd.value, function(data) {
			$('#buyerCdChk-msg').html(data);  
		});
	}
	
	$('#dupChk').on('click', function(event){ //dupChk 아이디 클릭시 form 태그 기능 못하게 
		event.preventDefault();
		dupChk();
	});
	
	function dupChk2() {
		if(!frm.bname.value) {
			alert("입력한 후에 체크하시오");
			frm.bname.focus(); 
			return false;
		}
		$.post('dupChk2.do', "bname="+frm.bname.value, function(data) {
			$('#buyerCdChk-msg').html(data);  
		});
	}
	
	$('#dupChk2').on('click', function(event){ //dupChk 아이디 클릭시 form 태그 기능 못하게 
		event.preventDefault();
		dupChk2();
	});

</script>

</head>
<body>
	<div id="container">
	<!-- 검색박스 -->
		<h1 class="menuName"> 고객 관리</h1>
		<div id="searchBox">
			<div class="searchInBox">
				<form name ="searchBoxx">
				<input type="hidden" name="sortBuyerCd" value="${buyer.sortBuyerCd }">
				<input type="hidden" name="sortBname" value="${buyer.sortBname }">
				<input type="hidden" name="sortManager" value="${buyer.sortManager }">
				<input type="hidden" name="sortTel" value="${buyer.sortTel }">
				<input type="hidden" name="sortEmail" value="${buyer.sortEmail }">
				<input type="hidden" name="sortAddress" value="${buyer.sortAddress }">
				<input type="hidden" name="sortCountryCd" value="${buyer.sortCountryCd }">
				<input type="hidden" name="sortAdddate" value="${buyer.sortAdddate }">
				<input type="hidden" name="sortStatusDate" value="${buyer.sortStatusDate }">
				
				<div class="search-sub-div">
					<div class="search-item-div">
						<div class="search-item-text">고객코드</div>
						<input type="search" name="buyerCd" value="${buyer.buyerCd }" list="buyerList">
						<datalist id="buyerList">
							<c:forEach var="buyer" items="${buyerEx}">
								<option value="${buyer.buyerCd }">${buyer.bname }</option>
							</c:forEach>
						</datalist>
					</div>
					<div class="search-item-div">
						<div class="search-item-text">담당자</div> 
						<input type="search" name="manager" value="${buyer.manager }" list="managerList">
						<datalist id="managerList">
							<c:forEach var="buyer" items="${buyerEx}">
								<option value="${buyer.manager }"></option>
							</c:forEach>
						</datalist>
					</div>
					<div class="search-item-div">
						<div class="search-item-text">주소</div>
		<!-- 				<select name="address" class="address sumo long2"> -->
		<!-- 					<option value="All"></option> -->
		<%-- 					<c:forEach var="buyer" items="${buyerList}" > --%>
		<%-- 						<option class="long2">${buyer.address}</option> --%>
		<%-- 					</c:forEach> --%>
		<!-- 				</select> -->
						<input type="search" name="address" class="keyword long2" value="${buyer.address}"> 
					</div>
				</div>
				<div class="search-sub-div">
					<div class="search-item-div">
						<div class="search-item-text">국가코드</div>
						<input type="search" name="countryCd" value="${buyer.countryCd }" list="countryList">
						<datalist id="countryList">
							<c:forEach var="country" items="${countryEx}">
								<option value="${country.countryCd }">${country.cname }</option>
							</c:forEach>
						</datalist>
					</div>
					<div class="search-item-div">	
						<div class="search-item-text">전화번호</div>
						<input type="search" name="tel" value="${buyer.tel }" list="telList">
						<datalist id="telList">
							<c:forEach var="buyer" items="${buyerEx}">
								<option value="${buyer.tel }"></option>
							</c:forEach>
						</datalist>
					</div>
					<div class="search-item-div">
						<div class="search-item-text">이메일</div>
						<input type="search" name="email" value="${buyer.tel }" list="emailList">
						<datalist id="emailList">
							<c:forEach var="buyer" items="${buyerEx}">
								<option value="${buyer.email }"></option>
							</c:forEach>
						</datalist>
					</div>
					<div class="search-item-div">
						<div class="search-item-text">활성상태</div>
						<div class="boxx">
							<select name="del" class="search">
								<option value="N">활성</option>
								<option value="Y" <c:if test="${buyer.del == 'Y'}">selected="selected"</c:if> >비활성 </option>
								<option value="All" <c:if test="${buyer.del == 'All'}"> selected="selected" </c:if>>모두</option>
							</select>
						</div>
					</div>
				</div>
				
				</form>
			</div>	
			<div class="search-btn">
				<button id="searchBtn">검색</button>
				<button id="initBtn"> 초기화 </button>
			</div>
		</div>
	
	
		<div id="button-div">
			<button id="show" class="btn">등록</button>
			<c:if test="${buyer.del != 'Y'}">
				<button id="delBuyer" class="btn">삭제</button>
			</c:if>
			<c:if test="${buyer.del == 'Y'}">
				<button type="button" onclick="restoreAction()" class="btn">복원</button>
			</c:if>
			<button id="excelBtn"><img alt="" src="/erp/resources/image/Excel.png" id="excelImg"></button>
			
			<div id="page">
				<form name="itemLimit">
					<select name="rowPerPage" id="limit">
						<option value="20" <c:if test="${buyer.rowPerPage == 20 }">selected="selected"</c:if> >
							20개씩보기
						</option>
						<option value="50" <c:if test="${buyer.rowPerPage == 50 }">selected="selected"</c:if> >
							50개씩보기
						</option>
						<option value="100" <c:if test="${buyer.rowPerPage == 100 }">selected="selected"</c:if> >
							100개씩보기
						</option>
						<option value="300" <c:if test="${buyer.rowPerPage == 300 }">selected="selected"</c:if> >
							300개씩보기
						</option>
						<option value="500" <c:if test="${buyer.rowPerPage == 500 }">selected="selected"</c:if> >
							500개씩보기
						</option>
					</select>
				</form>
			</div>
		</div>
		
		<!-- 고객리스트 & 수정가능한 테이블 -->
		<div class="table" style="height: 600px;">
		<form action="" name="bt">
			<table class="list" >
				<tr>
					<th class="fixed">
						<c:if test="${buyer.del =='Y'}">
							<input type="checkbox" name="deletedCheckAll" id="th_deletedCheckAll">
						</c:if>
						<c:if test="${buyer.del =='N' or buyer.del == 'All' }">
							<input type="checkbox" name="checkAll" id="th_checkAll" class="red-check">
						</c:if>	
					</th>
					<th class="fixed">순번</th>
					<th class="fixed" id="sortBuyerCd">고객코드</th>
					<th class="fixed" id="sortBname">고객명</th>
					<th class="fixed" id="sortManager">담당자</th>
					<th class="fixed" id="sortTel">전화번호</th>
					<th class="fixed" id="sortEmail">이메일</th>
					<th class="fixed" id="sortAddress">주소</th>
					<th class="fixed" id="sortCountryCd">국가코드</th>
					<th class="fixed" id="sortAdddate">등록일</th>
					<th class="fixed" id="sortStatusDate">상태변경일</th>
				</tr>
				<c:forEach var="buyerItem" items="${buyerList }">
					<tr class="itemRow"
						<c:if test="${buyerItem.del =='Y'}">style="background-color: #c0c0c052;"</c:if>
					>
						<td>
							<c:if test="${buyerItem.del =='Y' and buyer.del == 'Y'}"> <!-- del값이 Y이면 보여주지않고, N이면 보여준다 -->
								<input type="checkbox" name="deletedRow" value="${buyerItem.buyerCd}">
							</c:if>
							<c:if test="${buyerItem.del =='N'}">
								<input type="checkbox" name="checkRow" value="${buyerItem.buyerCd}" class="red-check">
							</c:if>
						</td>
						<td>${buyerItem.rn }</td>
						<td>${buyerItem.buyerCd }</td>
						<td class="editable">${buyerItem.bname }</td>
						<td class="editable">${buyerItem.manager}</td>
						<td class="editable">${buyerItem.tel}</td>
						<td class="editable">${buyerItem.email}</td>
						<td class="editable">${buyerItem.address}</td>
						<td>${buyerItem.countryCd}</td>
						<td>${buyerItem.adddate}</td>
						<c:if test="${buyerItem.del == 'N'}">
							<c:if test="${buyerItem.statusdate == null}">
								<td>${buyerItem.statusdate }</td>
							</c:if>	
							<c:if test="${buyerItem.statusdate != null}">
								<td>${buyerItem.statusdate } (수정)</td>
							</c:if>	
						</c:if>
						<c:if test="${buyerItem.del == 'Y'}">
							<td>${buyerItem.statusdate } (삭제)</td>
						</c:if>
					</tr>
				</c:forEach>
			</table>
		</form>
		</div>
	
		<div id="pageBtn">
			<form name="paging">
				<c:if test="${buyer.currentPage != 1}">
					<div id="prev" class="paging-btn">◀</div>
				</c:if>
			 	<input type="number" name="currentPage" value="${buyer.currentPage }" id="currentPage"> / ${buyer.totalPage }
				<c:if test="${buyer.currentPage != buyer.totalPage}">
					<div id="next" class="paging-btn">▶</div>
				</c:if>
			</form>
		</div>
	
	</div>
	
	
	<!-- 	등록 창 팝업 -->
	<div class="background">
		<div class="window">
			<div class="popup" align="center">
				<button id="close">X</button>	
				<form action="" name="frm">
				<br><h1 class="addSub"> 고객등록 </h1><br>
				<table> 
					<tr> 
						<th>고객카테고리</th>
						<td>
							<select name="buyerCategory" id="autoCompleteCd" class="search" autofocus="autofocus">
								<option value=""></option>
								<option value="FOD">식품회사</option>
								<option value="MAT">마트</option>
								<option value="CVS">편의점</option>
								<option value="ETC">기타</option>
							</select>
						</td>
					<tr>
						<th>고객코드</th>
						<td><input type="text" disabled="disabled" name="buyerCd"><!-- <button id="dupChk">중복체크</button> --></td>
<!-- 						<div id="buyerCdChk-msg"></div> -->
					</tr>
					<tr>
						<th>고객명</th>
						<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							<input type="text" name="bname"><button id="dupChk2">중복체크</button>
						</td>
						<div id="buyerCdChk-msg"></div>
					</tr>
					<tr>
						<th>담당자</th>
						<td><input type="text" name="manager"></td>
					</tr>
					<tr>
						<th>전화번호</th>
						<td><input type="text" placeholder="010-****-****" name="tel"></td>
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
							<select name="countryCd" class="countryCd search" id="countryCd"> <!-- countryCd.countryCd을 값으로, countryCd를 키로 보냄 -->
								<option value=""></option>
								<c:forEach var="countryCd" items="${countryCdList}">
									<option value="${countryCd.countryCd}">${countryCd.cname}(${countryCd.countryCd})</option>
								</c:forEach>
							</select>
						</td>
					</tr>
				</table>

				</form>
					<button id="addBuyerBtn" class="btn">등록</button>
					<button id="reset" class="btn">초기화</button>
			</div>
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

// 	검색초기화
document.querySelector("#initBtn").addEventListener("click",  function(){callView('buyer.do')});

	//검색 기능
	function search() {
		
		const keyword = {
			buyerCd : searchBoxx.buyerCd.value,
			manager : searchBoxx.manager.value,	
			countryCd : searchBoxx.countryCd.value,	
			tel : searchBoxx.tel.value,	
			email : searchBoxx.email.value,	
			address : searchBoxx.address.value,
			del : searchBoxx.del.value,
			
			sortBuyerCd : searchBoxx.sortBuyerCd.value,
			sortBname : searchBoxx.sortBname.value,
			sortManager : searchBoxx.sortManager.value,
			sortTel : searchBoxx.sortTel.value,
			sortEmail : searchBoxx.sortEmail.value,
			sortAddress : searchBoxx.sortAddress.value,
			sortCountryCd : searchBoxx.sortCountryCd.value,
			sortAdddate : searchBoxx.sortAdddate.value,
			sortStatusDate : searchBoxx.sortStatusDate.value,
			
			rowPerPage : itemLimit.rowPerPage.value,
			
			currentPage : paging.currentPage.value
		}
		console.log(keyword);
		
		$.ajax({
		     method: 'post',
		     url: 'buyerSearch.do',
		     traditional: true,
		     data: { // JSON 방식으로 키워드의 값을 넘겨준다
		    	keyword: JSON.stringify(keyword)
		     },
		     success: function (result) { // 성공시 id 가 content인 곳에 자식내용들을 지우고, 결과값을 html로 보여줘
		    	 $('#content').children().remove();
				 $('#content').html(result);
			 }
	   });
	}
	
	document.querySelector("#searchBtn").addEventListener("click", search);

	// 등록 팝업 열기 닫기
	function show() {
		document.querySelector(".background").className = "background show";
	}
	//아이디 show를 클릭하면 show함수를 호출 
	document.querySelector("#show").addEventListener("click", show);
	
	
	function close() {
		document.querySelector(".background").className = "background";
		search();
// 		document.location.reload();
	}
	document.querySelector("#close").addEventListener("click", close);
	
	
	// 신규등록 팝업 열기
	function addBuyer() {
		const buyerCd = frm.buyerCd.value;
		const bname = frm.bname.value;
		const manager = frm.manager.value;
		const tel = frm.tel.value;
		const email = frm.email.value;
		const address = frm.address.value;
		const countryCd = frm.countryCd.value;
		
		if (buyerCd == '' || bname == '' || manager == '' || tel == '' || 
				email == '' || address == '' || countryCd == ''){
			
			alert('값을 채워넣어주세요');
			
			if (buyerCd == '') {
				$("input[name='buyerCd']").addClass('red');
				$("select[name='buyerCategory']").addClass('red');
			} else {
 			    $("input[name='buyerCd']").removeClass('red');
 			    $("select[name='buyerCategory']").removeClass('red');
			}
			if (bname == '') {
				$("input[name='bname']").addClass('red');
			} else {
 			    $("input[name='bname']").removeClass('red');		
			}
			if (manager == '') {
				$("input[name='manager']").addClass('red');
			} else {
 			    $("input[name='manager']").removeClass('red');		
			}
			if (tel == '') {
				$("input[name='tel']").addClass('red');
			} else {
 			    $("input[name='tel']").removeClass('red');		
			}
			if (email == '') {
				$("input[name='email']").addClass('red');
			} else {
 			    $("input[name='email']").removeClass('red');		
			}
			if (address == '') {
				$("input[name='address']").addClass('red');
			} else {
 			    $("input[name='address']").removeClass('red');		
			}
			if (countryCd == '') {
				$("select[name='countryCd']").addClass('red');
			} else {
 			    $("select[name='countryCd']").removeClass('red');		
			}
		} else {
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
			        if (result) {
			        	callView('buyer.do')
						alert("신규고객 등록완료");
			        } else {
			        	alert("등록실패");
			        }
				}
		   });			
		}
	}
	
	document.querySelector("#addBuyerBtn").addEventListener("click", addBuyer); 
	
	function autoCompleteCd() {
		const categorys = frm.buyerCategory.value;
		
		console.log(categorys);
		
		$.ajax({
			url : "autoCompleteCd.do",
			type : "post",
			traditional : true,
			data : {
				category: categorys
			},
			
			success : function (data) {
				console.log(data);
				frm.buyerCd.value = data;
			}
		});
	};
	
	document.querySelector("#autoCompleteCd").addEventListener("change",autoCompleteCd);
	
	
	//체크한 리스트만 엑셀 다운로드
	function excel() {
			
			let checkRow = new Array();
			
			$( "input[name='checkRow']:checked" ).each (function (){
				 let thisRow = $(this).closest('tr');
				 		  
				 const item = {
						 	buyerCd : thisRow.find('td:eq(0)').find('input').val(),
						}
	
				 checkRow.push(item);
			});
			
			 console.log(checkRow);
			 
			 J300.ajax({
				  url : 'buyerExcelDown.do',
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
	                    a.attr("download", "buyer.xlsx");
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
	
	
	// 	 테이블 수정가능하게 editable
	$(document).ready(function() {
		
	let initValue=""; //초기에 있던 값을 전역변수로 선언(수정하다가 커서가 다른곳 클릭하면 원래값으로 돌아가게). 새로불러오면서 다시 설정하므로 변수 설정위치도 중요
	
        $(document).on("dblclick", ".editable", function() { //editable 클래스를 더블클릭했을때 함수실행
        	initValue=$(this).text(); //원래 있던 값을 value로 해서 input에 텍스트로 보여줘
            var input="<input type='text' class='input-data' value='"+initValue+"' class='form-control' id='focus' style='width: 45px;'>";
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
    		             bname = tdd.eq(3).text();
    		             manager = tdd.eq(4).text();
    		             tel = tdd.eq(5).text();
    		             email = tdd.eq(6).text();
    		             address = tdd.eq(7).text();
    		             countryCd = tdd.eq(8).text();
    		             
    		             console.log(buyerCd);
    	             
		                $.ajax({ //포스트 방식으로 아래의 주소에 데이터 전송
		    			     method: 'post', 
		    			     url: 'buyerUpdate.do', 
		    			     traditional: true,
		    			     data: { //서버로 데이터를 전송할때  키와 벨류로 전달. BuyerController로 buyer객체에 담겨서 보내짐
		    			    	buyerCd: buyerCd,
		    					bname: bname,
		    					manager: manager,
		    					tel: tel,
		    					email: email,
		    					address: address,
		    					countryCd: countryCd
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
            
            var td=$(this).parent("td"); // 해당 td를 td에 저장
            $(this).remove();
            td.html(initValue);
            td.addClass("editable")
            });
   });
	
</script>

<!-- 스모셀렉트 -->
<script type="text/javascript">
$(document).ready(function() {
	$('.sumo').SumoSelect({
		search: true,
		searchText: '검색어 입력',
	});
	$('select.buyerCd')[0].sumo.selectItem("${buyer.buyerCd }");
	
	$('select.bname')[0].sumo.selectItem("${buyer.bname }");
	
	$('select.manager')[0].sumo.selectItem("${buyer.manager }");
	
	$('select.countryCd')[0].sumo.selectItem("${buyer.countryCd }");
	
	$('select.tel')[0].sumo.selectItem("${buyer.tel }");

	$('select.email')[0].sumo.selectItem("${buyer.email }");

	
});
</script>

<!-- 등록창 초기화 -->
<script type="text/javascript">
	$('#reset').on('click', function() {
		frm.buyerCd.value = '';
		frm.bname.value = '';
		frm.manager.value = '';
		frm.tel.value = '';
		frm.email.value = '';
		frm.address.value = '';
		$('select#countryCd')[0].sumo.unSelectAll();		
		
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
		
		if (paging.currentPage.value > ${buyer.totalPage }) {
			paging.currentPage.value = ${buyer.totalPage };
		}
		search();
	});
	
	$('#limit').on('change', function() {
		paging.currentPage.value=1;
		search();
	});
	
	$('#currentPage').keydown(function(key) {
		if(key.keyCode == 13) {
			key.preventDefault();			
			
			if (paging.currentPage.value < 1) {
				paging.currentPage.value = 1;
			}
			
			if (paging.currentPage.value > ${buyer.totalPage }) {
				paging.currentPage.value = ${buyer.totalPage };
			}
			
			search();
		}
	});
</script>

<!-- 정렬 -->
<script type="text/javascript">
	function initSort() {
		searchBoxx.sortBuyerCd.value = 0;
		searchBoxx.sortBname.value = 0;
		searchBoxx.sortManager.value = 0;
		searchBoxx.sortTel.value = 0;
		searchBoxx.sortEmail.value = 0;
		searchBoxx.sortAddress.value = 0;
		searchBoxx.sortCountryCd.value = 0;
		searchBoxx.sortAdddate.value = 0;
		searchBoxx.sortStatusDate.value = 0;
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
	$('#sortBname').on('click', function() {
		if (searchBoxx.sortBname.value == 0 || searchBoxx.sortBname.value == 2) {
			initSort();
			searchBoxx.sortBname.value = 1;			
		} else if (searchBoxx.sortBname.value == 1) {
			initSort();
			searchBoxx.sortBname.value = 2;
		}		
		search();
	});
	$('#sortManager').on('click', function() {
		if (searchBoxx.sortManager.value == 0 || searchBoxx.sortManager.value == 2) {
			initSort();
			searchBoxx.sortManager.value = 1;		
		} else if (searchBoxx.sortManager.value == 1) {
			initSort();
			searchBoxx.sortManager.value = 2;
		}		
		search();
	});
	$('#sortTel').on('click', function() {
		if (searchBoxx.sortTel.value == 0 || searchBoxx.sortTel.value == 2) {
			initSort();
			searchBoxx.sortTel.value = 1;			
		} else if (searchBoxx.sortTel.value == 1) {
			initSort();
			searchBoxx.sortTel.value = 2;
		}		
		search();
	});
	$('#sortEmail').on('click', function() {
		if (searchBoxx.sortEmail.value == 0 || searchBoxx.sortEmail.value == 2) {
			initSort();
			searchBoxx.sortEmail.value = 1;			
		} else if (searchBoxx.sortEmail.value == 1) {
			initSort();
			searchBoxx.sortEmail.value = 2;
		}		
		search();
	});
	$('#sortAddress').on('click', function() {
		if (searchBoxx.sortAddress.value == 0 || searchBoxx.sortAddress.value == 2) {
			initSort();
			searchBoxx.sortAddress.value = 1;			
		} else if (searchBoxx.sortAddress.value == 1) {
			initSort();
			searchBoxx.sortAddress.value = 2;
		}		
		search();
	});
	$('#sortCountryCd').on('click', function() {
		if (searchBoxx.sortCountryCd.value == 0 || searchBoxx.sortCountryCd.value == 2) {
			initSort();
			searchBoxx.sortCountryCd.value = 1;			
		} else if (searchBoxx.sortCountryCd.value == 1) {
			initSort();
			searchBoxx.sortCountryCd.value = 2;
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
	$('#sortStatusDate').on('click', function() {
		if (searchBoxx.sortStatusDate.value == 0 || searchBoxx.sortStatusDate.value == 2) {
			initSort();
			searchBoxx.sortStatusDate.value = 1;			
		} else if (searchBoxx.sortStatusDate.value == 1) {
			initSort();
			searchBoxx.sortStatusDate.value = 2;
		}		
		search();
	});
</script>

<!-- 전체 선택 / 삭제  -->
<c:if test="${buyer.del =='N' or buyer.del == 'All' }">
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
	
function delBuyer() {
	var cdArr = new Array(); //del 체크가 여러개일수도 있기에 배열로 받음
	$("input[name='checkRow']:checked").each(function() { //input태그의 이름이 del인 것이 check되면 아래 함수 실행
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
				alert("삭제완료");
				search();
	        } else {
	        	alert("삭제실패");
	        	console.log(result);
	        }
		},
		 error: function(a) {
			 console.log(a);

		 }
   });
};

document.querySelector("#delBuyer").addEventListener("click", delBuyer);
	
</script>

<!-- 삭제 항목 복원  -->
<c:if test="${buyer.del =='Y'}">
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
		    url : "buyerRestore.do",
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

</html>

