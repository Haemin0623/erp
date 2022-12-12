<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../layoutElement/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

</head>
<body>
<div id="container">
	<h1 class="menuName">직원 관리</h1>
	
	<div id="searchBox">
		<div class="searchInBox">
			<form name="searchBoxx">
				
				<input type="hidden" name="sortEmployeeCd" value="${employee.sortEmployeeCd }">
				<input type="hidden" name="sortEname" value="${employee.sortEname }">
				<input type="hidden" name="sortJob" value="${employee.sortJob }">
				<input type="hidden" name="sortDepartment" value="${employee.sortDepartment }">
				<input type="hidden" name="sortAdddate" value="${employee.sortAdddate }">
				<input type="hidden" name="sortAuthority" value="${employee.sortAuthority }">
				
			
				<div class="search-sub-div">
					<div class="search-item-div">
						<div class="search-item-text">직원코드</div>
						<input type="search" name="employeeCd" value="${employee.employeeCd }">
					</div>
					<div class="search-item-div">
						<div class="search-item-text">직원명</div>
						<input type="search" name="ename" value="${employee.ename }">
					</div>
					<div class="search-item-div">
						<div class="search-item-text">등록일</div>
						<input type="date" name="addFromDate" value=${employee.addFromDate }>
						~<input type="date" name="addToDate" value=${employee.addToDate }>
					</div>
				</div>
				<div class="search-sub-div">
					<div class="search-item-div">
						<div class="search-item-text">직책</div>
						<input type="search" name="job" value="${employee.job }">
					</div>
					<div class="search-item-div">
						<div class="search-item-text">부서</div>
						<input type="search" name="department" value="${employee.department }">
					</div>
					<div class="search-item-div">
						<div class="search-item-text">승인권한</div>
						<select name="authority" class="search">
							<option value="null">모두</option>			
							<option value="Y">있음</option>			
							<option value="N">없음</option>
						</select>
					</div>
					<div class="search-item-div">
						<div class="search-item-text">활성상태</div>
						<select name="del" class="search">
							<option value="N">활성</option>
							<option value="Y" <c:if test="${employee.del == 'Y'}">selected="selected"</c:if> >비활성 </option>
							<option value="All" <c:if test="${employee.del == 'All'}"> selected="selected" </c:if>>모두</option>
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
	
	<div id="button-div">
		<button id="show" class="btn">등록</button>
		<c:if test="${employee.del != 'Y'}">
			<button type="button" onclick="deleteAction()" class="btn">삭제</button>
		</c:if>
		<c:if test="${employee.del == 'Y'}">
			<button type="button" onclick="restoreAction()" class="btn">복원</button>
		</c:if>
		<button id="excelBtn"><img alt="" src="/erp/resources/image/Excel.png" id="excelImg"></button>
		
		<div id="page">
			<form name="itemLimit">
				<select name="rowPerPage" id="limit">
					<option value="20" <c:if test="${employee.rowPerPage == 20 }">selected="selected"</c:if> >
						20개씩보기
					</option>
					<option value="50" <c:if test="${employee.rowPerPage == 50 }">selected="selected"</c:if> >
						50개씩보기
					</option>
					<option value="100" <c:if test="${employee.rowPerPage == 100 }">selected="selected"</c:if> >
						100개씩보기
					</option>
					<option value="300" <c:if test="${employee.rowPerPage == 300 }">selected="selected"</c:if> >
						300개씩보기
					</option>
					<option value="500" <c:if test="${employee.rowPerPage == 500 }">selected="selected"</c:if> >
						500개씩보기
					</option>
				</select>
			</form>
		</div>
	</div>
	
	<div class="table" style="height: 600px;">
		<table class="list">
			<tr>
				<th class="fixed">
					<c:if test="${employee.del =='Y'}">
						<input type="checkbox" name="deletedCheckAll" id="th_deletedCheckAll">
					</c:if>
					<c:if test="${employee.del =='N' or employee.del == 'All' }">
						<input type="checkbox" name="checkAll" id="th_checkAll" class="red-check">
					</c:if>
				</th>
				<th class="fixed">순번</th>
				<th class="fixed" id="sortEmployeeCd">직원코드</th>
				<th class="fixed" id="sortEname">직원명</th>
				<th class="fixed" id="sortJob">직책</th>
				<th class="fixed" id="sortDepartment">부서</th>
				<th class="fixed" id="sortAdddate">등록일</th>
				<th class="fixed" id="sortAuthority">승인권한</th>
				<th class="fixed">상태변경일</th>
			</tr>
			<c:forEach var="emp" items="${empList }">			
				<tr class="itemRow"
					<c:if test="${emp.del =='Y'}">style="background-color: #c0c0c052;"</c:if>
				>
					<td>
						<c:if test="${emp.del =='Y'}">
							<input type="checkbox" name="deletedRow" value="${emp.employeeCd }" class="excel">
						</c:if>
						<c:if test="${emp.del =='N'}">
							<input type="checkbox" name="checkRow" value="${emp.employeeCd }" class="red-check excel">
						</c:if>
					</td>
					<td>${emp.rn }</td>
					<td>${emp.employeeCd }</td>
					<td class="editable">${emp.ename }</td>
					<td class="editable">${emp.job }</td>
					<td class="editable">${emp.department }</td>
					<td>${emp.adddate }</td>
					<td class="editable">${emp.authority }</td>
					<c:if test="${emp.del == 'N'}">
							<c:if test="${emp.statusdate == null}">
								<td>${emp.statusdate }</td>
							</c:if>	
							<c:if test="${emp.statusdate != null}">
								<td>${emp.statusdate } (수정)</td>
							</c:if>	
						</c:if>
						<c:if test="${emp.del == 'Y'}">
							<td>${emp.statusdate } (삭제)</td>
						</c:if>
				</tr>
			</c:forEach>
		</table>
	</div>
	
	<div id="pageBtn">
		<form name="paging">
			<c:if test="${employee.currentPage != 1}">
				<div id="prev" class="paging-btn">◀</div>
			</c:if>
		 	<input type="number" name="currentPage" value="${employee.currentPage }" id="currentPage"> / ${employee.totalPage }
			<c:if test="${employee.currentPage != employee.totalPage}">
				<div id="next" class="paging-btn">▶</div>
			</c:if>
		</form>
	</div>

	<!-- 등록 창 팝업 -->
	<div class="background">
		<div class="window">
			<div class="popup" align="center">
				<button id="close">X</button>
				<form action="" name="frm">
				<br><h1 class="addSub"> 직원등록 </h1><br>
					<table id="insert-form">
						<tr>
							<th>부서</th>
							<td>
								<select name="department" id="department"  class="search">
									<option value=""></option>
									<option value="영업">영업</option>
									<option value="관리">관리									
								</select>
							</td>
						</tr>
						<tr>
							<th>직원코드</th>
							<td><input type="text" name="employeeCd" class="readonly" readonly="readonly"></td>
						</tr>
						<tr>
							<th>암호</th>
							<td><input type="password" name="password"></td>
						</tr>
						<tr>
							<th>직원명</th>
							<td><input type="text" name="ename"></td>
						</tr>
						<tr>
							<th>승인권한</th>
							<td>
								<select name="authority" class="search">
									<option value=""></option>
									<option value="N">없음</option>
									<option value="Y">있음</option>
								</select>
							</td>
						</tr>
						<tr>
							<th>직책</th>
							<td>
								<select name="job"  class="search">
									<option value=""></option>
									<option>사원
									<option>대리									
									<option>과장									
									<option>차장									
									<option>부장									
								</select>
							</td>
						</tr>
					</table>
				</form>
				<div class="insert-btn">
					<button id="addEmp" class="btn">등록</button>
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
	
	// 	검색초기화
	document.querySelector("#initBtn").addEventListener("click",  function(){callView('emp.do')});
	
	
