package com.so.erp.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class SessionChk extends HandlerInterceptorAdapter{
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		HttpSession session = request.getSession();
		
		if(session == null || session.getAttribute("employeeCd") == null ||
				session.getAttribute("employeeCd").equals("")) {
			
			// 기존에 가려면 페이지의 주소를 저장해서 전달
			String path = request.getRequestURI();
			
			System.out.println("요청주소 : " + path);
			
			String pathSplit[] = path.split("/");
			String targetPage = pathSplit[2];
			
			System.out.println("targetPage(세션체크) : "+targetPage);
			
			session.setAttribute("targetPage", targetPage);
			response.sendRedirect("hello.do");
			
			return false;
		}
		return true;
	}
}