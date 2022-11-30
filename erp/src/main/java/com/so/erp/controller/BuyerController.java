package com.so.erp.controller;

import java.sql.Date;
import java.util.List;

import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.so.erp.model.Buyer;
import com.so.erp.model.Country;
import com.so.erp.model.OrderHead;
import com.so.erp.service.BuyerService;
import com.so.erp.service.CountryService;

import net.sf.json.JSONObject;

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
	//보내준 delBuyers라는 파라미터 값을 delBuyers라고 전달받아줘(파라미터 맵핑)
	public int buyerDelete(@RequestParam(name="delBuyers") List<String> delBuyers) { 
		int result=0;
		for(String buyerCd:delBuyers) {
			result = bs.delete(buyerCd);
		}
		return result;
	}
	
	@RequestMapping("buyerUpdate")
	@ResponseBody
	// ajax 로 보내준 값들이 buyer에 담김
	public int buyerUpdate(Buyer buyer) {
		int result=0;
		result = bs.update(buyer);
		return result;
	}
	
	@RequestMapping("buyerSearch")
	@ResponseBody
	public String buyerSearch(Model model, @RequestParam(name="keyword") String keyword) {
		System.out.println("값이왔다!");
		try {
			
			JSONParser p = new JSONParser();
			Object obj = p.parse(keyword);
			JSONObject keywordObj = JSONObject.fromObject(obj);
			
			Buyer buyer = new Buyer();
			String buyerCd = (String) keywordObj.get("buyerCd"); //고객코드
			buyer.setBuyerCd(buyerCd);
			String bname = (String) keywordObj.get("bname"); //고객명
			buyer.setBname(bname);
			
			System.out.println("고객코드, 고객명 왔다");
			
			String manager = (String) keywordObj.get("manager"); //담당자
			buyer.setManager(manager);
			String countryCd = (String) keywordObj.get("countryCd"); //국가코드
			buyer.setCountryCd(countryCd);
			
			System.out.println("담당자, 국가코드 왔다");
			
			String tel = (String) keywordObj.get("tel"); //전화번호
			buyer.setTel(tel);
			String email = (String) keywordObj.get("email"); //이메일
			buyer.setEmail(email);
			String address = (String) keywordObj.get("address"); //주소
			buyer.setAddress(address);
			
			List<Buyer> bsearchList = bs.search(buyer);
			
			model.addAttribute("bsearchList", bsearchList);
			model.addAttribute("buyer", buyer);
			
		} catch (ParseException e) {
			System.out.println(e.getMessage());
		}
		return "page/buyer";
	}
}