</script>

<script type="text/javascript">
	function addEmp() {
		const employeeCd = frm.employeeCd.value;
		const ename = frm.ename.value;
		const password = frm.password.value;
		const job = frm.job.value;
		const department = frm.department.value;
 		const authority = frm.authority.value;
		
		if (employeeCd == '' || ename == '' || password == '' || job == '' || 
				department == '' || authority == ''){
			alert('값을 채워넣어주세요');
			if (employeeCd == '') {
				$("input[name='employeeCd']").addClass('red');
			} else {
 			    $("input[name='employeeCd']").removeClass('red');		
			}
			if (ename == '') {
				$("input[name='ename']").addClass('red');
			} else {
 			    $("input[name='ename']").removeClass('red');		
			}
			if (password == '') {
				$("input[name='password']").addClass('red');
			} else {
 			    $("input[name='password']").removeClass('red');		
			}
			if (job == '') {
				$("select[name='job']").addClass('red');
			} else {
 			    $("select[name='job']").removeClass('red');		
			}
			if (department == '') {
				$("select[name='department']").addClass('red');
			} else {
 			    $("select[name='department']").removeClass('red');		
			}
			if (authority == '') {
				$("select[name='authority']").addClass('red');
			} else {
 			    $("select[name='authority']").removeClass('red');		
			}
		} else {
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
				authority : searchBoxx.authority.value,
				del : searchBoxx.del.value,
				
				sortEmployeeCd : searchBoxx.sortEmployeeCd.value,
				sortEname : searchBoxx.sortEname.value,
				sortJob : searchBoxx.sortJob.value,
				sortDepartment : searchBoxx.sortDepartment.value,
				sortAdddate : searchBoxx.sortAdddate.value,
				sortAuthority : searchBoxx.sortAuthority.value,
				
				rowPerPage : itemLimit.rowPerPage.value,
				
				currentPage : paging.currentPage.value
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
 		             employeeCd = tdd.eq(2).text();
 		             ename = tdd.eq(3).text();
 		             job = tdd.eq(4).text();
 		             department = tdd.eq(5).text();
 		             authority = tdd.eq(7).text();
 	             
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
		
		if (paging.currentPage.value > ${employee.totalPage }) {
			paging.currentPage.value = ${employee.totalPage };
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
			
			if (paging.currentPage.value > ${employee.totalPage }) {
				paging.currentPage.value = ${employee.totalPage };
			}
			
			search();
		}
	});
