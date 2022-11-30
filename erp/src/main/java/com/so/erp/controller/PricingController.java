package com.so.erp.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.so.erp.model.PagingBean;
import com.so.erp.model.Pricing;
import com.so.erp.service.PricingService;

@Controller
public class PricingController {

	@Autowired
	private PricingService prs;
	
	@RequestMapping("pricing")
	public String pricing(Model model, Pricing pricing, String pageNum) {
		//페이징
		int rowPerPage = 10; // 페이지 당 게시글 갯수
		if (pageNum == null || pageNum.equals("")) pageNum = "1";
		int currentPage = Integer.parseInt(pageNum);
		int total = prs.getTotal();
		int startRow = (currentPage - 1) * rowPerPage + 1;
		int endRow = startRow + rowPerPage -1;
		int num = total - startRow + 1;
		pricing.setStartRow(startRow);
		pricing.setEndRow(endRow);
		PagingBean pb = new PagingBean(currentPage, rowPerPage, total);
		
		List<Pricing> pricingList = new ArrayList<Pricing>();
		pricingList = prs.pricingList(pricing);
		
		model.addAttribute("pricingList", pricingList);
		model.addAttribute("pb", pb);
		model.addAttribute("num", num);
		return "page/pricing";
	}
	
	
	@RequestMapping("insert")
	public String insert(Model model, Pricing pricing) {
		int result = 0;
		result = prs.insert(pricing);
		System.out.println(pricing);
		model.addAttribute("result", result);
		return "page/pricing";
	}
}




