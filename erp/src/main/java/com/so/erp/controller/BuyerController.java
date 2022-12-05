package com.so.erp.controller;

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
		
		return "nolay/buyer"; // head가 중복으로 나오는 것 방지
		
	}
	
	//아이디 중복검사
	@RequestMapping(value = "dupChk", produces = "text/html;charset=utf-8")
	@ResponseBody //jsp로 가지말고 바로 본문을 전달
	public String dupChk(String buyerCd, Model model) {
		String msg = "";
		Buyer buyer = bs.select(buyerCd);
		if(buyer == null) msg = "사용 가능";
		else msg = "이미 사용중입니다";
		return msg;
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
	public int buyerDelete(Model model, @RequestParam(name="delBuyers") List<String> delBuyers) { 
		int result=0;
		for(String buyerCd:delBuyers) {
			result = bs.delete(buyerCd);
		}
		List <Buyer> notDelList = bs.ndlist();
		
		model.addAttribute("notDelList", notDelList);
		model.addAttribute("result", result);
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
	public String buyerSearch(Model model, @RequestParam(name="keyword") String keyword) {
		System.out.println("값이왔다!");
		System.out.println(keyword);
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
			
			System.out.println("전화번호, 이메일, 주소 왔다");

			// buyer객체를 넣어서 search 결과를 bsearchList 에 담음
			// buyer 페이지로 가므로 buyer.do의 buyerList 를 갖고 페이지로 넘어가게됨.
			// 따라서 아래 bsearchList 값의  key를 buyerList로 바꿔서 페이지로 넘어가야 값을 갖고갈수있음
			List<Buyer> bsearchList = bs.search(buyer); 
			
			System.out.println("조회성공");
			
			model.addAttribute("buyerList", bsearchList); // bsearchList를 buyerList 이름으로 보내줘
			model.addAttribute("buyer", buyer);
			
		} catch (ParseException e) {
			System.out.println(e.getMessage());
		}
		return "nolay/buyer";
	}
}