</script>

<!-- 정렬 -->
<script type="text/javascript">
	function initSort() {
		searchBoxx.sortEmployeeCd.value = 0;
		searchBoxx.sortEname.value = 0;
		searchBoxx.sortJob.value = 0;
		searchBoxx.sortDepartment.value = 0;
		searchBoxx.sortAdddate.value = 0;
		searchBoxx.sortAuthority.value = 0;
	}

	$('#sortEmployeeCd').on('click', function() {
		if (searchBoxx.sortEmployeeCd.value == 0 || searchBoxx.sortEmployeeCd.value == 2) {
			initSort();
			searchBoxx.sortEmployeeCd.value = 1;			
		} else if (searchBoxx.sortEmployeeCd.value == 1) {
			initSort();
			searchBoxx.sortEmployeeCd.value = 2;
		}		
		search();
	});
	$('#sortJob').on('click', function() {
		if (searchBoxx.sortJob.value == 0 || searchBoxx.sortJob.value == 2) {
			initSort();
			searchBoxx.sortJob.value = 1;			
		} else if (searchBoxx.sortJob.value == 1) {
			initSort();
			searchBoxx.sortJob.value = 2;
		}		
		search();
	});
	$('#sortEname').on('click', function() {
		if (searchBoxx.sortEname.value == 0 || searchBoxx.sortEname.value == 2) {
			initSort();
			searchBoxx.sortEname.value = 1;		
		} else if (searchBoxx.sortEname.value == 1) {
			initSort();
			searchBoxx.sortEname.value = 2;
		}		
		search();
	});
	$('#sortDepartment').on('click', function() {
		if (searchBoxx.sortDepartment.value == 0 || searchBoxx.sortDepartment.value == 2) {
			initSort();
			searchBoxx.sortDepartment.value = 1;			
		} else if (searchBoxx.sortDepartment.value == 1) {
			initSort();
			searchBoxx.sortDepartment.value = 2;
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
	$('#sortAuthority').on('click', function() {
		if (searchBoxx.sortAuthority.value == 0 || searchBoxx.sortAuthority.value == 2) {
			initSort();
			searchBoxx.sortAuthority.value = 1;			
		} else if (searchBoxx.sortAuthority.value == 1) {
			initSort();
			searchBoxx.sortAuthority.value = 2;
		}		
		search();
	});
</script>

<!-- 전체 선택 / 삭제  -->
<c:if test="${employee.del =='N' or employee.del == 'All' }">
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
		  
		  if(checkRow == ''){
		    alert("삭제할 대상을 선택하세요.");
		    return false;
		  }
		  $.ajax({
			    url : "employeeDelete.do",
			    type : "post",
			    traditional : true,
			    data : { checkRows : checkRow },
			    
			    success : function(result){
			    	if(result){
			    		alert("삭제완료");
			    		search();
			    		
			    	}else
			    		alert("삭제실패");
			    }
		  });
	};
	
</script>

<!-- 삭제 항목 복원  -->
<c:if test="${employee.del =='Y'}">
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
		    url : "employeeRestore.do",
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
	$('#department').on("change", function() {
		let count = 0;
		$.ajax({
		     method: 'post', 
		     url: 'getSALCount.do', 
		     traditional: true,
		     async: false,
		     data: {
		    	department: frm.department.value
		     },
		     success: function (result) {
		    	 count = result;
		    	 console.log(count);
			}
	   	});
		if (frm.department.value == '영업'){
			console.log('SAL' + count);
			frm.employeeCd.value = 'SAL' + count;
		}
		if (frm.department.value == '관리'){
			console.log('MNG' + count);
			frm.employeeCd.value = 'MNG' + count;
		}
	});
</script>

<script>
	function excel() {
		
		let checkRow = new Array();
		
		$( ".excel:checked" ).each (function (){
			 let thisRow = $(this).closest('tr');
			 
//			orderNo = thisRow.find('td:eq(2)').find('input').val();
//			productCD = thisRow.find('td:eq(3)').find('input').val();
			  
			 const item = {
				employeeCd : thisRow.find('td:eq(0)').find('input').val()
			 }

			 checkRow.push(item);
		
		});
		
		  
		 console.log(checkRow);
		 
		 J300.ajax({
			  url : 'empExcelDown.do',
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

<!-- 스모셀렉트 -->
<script type="text/javascript">
$(document).ready(function() {
	$('.sumo').SumoSelect({
		search: true,
		searchText: '검색어 입력',
	});
	$('select.authority')[0].sumo.selectItem("${buyer.authority }");
	
	$('select.job')[0].sumo.selectItem("${buyer.job }");
	
	$('select.department')[0].sumo.selectItem("${buyer.department }");
	

	
});
</script>

<!-- 날짜 최소 / 최대 제한 주기 -->
<script type="text/javascript">
	$('input[name="addFromDate"]').on('change', function(){
		const minDate= $(this).val();
		$('input[name="addToDate"]').attr('min',minDate);
	});
	$('input[name="addToDate"]').on('change', function(){
		const maxDate= $(this).val();
		$('input[name="addFromDate"]').attr('max',maxDate);
	});
</script>
</html>