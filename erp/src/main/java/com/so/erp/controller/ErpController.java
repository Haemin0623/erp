package com.so.erp.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.so.erp.model.Employee;
import com.so.erp.service.EmployeeService;

@Controller
public class ErpController {
	
	@Autowired
	private EmployeeService es;
	
	@RequestMapping("hello")
	public String hello() {
		
		return "page/logIn";
	}
	
	@RequestMapping("/")
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
	
	@RequestMapping("logout.do")
	public String logout(HttpSession session) {
		
		session.invalidate();
		
		return "page/logIn";
	}
	
}
