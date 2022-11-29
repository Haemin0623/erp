package com.so.erp.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.so.erp.model.Buyer;
import com.so.erp.model.Country;
import com.so.erp.service.BuyerService;
import com.so.erp.service.CountryService;

@Controller
public class BuyerController {

	@Autowired
	private BuyerService bs;
	@Autowired
	private CountryService cs;

	
	@RequestMapping("buyer")
	public String buyer(Model model) {
		List<Buyer> buyerList = bs.list();
		List<Country> countryCdList = cs.list();
		model.addAttribute("buyerList", buyerList);
		model.addAttribute("countryCdList", countryCdList);
		
		return "page/buyer";
		
	}
	@RequestMapping("buyerInsert")
	// view 페이지가 아닌 반환값 그대로 return 하고 싶을 때 사용
	@ResponseBody
	public boolean buyerInsert(Buyer buyer) {
		System.out.println(buyer.getBuyerCd());
		
		int result = bs.insert(buyer);		
		System.out.println(result);
		
		boolean check = true;
		
		if (result <= 0) {
			check=false;
		}
		return check;
		
	}
	
	@RequestMapping("buyerDelete")
	@ResponseBody
	public int buyerDelete(@RequestParam(name="delBuyers") List<String> delBuyers) {
		int result=0;
		for(String buyerCd:delBuyers) {
			result = bs.delete(buyerCd);
		}
		return result;
	}
}
