package com.so.erp.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.so.erp.model.Employee;

public class AuthorityChk extends HandlerInterceptorAdapter{
	
	@Autowired
	private EmployeeService es;
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, 
			Object handler) throws Exception {
		HttpSession session = request.getSession();
		String employeeCd = (String) session.getAttribute("employeeCd");
		
		Employee employee = es.select(employeeCd);
		
		if (employee.getAuthority().equals("N")) {
			response.sendRedirect("check.do");
			
			return false;
		}
		
		
		return true;
	}
}