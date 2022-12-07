package com.so.erp.controller;

import java.sql.Date;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.so.erp.model.Buyer;
import com.so.erp.model.Employee;
import com.so.erp.model.OrderHead;
<<<<<<< HEAD
import com.so.erp.model.OrderItem;
=======
import com.so.erp.service.BuyerService;
>>>>>>> a4ff91c (고객마스터 엑셀기능 추가)
import com.so.erp.service.EmployeeService;
import com.so.erp.service.OrderHeadService;
import com.so.erp.service.OrderItemService;

@Controller
public class ErpController {
	
	@Autowired
	private EmployeeService es;
	@Autowired
	private OrderHeadService hs;
	@Autowired
	private OrderItemService is;
	@Autowired
	private BuyerService bs;

	
	@RequestMapping("hello")
	public String hello() {
		
		return "page/logIn";
	}
	
	@RequestMapping("main")
	public String main() {
		
		return "page/main";
	}
	
	@RequestMapping("login.do")
	public String login(String employeeCd, String password, Model model, HttpSession session) {
		int result = 0;
		Employee employee = es.select(employeeCd);
		
		if(employee == null || employee.getDel().equals("Y")) {
			result = -1;//탈퇴 회원(퇴사자) 또는 조회한 아이디가 없으면  로그인실패
		}else {
				
			 if(employee.getPassword().equals(password)) {
				 String empc = employee.getEmployeeCd();
				 session.setAttribute("employeeCd", empc);
				 session.setAttribute("ename", employee.getEname());
				 result = 1;	//패스워드가 일치하는것은 1 로그인성공
			} else 
				result = 0; //패스워드 불일치
		}
		model.addAttribute("result",result);
		return "page/loginResult";
	}
	
	@RequestMapping("logout")
	public String logout(HttpSession session) {
		
		session.invalidate();
		
		Employee emp = new Employee();		
		for (int i = 1; i < 1000; i++) {
			String number = String.format("%03d", i);
			emp.setEmployeeCd("TEST" + number);
			emp.setEname("더미" + number);
			emp.setPassword("123");
			emp.setDepartment("테스트");
			emp.setJob("사원");
			emp.setAuthority("N");
			String adddate = "2020-12-01";
			Date date = Date.valueOf(adddate);
			emp.setAdddate(date);
			emp.setDel("N");
			
			es.insert(emp);
			
		}
		
		OrderHead head = new OrderHead();
		String[] emp2 = {"SAL001", "SAL002", "SAL003", "SAL004", "SAL005"};
		for (int i = 1; i < 1000; i++) {
			String number = String.format("%03d", i);
			head.setOrderNo("221201CVS001" + number);
			head.setBuyerCd("CVS001");
			String orderdate = "2022-12-01";
			Date date = Date.valueOf(orderdate);
			head.setOrderdate(date);
			int num = (int)(Math.random()*4);
			head.setEmployeeCd(emp2[num]);
			head.setReason("테스트용");
			head.setStatus("승인");
			head.setStatusdate(date);
			head.setSignempCd("SAL005");
			head.setDel("N");
			
			hs.insert(head);
			hs.orderApproval(head);
		}
		
		
		OrderItem item = new OrderItem();
		String[] prod = {"SN0001","SN0002","SN0003","SN0004","SN0005",
				"SN0006","RA0001" ,"RA0002" ,"DR0001","DR0002"};
		for (int i = 1; i < 1000; i++) {
			String number = String.format("%03d", i);
			item.setOrderNo("221201CVS001" + number);
			
			for (int j = 0; j < 10; j++) {
				item.setProductCd(prod[j]);
				int num = (int)(Math.random()*300)+1;
				item.setRequestqty(num);
				String orderdate = "2022-12-12";
				Date date = Date.valueOf(orderdate);
				item.setRequestdate(date);
				item.setPrice(500);
				item.setAmount(500 * num);
				item.setRemark("테스트");
				
				is.insert(item);
			}
		}

		
		Buyer buyer = new Buyer();		
		for (int i = 1; i < 1000; i++) {
			String number = String.format("%03d", i);
			buyer.setBuyerCd("CVS001" + number);
			buyer.setCountryCd("KR");
			buyer.setBname("더미" + number);
			buyer.setManager("더미" + number);
			buyer.setAddress("서울시 강남구 테헤란로"+number);
			buyer.setTel("010-1111-2222");
			buyer.setEmail("test@test.com");
			
			String adddate = "2020-12-01";
			Date date = Date.valueOf(adddate);
			buyer.setAdddate(date);
			buyer.setDel("N");
			buyer.setStatusdate(date);
			
			bs.insert(buyer);
			
		}
		
		return "page/logIn";
	}

	
	@RequestMapping("check")
	public String check(HttpSession session) {
		
		return "page/check";
	}
	
}
