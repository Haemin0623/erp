package com.so.erp.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.so.erp.model.Employee;
import com.so.erp.service.EmployeeService;

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
	
}
