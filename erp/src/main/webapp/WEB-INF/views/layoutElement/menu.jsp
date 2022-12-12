<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../layoutElement/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<style type="text/css">

	.text-primary {
		font-family: 'KyoboHandwriting2020A';
		font-size: 50px;
		margin-left: 30px;
		color: white;
	}
	
	.text-member {
		font-size: 11px;
		margin-left: 30px;
		color: white;
	}
	
	.line {
	
	}
	
	.line2 {
		margin-top: 120%;
	}

	.menuList {
		font-family: 'GmarketSansMedium';
		margin-right: 10px;
		margin-top: 40px;		
		list-style: none;
		font-weight: bold;
		text-align: right;
		font-size: 30px;
		color: white;
	}
	
	.subMenu {
		font-family: 'BCcardB';
		margin-top: 5px;
		margin-right: 10px;
		list-style: none;
		text-align: right;
		font-size: 20px;
		color: white;
	}
	
	.subMenu:hover {
		background-color: #fcfaee;
	}
	
	a {
		text-decoration-line: none;
        color: #41814e;
	}
	
	a:hover {
		color: black;
	} 
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

	
<script type="text/javascript">

	menu1.onclick = function() {
		if (openCheck('menu1')) {
			return;
		} else {
			creatTemplate('menu1');
		}
	}
	menu2.onclick = function() {
		if (openCheck('menu2')) {
			return;
		} else {
			creatTemplate('menu2');
		}
	}
	
	function openCheck(name) {
		let temp = $globalStorage.getValue(name);
		let check = (temp == 'open') ? true : false;
		return check;
	}
	
	
	function creatTemplate(menuname) {
	    //이름 변경
	    let url;
	    let name;
	    switch (menuname) {
	        case 'menu1':
	            name = "메뉴1"
	            url = 'menu/menu1.do'
	            $globalStorage.setValue('menu1', 'open');
	            break;
	        case 'menu2':
	            name = "메뉴2"
	            url = 'menu/menu2.do'
	            $globalStorage.setValue('menu2', 'open');
	            break;
	        case 'menu3':
	            name = "메뉴3"
	            url = 'menu/menu3.do'
	            $globalStorage.setValue('menu3', 'open');
	            break;
	    }


	    // 템플릿 만드는 곳
	    let node = document.createElement('li');
	    node.classList.add(menuname);

	    let tabname = menuname + 'tab';
	    let tabclosename = menuname + 'close';

	    const template = '<span>
	    					<a href="javascript:void(0);" id="\${tabname}"}">\${name}</a>
	    					<button id="\${tabclosename}"}">닫기</button>
	    				<span>'

	    node.innerHTML = template;
	    tabmenu.appendChild(node);

	    //$('#tabmenu').append(template);
	    //메뉴 생성시 해당 카운트 새야함. -> globalvariable
	    //지금 마지막으로 열려있는곳 activate
	    setActivate(url);


	    $('#tabcontent').load(url, function () { //~~에 로드한다. 즉 해당 url의 값을 산하에 두겠다는 의미
	        //히스토리 저장하기
	        let newContent = document.querySelector('#content');
	        let id = $random.random();
	        setHistory(url, newContent, id)

	    });

	    //template click listener

	    $("#" + tabclosename).click(function () {

	        let close = document.querySelectorAll(("." + menuname));
	        close.forEach(function (close) {
	            close.remove();
	        });

	        $globalStorage.setValue(menuname, 'close');
	        let indexkey = index(url);
	        console.log(indexkey)

	        if (_historyTab.activate == url) {

	            if (indexkey.key.length == 1) {

	                let oldElement = document.querySelector('div#content');
	                oldElement.remove();
	                //
	                delete history[url];

	            }else{

	            console.log('activate')
	            let oldElement = document.querySelector('div#content');
	            let siburl = indexkey.siblingid;

	                if(indexkey.index ==0){
	                    let next = indexkey.nextId
	                    siburl = indexkey.key[next];
	                }

	            console.log(siburl);
	            content.replaceChild(history[siburl].content, oldElement);
	            setActivate(siburl);

	            delete history[url];
	            }
	        } else {
	            delete history[url];
	        }


	    });

	    $(document).on("click", "#" + tabname, function () {
	        //replaceChild 와야함
	        let oldElement = document.querySelector('div#content');
	        content.replaceChild(history[url].content, oldElement);
	        setActivate(url);

	    });


	}
</script>

</head>
<body>

	<h1 class="text-primary">2조</h1>
	<h6 class="text-member">
		<c:if test="${sessionScope.employeeCd != null }">
			${sessionScope.employeeCd }(${sessionScope.ename })
			<a href="logout.do">로그아웃</a>
		</c:if>
	</h6>
	<hr class="line">


	<div>
			<ul>
				<li class="menuList">마스터</li>
				<li id="menu1" class="subMenu"><a href="javascript:void(0);" onclick="changeContent('productList.do')">상품</a></li>
				<li id="menu2" class="subMenu"><a href="javascript:void(0);" onclick="changeContent('buyer.do')">고객</a></li>
				<li id="menu3" class="subMenu"><a href="javascript:void(0);" onclick="changeContent('pricing.do')">판매가</a></li>
				<li id="menu4" class="subMenu"><a href="javascript:void(0);" onclick="changeContent('emp.do')">직원</a></li>
			</ul>
			
			<ul>
				<li class="menuList">주문</li>
				<li id="menu5" class="subMenu"><a href="javascript:void(0);" onclick="changeContent('order.do')">주문 관리</a></li>
				<li id="menu6" class="subMenu"><a href="javascript:void(0);" onclick="changeContent('orderApprovalWindow.do')">주문 승인</a></li>
			</ul>   
			
			<ul>
				<li class="menuList">REPORT</li>
				<li id="menu7" class="subMenu"><a href="javascript:void(0);" onclick="changeContent('orderStatus.do')">주문 현황</a></li>
			</ul>
	</div>
	<hr class="line2">
</body>
</html>