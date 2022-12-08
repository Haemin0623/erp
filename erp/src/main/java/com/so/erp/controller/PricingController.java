package com.so.erp.controller;

import java.io.IOException;
import java.sql.Date;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.util.HSSFColor.HSSFColorPredefined;
import org.apache.poi.ss.usermodel.BorderStyle;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.FillPatternType;
import org.apache.poi.ss.usermodel.HorizontalAlignment;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.so.erp.model.OrderHead;
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
	
	
	
		@RequestMapping("pricingExcelDown")
		@ResponseBody
		public void pricingExcelDown(HttpServletResponse response, @RequestParam(name="items")String items) throws IOException {
		System.out.println("시작");
		//List<OrderHead> list = is.search(checkRow); List<OrderHead> checkRow,
		// 출력할 주문리스트
		List<Pricing> list = new ArrayList<>();
		
		Pricing pricingRow = new Pricing();
	
		try {
			JSONParser p = new JSONParser();
			Object obj = p.parse(items);
			JSONArray arr = JSONArray.fromObject(obj);
			
			System.out.println("1");
			
			Pricing pricing = new Pricing();
			
			for (int i = 0; i < arr.size(); i++) {
				
				JSONObject itemObj = (JSONObject) arr.get(i);
				String buyerCd = (String) itemObj.get("buyerCd");
				String productCd = (String) itemObj.get("productCd");
				String start = (String) itemObj.get("startdate");
				Date startdate = Date.valueOf(start);
				String end = (String) itemObj.get("enddate");
				Date enddate = Date.valueOf(end);
				
				pricing.setBuyerCd(buyerCd);
				pricing.setProductCd(productCd);
				pricing.setStartdate(startdate);
				pricing.setEnddate(enddate);
				
				System.out.println("sql전");
				pricingRow = prs.listForExcel(pricing);
				System.out.println("sql후");
				list.add(pricingRow);
			}
			
			
		} catch (ParseException e) {
			System.out.println(e.getMessage());
		}
		
		
		System.out.println("size"+list.size());
	
		
		
			
		
		
		// 워크북 생성
		Workbook wb = new XSSFWorkbook();
		Sheet sheet = wb.createSheet("판매가 리스트");
		Row row = null;
		Cell cell = null;
		int rowNo = 0;
		
		// 테이블 헤더용 스타일
		CellStyle headStyle = wb.createCellStyle();
		
		// 가는 경계선
		headStyle.setBorderTop(BorderStyle.THIN);
	    headStyle.setBorderBottom(BorderStyle.THIN);
	    headStyle.setBorderLeft(BorderStyle.THIN);
	    headStyle.setBorderRight(BorderStyle.THIN);
	
	    // 배경색 노란색
	    headStyle.setFillForegroundColor(HSSFColorPredefined.YELLOW.getIndex());
	    headStyle.setFillPattern(FillPatternType.SOLID_FOREGROUND);
	    
	    // 데이터 가운데 정렬
	    headStyle.setAlignment(HorizontalAlignment.CENTER);
	    
	    // 데이터용 경계 스타일 테두리만 지정
	    CellStyle bodyStyle = wb.createCellStyle();
	    bodyStyle.setBorderTop(BorderStyle.THIN);
	    bodyStyle.setBorderBottom(BorderStyle.THIN);
	    bodyStyle.setBorderLeft(BorderStyle.THIN);
	    bodyStyle.setBorderRight(BorderStyle.THIN);
	    
	    // 헤더 생성
	    row = sheet.createRow(rowNo++);
	    
	    cell = row.createCell(0);
	    cell.setCellStyle(headStyle);
	    cell.setCellValue("고객코드");
	    
	    cell = row.createCell(1);
	    cell.setCellStyle(headStyle);
	    cell.setCellValue("상품코드");
	    
	    cell = row.createCell(2);
	    cell.setCellStyle(headStyle);
	    cell.setCellValue("판매가");
	    
	    cell = row.createCell(3);
	    cell.setCellStyle(headStyle);
	    cell.setCellValue("계약시작일");
	    
	    cell = row.createCell(4);
	    cell.setCellStyle(headStyle);
	    cell.setCellValue("계약종료일");
	
	    cell = row.createCell(5);
	    cell.setCellStyle(headStyle);
	    cell.setCellValue("할인율");
	    
	    cell = row.createCell(6);
	    cell.setCellStyle(headStyle);
	    cell.setCellValue("최종판매가");
	    
	    cell = row.createCell(7);
	    cell.setCellStyle(headStyle);
	    cell.setCellValue("통화단위");
	    
	    cell = row.createCell(8);
	    cell.setCellStyle(headStyle);
	    cell.setCellValue("등록일");
	    
	    cell = row.createCell(9);
	    cell.setCellStyle(headStyle);
	    cell.setCellValue("상태변경일");
	    
	    
	    
	 // 데이터 부분 생성
	    for(Pricing li : list) {
	
	        row = sheet.createRow(rowNo++);
	
	        cell = row.createCell(0);
	        cell.setCellStyle(bodyStyle);
	        cell.setCellValue(li.getBuyerCd());
	        System.out.println(li.getBuyerCd());
	
	        cell = row.createCell(1);
	        cell.setCellStyle(bodyStyle);
	        cell.setCellValue(li.getProductCd());
	        System.out.println(li.getProductCd());
		    
		    cell = row.createCell(2);
		    cell.setCellStyle(bodyStyle);
		    cell.setCellValue(li.getPrice());
		    System.out.println(li.getPrice());
		    
		    cell = row.createCell(3);
		    cell.setCellStyle(bodyStyle);
		    cell.setCellValue(li.getStartdate().toString());
		    System.out.println(li.getStartdate().toString());
		    
		    cell = row.createCell(4);
		    cell.setCellStyle(bodyStyle);
		    cell.setCellValue(li.getEnddate().toString());
		    System.out.println(li.getEnddate().toString());
		    
		    cell = row.createCell(5);
		    cell.setCellStyle(bodyStyle);
		    cell.setCellValue(li.getDiscountrate());
		    System.out.println(li.getDiscountrate());
		    
		    cell = row.createCell(6);
		    cell.setCellStyle(bodyStyle);
		    cell.setCellValue(li.getPrice() * (1 - ((double)li.getDiscountrate()/100)));
		    System.out.println(li.getPrice() * (1 - ((double)li.getDiscountrate()/100)));
		    
		    cell = row.createCell(7);
		    cell.setCellStyle(bodyStyle);
		    cell.setCellValue(li.getCurrency());
		    System.out.println(li.getCurrency());
		    
		    cell = row.createCell(8);
		    cell.setCellStyle(bodyStyle);
		    cell.setCellValue(li.getAdddate().toString());
		    System.out.println(li.getAdddate().toString());
		    
		    cell = row.createCell(9);
		    cell.setCellStyle(bodyStyle);
		    cell.setCellValue(li.getStatusdate().toString());
		    System.out.println(li.getStatusdate().toString());
	
	    }
	
	    // 컨텐츠 타입과 파일명 지정
	    response.setContentType("ms-vnd/excel");
	    response.setHeader("Content-Disposition", "attachment;filename=pricing.xlsx");
	    
	    // 엑셀 출력
	    try {
	        wb.write(response.getOutputStream());
	    } finally {
	        wb.close();
	    }
	    
	    
	}
	
}




