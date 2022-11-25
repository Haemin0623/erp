package com.so.erp.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class ErpController {

	
	@RequestMapping("hello")
	public String hello() {
		
		return "page/hello";
	}

	
}
