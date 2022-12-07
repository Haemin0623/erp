package com.so.erp.controller;

import java.sql.Date;
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
	public String pricing(Model model, Pricing pricing) {
		
		int rowPerPage = 10 ;
		
		if (pricing.getRowPerPage() != 0) {
			rowPerPage = pricing.getRowPerPage();
		} 
		if (pricing.getPageNum() == null || pricing.getPageNum().equals("")) {
			pricing.setPageNum("1");
		}
		pricing.setDel("N");		
		pricing.setSortBuyerCd(0);
		pricing.setSortProductCd(0);
		pricing.setSortPrice(0);
		pricing.setSortStartdate(0);
		pricing.setSortEnddate(0);
		pricing.setSortDiscountrate(0);
		pricing.setSortFinalPrice(0);
		pricing.setSortAdddate(1);
		pricing.setSortStatusdate(0);
		
		int currentPage = Integer.parseInt(pricing.getPageNum());
		int total = prs.getTotal(pricing);
		
		pricing.pagingBean(currentPage, rowPerPage, total);
		
		int startRow = (currentPage - 1) * rowPerPage + 1;
		int endRow = startRow + rowPerPage - 1;
		pricing.setStartRow(startRow);
		pricing.setEndRow(endRow);
		
		List<Pricing> pricingList = new ArrayList<Pricing>();
		pricingList = prs.pricingList(pricing);
		
		for (Pricing pricing1 : pricingList) {
			pricing1.setFinalPrice(pricing1.getPrice() * (1 - ((double)pricing1.getDiscountrate()/100)));
		}
		
		model.addAttribute("pricingList", pricingList);
		return "nolay/pricing";
	}
	
	
	@RequestMapping("pricingSearch")
	public String pricingSearch(Model model, String keyword, Pricing pricing) {
		
		try {
			
			JSONParser p = new JSONParser();
			Object obj = p.parse(keyword);
			JSONObject keywordObj = JSONObject.fromObject(obj);
			
			String buyerCd = (String) keywordObj.get("buyerCd");
			pricing.setBuyerCd(buyerCd);
			
			String productCd = (String) keywordObj.get("productCd");
			pricing.setProductCd(productCd);
			
			int startPrice = Integer.valueOf((String)keywordObj.get("startPrice"));
			pricing.setStartPrice(startPrice);
		
			int endPrice = Integer.valueOf((String)keywordObj.get("endPrice"));
			pricing.setEndPrice(endPrice);
	
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
			
			int sortBuyerCd = Integer.valueOf((String) keywordObj.get("sortBuyerCd"));
			pricing.setSortBuyerCd(sortBuyerCd);
			int sortProductCd = Integer.valueOf((String) keywordObj.get("sortProductCd"));
			pricing.setSortProductCd(sortProductCd);
			int sortPrice = Integer.valueOf((String) keywordObj.get("sortPrice"));
			pricing.setSortPrice(sortPrice);
			int sortStartdate = Integer.valueOf((String) keywordObj.get("sortStartdate"));
			pricing.setSortStartdate(sortStartdate);
			int sortEnddate = Integer.valueOf((String) keywordObj.get("sortEnddate"));
			pricing.setSortEnddate(sortEnddate);
			int sortDiscountrate = Integer.valueOf((String) keywordObj.get("sortDiscountrate"));
			pricing.setSortDiscountrate(sortDiscountrate);
			int sortFinalPrice = Integer.valueOf((String) keywordObj.get("sortFinalPrice"));
			pricing.setSortFinalPrice(sortFinalPrice);
			int sortCurrency = Integer.valueOf((String) keywordObj.get("sortCurrency"));
			pricing.setSortCurrency(sortCurrency);
			int sortAdddate = Integer.valueOf((String) keywordObj.get("sortAdddate"));
			pricing.setSortAdddate(sortAdddate);
			int sortStatusdate = Integer.valueOf((String) keywordObj.get("sortStatusdate"));
			pricing.setSortStatusdate(sortStatusdate);
			
			int rowPerPage = Integer.valueOf((String) keywordObj.get("rowPerPage"));
			int currentPage = Integer.valueOf((String) keywordObj.get("currentPage"));
			int total = prs.getTotal(pricing);
			
			pricing.pagingBean(currentPage, rowPerPage, total);
			
			int startRow = (currentPage - 1) * rowPerPage + 1;
			int endRow = startRow + rowPerPage - 1;
			pricing.setStartRow(startRow);
			pricing.setEndRow(endRow);
			
			
			List<Pricing> searchList = prs.search(pricing);
			
			
			for (Pricing pricing1 : searchList) {
				pricing1.setFinalPrice(pricing1.getPrice() * (1 - ((double)pricing1.getDiscountrate()/100)));
			}
			
			model.addAttribute("pricingList", searchList);
			
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
				
				pricing.setBuyerCd(buyerCd);
				pricing.setProductCd(productCd);
				pricing.setStartdate(startdate);
				pricing.setEnddate(enddate);
				
				prs.pricingDelete(pricing);
			}
		result = 1;
		return result;
	}
	
	
	@RequestMapping("pricingRestore")
	@ResponseBody
	public int pricingRestore(@RequestParam(name="checkRows")String[] arr, Pricing pricing) throws java.text.ParseException{
		
		int result = 0;
			for (String i : arr) {
				String[] a = i.split("&");
				String buyerCd = a[0];
				String productCd = a[1];
				
				Date startdate = Date.valueOf(a[2]);
				Date enddate = Date.valueOf(a[3]);
				
				pricing.setBuyerCd(buyerCd);
				pricing.setProductCd(productCd);
				pricing.setStartdate(startdate);
				pricing.setEnddate(enddate);
				
				prs.pricingRestore(pricing);
			}
		result = 1;
		return result;
	}
	
	
	@RequestMapping("pricingInsert")
	@ResponseBody
	public boolean pricingInsert(Model model, @RequestParam(name="items")String items) throws ParseException {		
		
		boolean result = false;
		
		try {
			System.out.println(12);
			JSONParser p = new JSONParser();
			Object obj = p.parse(items);
			JSONArray arr = JSONArray.fromObject(obj);
			
			Pricing pricing = new Pricing(); 
			System.out.println(222);
			for (int i = 0; i < arr.size(); i++) {
				System.out.println(333);
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
				
				
				System.out.println("전");
				prs.pricingInsert(pricing);
				result = true;
			}
		
		} catch (Exception e) {
			System.out.println(e.getMessage());
			System.out.println(13);
			result = false;
		}
		System.out.println(14);
		return result;
	}
	
	@RequestMapping("overlapCheck")
	@ResponseBody
	public int overlapCheck(Pricing pricing) {
		int result = 0;
		result = prs.overlapCheck(pricing);

		return result;
	}
	
	@RequestMapping("pricingUpdate")
	@ResponseBody
	public int pricingUpdate(Pricing pricing) {
		System.out.println(pricing);
		int result = 0;
		
		result = prs.pricingUpdate(pricing);
		System.out.println(result);
		return result;
	}
	
	@RequestMapping("getPrice")
	@ResponseBody
	public int getPrice(String buyerCd, String productCd) {
		
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




