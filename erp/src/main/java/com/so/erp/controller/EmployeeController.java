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
	public String emp(Model model, Employee employee) {
		
		int rowPerPage = 20 ;
		
		if (employee.getRowPerPage() != 0) {
			rowPerPage = employee.getRowPerPage();
		} 
		if (employee.getPageNum() == null || employee.getPageNum().equals("")) {
			employee.setPageNum("1");
		}
		
		employee.setDel("N");
		
		int currentPage = Integer.parseInt(employee.getPageNum());
		int total = es.getTotal(employee);
		
		employee.pagingBean(currentPage, rowPerPage, total);
		int startRow = (currentPage - 1) * rowPerPage + 1;
		int endRow = startRow + rowPerPage - 1;
		employee.setStartRow(startRow);
		employee.setEndRow(endRow);
		
		employee.setSortEmployeeCd(0);
		employee.setSortEname(0);
		employee.setSortAdddate(1);
		employee.setSortJob(0);
		employee.setSortDepartment(0);
		employee.setSortAuthority(0);
		
		List<Employee> empList = es.search(employee);
		
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
			
			String del = (String) keywordObj.get("del");
			employee.setDel(del);
			
			int sortEmployeeCd = Integer.valueOf((String) keywordObj.get("sortEmployeeCd"));
			employee.setSortEmployeeCd(sortEmployeeCd);
			int sortEname = Integer.valueOf((String) keywordObj.get("sortEname"));
			employee.setSortEname(sortEname);
			int sortJob = Integer.valueOf((String) keywordObj.get("sortJob"));
			employee.setSortJob(sortJob);
			int sortDepartment = Integer.valueOf((String) keywordObj.get("sortDepartment"));
			employee.setSortDepartment(sortDepartment);
			int sortAdddate = Integer.valueOf((String) keywordObj.get("sortAdddate"));
			employee.setSortAdddate(sortAdddate);
			int sortAuthority = Integer.valueOf((String) keywordObj.get("sortAuthority"));
			employee.setSortAuthority(sortAuthority);			
			
			int rowPerPage = Integer.valueOf((String) keywordObj.get("rowPerPage"));
			int currentPage = Integer.valueOf((String) keywordObj.get("currentPage"));
			int total = es.getTotal(employee);
			
			employee.pagingBean(currentPage, rowPerPage, total);
			
			int startRow = (currentPage - 1) * rowPerPage + 1;
			int endRow = startRow + rowPerPage - 1;
			employee.setStartRow(startRow);
			employee.setEndRow(endRow);
			
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
	
	@RequestMapping("employeeDelete")
	@ResponseBody
	public boolean employeeDelete(String[] checkRows) {
		boolean result = true;
		
		for (String employeeCd : checkRows){
			try {
				es.employeeDelete(employeeCd);
			} catch (Exception e) {
				System.out.println("실패 : " + employeeCd);
				result = false;
			}			
		}
		return result;
	}
	
	
	@RequestMapping("employeeRestore")
	@ResponseBody
	public boolean employeeRestore(String[] checkRows) {
		boolean result = true;
		
		for (String employeeCd : checkRows){
			try {
				es.employeeRestore(employeeCd);
			} catch (Exception e) {
				System.out.println("실패 : " + employeeCd);
				result = false;
			}			
		}
		return result;
	}
	
	@RequestMapping("getSALCount")
	@ResponseBody
	public String getSALCount(String department) {
		int count = es.getSALCount(department);
		String number = String.format("%03d", count);
		
		System.out.println(number);
		
		return number;
	}
	
}
