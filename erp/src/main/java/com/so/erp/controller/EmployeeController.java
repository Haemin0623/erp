package com.so.erp.controller;

import java.sql.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.so.erp.model.Employee;
import com.so.erp.service.EmployeeService;

import net.sf.json.JSONObject;

@Controller
public class EmployeeController {

	@Autowired
	private EmployeeService es;

	@RequestMapping("emp")
	public String emp(Model model) {
		
		List<Employee> empList = es.list();
		
		model.addAttribute("empList", empList);
		
		return "nolay/emp";
	}
	
	@RequestMapping("empInsert")
	@ResponseBody
	public boolean empInsert(Model model, Employee employee) {
		
		boolean result = true;
		
		try {
			es.insert(employee);
		} catch (Exception e) {
			System.out.println(e.getMessage());
			result = false;
		}
		
		return result;
	}
	
	@RequestMapping("empSearch")
	public String empSearch(Model model, @RequestParam(name="keyword") String keyword) {
		
		System.out.println("1");
		
		try {
			
			JSONParser p = new JSONParser();
			Object obj = p.parse(keyword);
			JSONObject keywordObj = JSONObject.fromObject(obj);
			
			Employee employee = new Employee();
			
			String employeeCd = (String) keywordObj.get("employeeCd");
			employee.setEmployeeCd(employeeCd);
			String ename = (String) keywordObj.get("ename");
			employee.setEname(ename);
			String job = (String) keywordObj.get("job");
			employee.setJob(job);
			String department = (String) keywordObj.get("department");
			employee.setDepartment(department);
			
			String addFromDate = (String) keywordObj.get("addFromDate");
			if (addFromDate != null && !addFromDate.equals("") ) {
				Date date = Date.valueOf(addFromDate);
				employee.setAddFromDate(date);
			}
			
			String addToDate = (String) keywordObj.get("addToDate");
			if (addToDate != null && !addToDate.equals("") ) {
				Date date = Date.valueOf(addToDate);
				employee.setAddToDate(date);
			}
			
			System.out.println("4");
			
			String authority = (String) keywordObj.get("authority");
			employee.setAuthority(authority);
			
			
			List<Employee> empList = es.search(employee);
			System.out.println(empList.size());
			
			for (Employee oh : empList) {
				System.out.println(oh.toString());
			}
			
			model.addAttribute("empList", empList);
			model.addAttribute("employee", employee);
			
		} catch (ParseException e) {
			System.out.println(e.getMessage());
		}
		
		return "nolay/emp";
	}
	
	@RequestMapping("empUpdate.do")
	@ResponseBody
	public boolean empUpdate(Employee employee) {
		
		boolean result = true;
		
		try {
			es.update(employee);
		} catch (Exception e) {
			System.out.println(e.getMessage());
			result = false;
		}
		
		return result;
	}
	@RequestMapping("login.do")
	public String login(String employeeCd, String password, Model model, HttpServletResponse response,HttpServletRequest request) {
		int result = 0;
		Employee employee = es.select(employeeCd);
		
		if(employee == null || employee.getDel().equals("Y")) {
			result = -1;//탈퇴 회원(퇴사자) 또는 조회한 아이디가 없으면  로그인실패
		}else {
				
			 if(employee.getPassword().equals(password)) {
				 String empc = employee.getEmployeeCd();
				 HttpSession session = request.getSession(); 
				 session.setAttribute("employeeCd", empc);
				 result = 1;	//패스워드가 일치하는것은 1 로그인성공
			} else 
				result = 0; //패스워드 불일치
		}
		model.addAttribute("result",result);
		return "page/loginResult";
	}
}
