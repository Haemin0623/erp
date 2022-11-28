package com.so.erp.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.so.erp.model.Buyer;
import com.so.erp.model.Country;
import com.so.erp.service.BuyerService;
import com.so.erp.service.CountryService;

@Controller
public class BuyerController {

	@Autowired
	private BuyerService buyer;
	@Autowired
	private CountryService country;

	
	@RequestMapping("buyer")
	public String buyer(Model model) {
		List<Buyer> buyerList = buyer.list();
		List<Country> countryCdList = country.list();
		model.addAttribute("buyerList", buyerList);
		model.addAttribute("countryCdList", countryCdList);
		
		return "page/buyer";
		
	}
}
