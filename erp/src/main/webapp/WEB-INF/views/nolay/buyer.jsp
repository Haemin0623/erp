<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../layoutElement/taglib.jsp"%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<style type="text/css">

#searchBox {
	width: 90%;
	height: 150px;
	background: gray;
/* 	margin-top: 50px; */
	color: white;
}

table {
	width: 100%;
	border: black;
	position: absolute;
	width: inherit;
}

#list {
	width: 90%;
	height: 280;
	margin-top: 50px;
}
.keyword {
	margin-top: 10px;
	margin-left: 20px;
}

#searchBtn{
	background: navy;
	color: white;
	cursor: pointer;
	float: right;
	margin-right: 50px;
	margin-top: 15px
}
#addBuyerBtn{
margin-top:200px;
}

.header th {
	background: gray;
	color: white;
}

/* 마우스 오버(마우스 올렸을때) */
tr {
	color: black;
}

tr:hover {
	background-color: #f4f4f4;
	cursor: pointer;
}
/* 마우스 클릭하고있을때 */
tr:active {
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

	<!-- 검색박스 -->
	<h1> 고객 관리</h1>
	<div id="searchBox">
		<form name ="searchBoxx" id="searchBox">
		고객코드 <input type="text" name="buyerCd" class="keyword" value="${buyer.buyerCd}">
		고객명 <input type="text" name="bname" class="keyword" value="${buyer.bname}">
		담당자 <input type="text" name="manager" class="keyword" value="${buyer.manager}">
		국가코드
			<select name="countryCd" >
				<option value=""></option>
				<c:forEach var="countryCd" items="${countryCdList}">
					<option value="${countryCd.countryCd}">${countryCd.cname}(${countryCd.countryCd})</option>
				</c:forEach>
			</select><br>
		전화번호<input type="text" name="tel" class="keyword" value="${buyer.tel}">
		이메일 <input type="text" name="email" class="keyword" value="${buyer.email}">
		주소 <input type="text" name="address" class="keyword" value="${buyer.address}">
		
		</form>	
			<button id="searchBtn">검색</button>
	</div>
	
	<button id="show">신규등록</button>
	<button id="delBuyer">삭제</button>
	
	<!-- 고객리스트 & 수정가능한 테이블 -->
	<div id="table">
	<form action="" name="bt">
	<table id="list" >
		<tr class="header">
			<th>선택</th>
			<th>고객코드</th>
			<th>고객명</th>
			<th>담당자</th>
			<th>전화번호</th>
			<th>이메일</th>
			<th>주소</th>
			<th>국가코드</th>
			<th>등록일</th>
			<th>최종수정일</th>
		</tr>
		<c:forEach var="buyer" items="${buyerList }">
			<tr>
				<td>
					<c:if test="${buyer.del =='Y'}"> <!-- del값이 Y이면 보여주지않고, N이면 보여준다 -->
						<input type="checkbox" name="del" value="${buyer.buyerCd}" disabled="disabled">
					</c:if>
					<c:if test="${buyer.del =='N'}">
						<input type="checkbox" name="del" value="${buyer.buyerCd}">
					</c:if>
				</td>
				<td>${buyer.buyerCd }</td>
				<td class="editable">${buyer.bname }</td>
				<td class="editable">${buyer.manager}</td>
				<td class="editable">${buyer.tel}</td>
				<td class="editable">${buyer.email}</td>
				<td class="editable">${buyer.address}</td>
				<td>${buyer.countryCd}</td>
				<td>${buyer.adddate}</td>
				<td>${buyer.statusdate}</td>
			</tr>
		</c:forEach>
	</table>
	</form>
	</div>
	
	<!-- 	등록 창 팝업 -->
	<div class="background">
		<div class="window">
			<div class="popup">
				<button id="close">취소</button>	
				<form action="" name="frm">
				<h1> 고객등록 </h1>
				<table> 
					<tr>
						<th>고객코드</th>
						<td><input type="text" name="buyerCd"></td>
					</tr>
					<tr>
						<th>고객명</th>
						<td><input type="text" name="bname"></td>
					</tr>
					<tr>
						<th>담당자</th>
						<td><input type="text" name="manager"></td>
					</tr>
					<tr>
						<th>전화번호</th>
						<td><input type="text" name="tel"></td>
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
							<select name="countryCd"> <!-- countryCd.countryCd을 값으로, countryCd를 키로 보냄 -->
								<c:forEach var="countryCd" items="${countryCdList}">
									<option value="${countryCd.countryCd}">${countryCd.cname}(${countryCd.countryCd})</option>
								</c:forEach>
							</select>
						</td>
					</tr>
				</table>

				</form>
					<button id="addBuyerBtn">등록</button>
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

	//검색 기능
	function search() {
		
		const keyword = {
			buyerCd : searchBoxx.buyerCd.value,	
			bname : searchBoxx.bname.value,	
			manager : searchBoxx.manager.value,	
			countryCd : searchBoxx.countryCd.value,	
			tel : searchBoxx.tel.value,	
			email : searchBoxx.email.value,	
			address : searchBoxx.address.value,	
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
	}
	document.querySelector("#close").addEventListener("click", close);
	
	
	// 신규등록 팝업 열기
	function addBuyer() {
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
		    	console.log(result);
		        if (result) {
		        	document.location.reload();
					alert("입력성공");
		        } else {
		        	alert("실패");
		        }
			}
	   });
	}
	
	document.querySelector("#addBuyerBtn").addEventListener("click", addBuyer); 
	
	function delBuyer() {
		var cdArr = new Array(); //del 체크가 여러개일수도 있기에 배열로 받음
		$("input[name='del']:checked").each(function() { //input태그의 이름이 del인 것이 check되면 아래 함수 실행
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
		        	document.location.reload(); // 삭제성공시, 페이지 새로고침
					alert("삭제완료");
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
	
	
	// 	 테이블 수정가능하게 editable
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
    		             buyerCd = tdd.eq(1).text();
    		             bname = tdd.eq(2).text();
    		             manager = tdd.eq(3).text();
    		             tel = tdd.eq(4).text();
    		             email = tdd.eq(5).text();
    		             address = tdd.eq(6).text();
    		             countryCd = tdd.eq(7).text();
    		             
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

</html>

