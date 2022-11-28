package com.so.erp.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.so.erp.model.Pricing;
import com.so.erp.service.PricingService;

@Controller
public class PricingController {

	@Autowired
	private PricingService prs;
	
	@RequestMapping("pricing")
	public String pricing(Model model, Pricing pricing) {
		List<Pricing> pricingList = prs.pricingList(pricing);
		model.addAttribute("pricingList", pricingList);
		return "page/pricing";
	}
	
	@RequestMapping("insert")
	public String insert(Model model) {
		
		return "page/pricing";
	}
}
