package com.so.erp.controller;

import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
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
import com.so.erp.model.OrderHead;
import com.so.erp.model.PagingBean;
import com.so.erp.model.Pricing;
import com.so.erp.model.Product;
import com.so.erp.service.PricingService;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

@Controller
public class PricingController {

	@Autowired
	private PricingService prs;
	
	@RequestMapping("pricing")
	public String pricing(Model model, Pricing pricing, String pageNum, String page) {
		//페이징
		int rowPerPage = 10 ; // 한 화면에 보여주는 갯수
		if (page == null || page == "") {
			rowPerPage = 10;
		}else rowPerPage = Integer.parseInt(page);
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
		
		for (Pricing pricing1 : pricingList) {
			pricing1.setFinalPrice(pricing1.getPrice() * (1 - ((double)pricing1.getDiscountrate()/100)));
		}
		
		model.addAttribute("pricingList", pricingList);
		model.addAttribute("pb", pb);
		model.addAttribute("num", num);
		model.addAttribute("rowPerPage", rowPerPage);
		return "nolay/pricing";
	}
	
	
	@RequestMapping("pricingSearch")
	public String pricingSearch(Model model, String keyword, Pricing pricing, String pageNum, String page) {
		System.out.println("1");
		
		//페이징
			int rowPerPage = 10 ; // 한 화면에 보여주는 갯수
			if (page == null || page == "") {
				rowPerPage = 10;
			}else rowPerPage = Integer.parseInt(page);
			if (pageNum == null || pageNum.equals("")) pageNum = "1";
			int currentPage = Integer.parseInt(pageNum);
			int total = prs.getTotal();
			int startRow = (currentPage - 1) * rowPerPage + 1;
			int endRow = startRow + rowPerPage -1;
			int num = total - startRow + 1;
			pricing.setStartRow(startRow);
			pricing.setEndRow(endRow);
			PagingBean pb = new PagingBean(currentPage, rowPerPage, total);
		
		try {
			
			JSONParser p = new JSONParser();
			Object obj = p.parse(keyword);
			JSONObject keywordObj = JSONObject.fromObject(obj);
			
//			Pricing pricing = new Pricing();
			
			String buyerCd = (String) keywordObj.get("buyerCd");
			pricing.setBuyerCd(buyerCd);
			
			String productCd = (String) keywordObj.get("productCd");
			pricing.setProductCd(productCd);
			
			int startPrice = Integer.valueOf((String)keywordObj.get("startPrice"));
			pricing.setStartPrice(startPrice);
			System.out.println(startPrice);
			int endPrice = Integer.valueOf((String)keywordObj.get("endPrice"));
			pricing.setEndPrice(endPrice);
			System.out.println(endPrice);
			String validDate = (String) keywordObj.get("validDate");
			if (validDate != null && !validDate.equals("") ) {
				Date date = Date.valueOf(validDate);
				pricing.setValidDate(date);
			}
			int discountrate = Integer.valueOf((String)keywordObj.get("discountrate"));
			pricing.setDiscountrate(discountrate);
			
			String currency = (String) keywordObj.get("currency");
			pricing.setCurrency(currency);
			
			String del = (String) keywordObj.get("del");
			pricing.setDel(del);
			
			
			
			
			List<Pricing> searchList = prs.search(pricing);
			System.out.println(searchList.size());
			
			for (Pricing pricing1 : searchList) {
				System.out.println(pricing1.toString());
			}
			
			for (Pricing pricing1 : searchList) {
				pricing1.setFinalPrice(pricing1.getPrice() * (1 - ((double)pricing1.getDiscountrate()/100)));
			}
			
			model.addAttribute("pricingList", searchList);
//			model.addAttribute("pricingList", pricing);
			model.addAttribute("pb", pb);
			model.addAttribute("num", num);
			model.addAttribute("rowPerPage", rowPerPage);
			
		} catch (ParseException e) {
			System.out.println(e.getMessage());
		}
		return "nolay/pricing";
		
		
	}
	
	
	@RequestMapping("pricingDelete")
	@ResponseBody
	public int pricingDelete(@RequestParam(name="checkRows")String[] arr, Pricing pricing) throws java.text.ParseException{
		
		int result = 0;
			for (String i : arr) {
				String[] a = i.split("&");
				String buyerCd = a[0];
				String productCd = a[1];
				
				Date startdate = Date.valueOf(a[2]);
				Date enddate = Date.valueOf(a[3]);
				System.out.println(enddate);
				
				pricing.setBuyerCd(buyerCd);
				pricing.setProductCd(productCd);
				pricing.setStartdate(startdate);
				pricing.setEnddate(enddate);
				
				prs.pricingDelete(pricing);
			}
		result = 1;
		return result;
	}
	
	
	@RequestMapping("pricingInsert")
	@ResponseBody
	public boolean pricingInsert(Model model, @RequestParam(name="items")String items) throws ParseException {		
		
		boolean result = true;
		
		try {
			
			JSONParser p = new JSONParser();
			Object obj = p.parse(items);
			JSONArray arr = JSONArray.fromObject(obj);
			
			Pricing pricing = new Pricing(); 
			
			for (int i = 0; i < arr.size(); i++) {
				
				JSONObject itemObj = (JSONObject) arr.get(i);

				String buyerCd = (String) itemObj.get("buyerCd");
				String productCd = (String) itemObj.get("productCd");
				String rdate = (String) itemObj.get("startdate");
				Date startdate = Date.valueOf(rdate);
				rdate = (String) itemObj.get("enddate");
				Date enddate = Date.valueOf(rdate);
				int price = Integer.parseInt((String) itemObj.get("price"));
				String currency = (String) itemObj.get("currency");
				int discountrate = Integer.parseInt((String) itemObj.get("discountrate"));
				
				pricing.setBuyerCd(buyerCd);
				pricing.setProductCd(productCd);
				pricing.setStartdate(startdate);
				pricing.setEnddate(enddate);
				pricing.setPrice(price);
				pricing.setCurrency(currency);
				pricing.setDiscountrate(discountrate);
				
				prs.pricingInsert(pricing);
			}
		
		} catch (Exception e) {
			System.out.println(e.getMessage());
			result = false;
		}
		
		return result;
	}
	
	@RequestMapping("pricingUpdate")
	@ResponseBody
	public int pricingUpdate(Pricing pricing) {
		int result = 0;
		result = prs.pricingUpdate(pricing);
		return result;
	}
	
	@RequestMapping("getPrice")
	@ResponseBody
	public int getPrice(String buyerCd, String productCd) {
		
		System.out.println(buyerCd);
		System.out.println(productCd);
		
		Pricing pricing = new Pricing();
		pricing.setBuyerCd(buyerCd);
		pricing.setProductCd(productCd);
		
		int price = 0;
		try {
			price = prs.getPrice(pricing);
		} catch (Exception e) {
			System.out.println(e.getMessage());
			price = -123;
			
		}
		
		return price;
	}
	
	@RequestMapping("getPricingProductList")
	@ResponseBody
	public String[] getPricingProductList(String buyerCd) {
		System.out.println(buyerCd);
		
		List<Product> list = prs.getProductList(buyerCd);
		String[] productList = new String[list.size()];
		int i = 0;
		
		for (Product product : list) {
			String code = product.getProductCd() +"(" + product.getPname() + ")";
		
			productList[i] = code;
			i++;
		}
		
		System.out.println(Arrays.toString(productList));
		
		
		return productList;
	}
	
}




