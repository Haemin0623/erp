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

import com.so.erp.model.OrderHead;
import com.so.erp.model.PagingBean;
import com.so.erp.model.Product;
import com.so.erp.service.ProductService;

import net.sf.json.JSONObject;

@Controller
public class ProductController {

	@Autowired
	private ProductService pds;
	
	
	@RequestMapping("productList")
	public String productList(Model model, PagingBean pagingBean, String pageNum, Product product, String page) {
		int rowPerPage = 10 ; // 한 화면에 보여주는 갯수
		if (page == null || page == "") {
			rowPerPage = 10;
		}else rowPerPage = Integer.parseInt(page);
		if (pageNum == null || pageNum.equals("")) pageNum = "1";
		int currentPage = Integer.parseInt(pageNum);
		int total = pds.getTotal(pagingBean,product);
		int startRow = (currentPage - 1) * rowPerPage + 1;
		int endRow = startRow + rowPerPage - 1;
		int num = total - startRow + 1;
		pagingBean.setStartRow(startRow);
		pagingBean.setEndRow(endRow);
		List<Product> productList = pds.productList(pagingBean,product);
		PagingBean pb = new PagingBean(currentPage, rowPerPage, total);
		model.addAttribute("productList",productList);
		model.addAttribute("num",num);
		model.addAttribute("pb",pb);
		model.addAttribute("product",product);
		model.addAttribute("rowPerPage",rowPerPage);
		
		return "nolay/productList";
	}
	
	@RequestMapping("productDelete")
	@ResponseBody
	public int productDelete(@RequestParam(name="checkRows")List<String> checkRows){
		int result = 0;
			for (int i= 0; i < checkRows.size(); i++) {
				String productCd = checkRows.get(i);
				result = pds.checkRowDelete(productCd);			
				}
		return result;
	}
	
	@RequestMapping("productInsert")
	@ResponseBody
	public int productInsert(@RequestParam(name="items")String item) throws ParseException{
		int result = 0;
		JSONParser p = new JSONParser();
		Object obj =  p.parse(item);
		JSONObject productObj = JSONObject.fromObject(obj);
		
		Product product = new Product();
		String category = (String) productObj.get("category");
		String productCd = (String) productObj.get("productCd");
		String pname = (String) productObj.get("pname");
		String volume = (String) productObj.get("volume");
		String unit = (String) productObj.get("unit");
		
		product.setProductCd(productCd);
		product.setCategory(category);
		product.setPname(pname);
		product.setVolume(volume);
		product.setUnit(unit);
		
		
		
		result = pds.insert(product);
		return result;
	}
	
	@RequestMapping("codeMix")
	@ResponseBody
	public String codeMix(@RequestParam(name="category")String codeMix) throws ParseException{
		String code1= "";
		String code2= "";
		if(codeMix.equals("스낵")) {
			code1 = "SN";
			code2 = pds.selectCode(codeMix);
			
		}else if(codeMix.equals("라면")){
			code1 = "RA";
			code2 = pds.selectCode(codeMix);
		}else {
			code1 = "DR";
			code2 = pds.selectCode(codeMix);
		}
		
		return code1+code2;
	}
	
	@RequestMapping("productUpdate") 
	@ResponseBody
	public int productUpdate(Product product) {
		int result = 0;
		result = pds.update(product);
		
		return result;
	}
	
	
	@RequestMapping("productSearch")
	public String productSearch(@RequestParam(name="keyword")String keyword, PagingBean pagingBean, Model model ){
		System.out.println("1");
		
		try {
			JSONParser p = new JSONParser();
			Object obj = p.parse(keyword);
			JSONObject keywordObj = JSONObject.fromObject(obj);
			
			Product product = new Product();
			String productCd = (String) keywordObj.get("productCd");
			product.setProductCd(productCd);
			String pname = (String) keywordObj.get("pname");
			product.setPname(pname);
			String volume = (String) keywordObj.get("volume");
			product.setVolume(volume);
			String category = (String) keywordObj.get("category");
			product.setCategory(category);
					
			System.out.println("2");
			
			String adddate = (String) keywordObj.get("adddate");
			if (adddate != null && !adddate.equals("") ) {
				Date date = Date.valueOf(adddate);
				product.setAdddate(date);
			}

			System.out.println("3");
			
			String adddate2 = (String) keywordObj.get("adddate2");
			if (adddate2 != null && !adddate2.equals("") ) {
				Date date = Date.valueOf(adddate2);
				product.setAdddate2(date);
			}
			
			System.out.println("4");
			
			String del = (String) keywordObj.get("del");
			product.setDel(del);
			
			// item 검색
			System.out.println(product.getCategory());
			System.out.println(product.getDel());
			System.out.println(product.getPname());
			System.out.println(product.getProductCd());
			System.out.println(product.getVolume());
			System.out.println(product.getAdddate());
			System.out.println(product.getAdddate2());
			List<Product> productList = pds.productList(pagingBean,product);
			System.out.println(productList.size());
			
			
			model.addAttribute("productList", productList);
			
		} catch (ParseException e) {
			System.out.println(e.getMessage());
		}
			return "nolay/productList";
	}
}
