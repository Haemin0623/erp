package com.so.erp.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.so.erp.service.EmployeeService;

@Controller
public class EmployeeController {

	@Autowired
	private EmployeeService employee;

	
}
