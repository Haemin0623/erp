package com.so.erp.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.so.erp.service.CountryService;

@Controller
public class CountryController {

	@Autowired
	private CountryService country;

	
}
