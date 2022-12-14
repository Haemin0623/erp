package com.so.erp.controller;

import java.io.IOException;
import java.util.ArrayList;
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

import com.so.erp.model.Buyer;
import com.so.erp.model.Country;
import com.so.erp.model.Employee;
import com.so.erp.model.Product;
import com.so.erp.service.BuyerService;
import com.so.erp.service.CountryService;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

@Controller
public class BuyerController {

	@Autowired
	private BuyerService bs;
	@Autowired
	private CountryService cs;

	public void exData(Model model) {
		List<Buyer> buyerEx = bs.list();
		model.addAttribute("buyerEx", buyerEx);
		
		List<Country> countryEx = cs.list();
		model.addAttribute("countryEx", countryEx);
	}
	
	@RequestMapping("buyer")
	public String buyer(Model model, Buyer buyer) {
		
		int rowPerPage = 20 ;
		
		if (buyer.getRowPerPage() != 0) {
			rowPerPage = buyer.getRowPerPage();
		} 
		if (buyer.getPageNum() == null || buyer.getPageNum().equals("")) {
			buyer.setPageNum("1");
		}
		
		buyer.setDel("N");
		
		int currentPage = Integer.parseInt(buyer.getPageNum());
		int total = bs.getTotal(buyer);
		
		buyer.pagingBean(currentPage, rowPerPage, total);
		int startRow = (currentPage - 1) * rowPerPage + 1;
		int endRow = startRow + rowPerPage - 1;
		buyer.setStartRow(startRow);
		buyer.setEndRow(endRow);
		
		buyer.setSortBuyerCd(0);
		buyer.setSortBname(0);
		buyer.setSortManager(0);
		buyer.setSortTel(0);
		buyer.setSortEmail(0);
		buyer.setSortAddress(0);
		buyer.setSortCountryCd(0);
		buyer.setSortAdddate(1);
		buyer.setSortStatusDate(0);		
		
		List<Buyer> buyerList = bs.search(buyer);
		List<Country> countryCdList = cs.list();
		model.addAttribute("buyerList", buyerList);
		model.addAttribute("countryCdList", countryCdList);
		
		exData(model);
		
		return "nolay/buyer"; // head??? ???????????? ????????? ??? ??????
		
	}
	
//	//???????????? ????????????
//	@RequestMapping(value = "dupChk", produces = "text/html;charset=utf-8")
//	@ResponseBody //jsp??? ???????????? ?????? ????????? ??????
//	public String dupChk(String buyerCd, Model model) {
//		String msg = "";
//		Buyer buyer = bs.select(buyerCd);
//		if(buyer == null) {
//			msg = "??? ?????? ????????? ????????????";
//		}else {
//			msg = "??? ?????? ???????????? ????????????";
//		}
//		return msg;
//	}
	
	//???????????? ????????????
	@RequestMapping(value = "dupChk2", produces = "text/html;charset=utf-8")
	@ResponseBody
	public String dupChk2(String bname, Model model) {
		String msg = "";
		Buyer buyer = bs.select(bname);
		if(buyer == null) {
			msg = "??? ?????? ????????? ?????????";
		}else {
			msg = "??? ?????? ???????????? ?????????";
		}
		return msg;
	}
	
	@RequestMapping("buyerInsert")
	// view ???????????? ?????? ????????? ????????? return ?????? ?????? ??? ??????
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
	
	@RequestMapping("autoCompleteCd")
	@ResponseBody
	//????????? category?????? ???????????? ?????? autoCompleteCd ?????? ???????????????(???????????? ??????)
	public String autoCompleteCd(@RequestParam(name="category") String autoCompleteCd) throws ParseException {
		String code1 = "";
		String code2 = "";
		if(autoCompleteCd.equals("FOD")) {
			code1 = "FOD";
			code2 = bs.selectCode(autoCompleteCd);
		} else if(autoCompleteCd.equals("MAT")) {
			code1 = "MAT";
			code2 = bs.selectCode(autoCompleteCd);
		} else if(autoCompleteCd.equals("CVS")) {
			code1 = "CVS";
			code2 = bs.selectCode(autoCompleteCd);
		} else {
			code1 = "ETC";
			code2 = bs.selectCode(autoCompleteCd);
		}
		return code1+code2;
	}
	
	
	
	@RequestMapping("buyerDelete")
	@ResponseBody
	//????????? delBuyer(???)s?????? ???????????? ?????? delBuyers(?????????)?????? ???????????????(???????????? ??????)
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
	// ajax ??? ????????? ????????? buyer??? ??????
	public int buyerUpdate(Buyer buyer) {
		int result=0;
		result = bs.update(buyer);
		return result;
	}
	
	@RequestMapping("buyerSearch")
	public String buyerSearch(Model model, @RequestParam(name="keyword") String keyword) {
		
		exData(model);
		try {
			
			JSONParser p = new JSONParser();
			Object obj = p.parse(keyword);
			JSONObject keywordObj = JSONObject.fromObject(obj);
			
			Buyer buyer = new Buyer();
			String buyerCd = (String) keywordObj.get("buyerCd"); //????????????
			buyer.setBuyerCd(buyerCd);
			
			String manager = (String) keywordObj.get("manager"); //?????????
			buyer.setManager(manager);
			String countryCd = (String) keywordObj.get("countryCd"); //????????????
			buyer.setCountryCd(countryCd);
			
			String tel = (String) keywordObj.get("tel"); //????????????
			buyer.setTel(tel);
			String email = (String) keywordObj.get("email"); //?????????
			buyer.setEmail(email);
			String address = (String) keywordObj.get("address"); //??????
			buyer.setAddress(address);
			
			String del = (String) keywordObj.get("del");
			buyer.setDel(del);
			
			int sortBuyerCd = Integer.valueOf((String) keywordObj.get("sortBuyerCd"));
			buyer.setSortBuyerCd(sortBuyerCd);
			int sortBname = Integer.valueOf((String) keywordObj.get("sortBname"));
			buyer.setSortBname(sortBname);
			int sortManager = Integer.valueOf((String) keywordObj.get("sortManager"));
			buyer.setSortManager(sortManager);
			int sortTel = Integer.valueOf((String) keywordObj.get("sortTel"));
			buyer.setSortTel(sortTel);
			int sortEmail = Integer.valueOf((String) keywordObj.get("sortEmail"));
			buyer.setSortEmail(sortEmail);
			int sortAddress = Integer.valueOf((String) keywordObj.get("sortAddress"));
			buyer.setSortAddress(sortAddress);
			int sortCountryCd = Integer.valueOf((String) keywordObj.get("sortCountryCd"));
			buyer.setSortCountryCd(sortCountryCd);
			int sortAdddate = Integer.valueOf((String) keywordObj.get("sortAdddate"));
			buyer.setSortAdddate(sortAdddate);
			int sortStatusDate = Integer.valueOf((String) keywordObj.get("sortStatusDate"));
			buyer.setSortStatusDate(sortStatusDate);
			
			
			int rowPerPage = Integer.valueOf((String) keywordObj.get("rowPerPage"));
			int currentPage = Integer.valueOf((String) keywordObj.get("currentPage"));
			int total = bs.getTotal(buyer);
			
			buyer.pagingBean(currentPage, rowPerPage, total);
			
			int startRow = (currentPage - 1) * rowPerPage + 1;
			int endRow = startRow + rowPerPage - 1;
			buyer.setStartRow(startRow);
			buyer.setEndRow(endRow);
			

			// buyer????????? ????????? search ????????? bsearchList ??? ??????
			// buyer ???????????? ????????? buyer.do??? buyerList ??? ?????? ???????????? ???????????????.
			// ????????? ?????? bsearchList ??????  key??? buyerList??? ????????? ???????????? ???????????? ?????? ??????????????????
			List<Buyer> bsearchList = bs.search(buyer);
			List <Buyer> notDelList = bs.ndlist();
			List <Buyer> delList = bs.dlist();
			
			model.addAttribute("buyerList", bsearchList); // bsearchList??? buyerList ???????????? ?????????
			model.addAttribute("buyer", buyer);
			model.addAttribute("notDelList", notDelList);
			model.addAttribute("delList", delList);
			
		} catch (ParseException e) {
			System.out.println(e.getMessage());
		}
		return "nolay/buyer";
	}
	
	@RequestMapping("buyerRestore")
	@ResponseBody
	public boolean buyerRestore(String[] checkRows) {
		boolean result = true;
		
		for (String buyerCd: checkRows){
			try {
				bs.buyerRestore(buyerCd);
			} catch (Exception e) {
				System.out.println("?????? : " + buyerCd);
				result = false;
			}			
		}
		return result;
	}
	
	@RequestMapping("buyerExcelDown")
	@ResponseBody
	public void orderExcelDown(HttpServletResponse response, @RequestParam(name = "items") String items)
			throws IOException {
		List<Buyer> list = new ArrayList<>();
		System.out.println(items);

		Buyer buyerRow = new Buyer();

		try {
			JSONParser p = new JSONParser();
			Object obj = p.parse(items);
			JSONArray arr = JSONArray.fromObject(obj);

			System.out.println("1");

			Buyer item = new Buyer();

			for (int i = 0; i < arr.size(); i++) {

				JSONObject itemObj = (JSONObject) arr.get(i);
				String buyerCd = (String) itemObj.get("buyerCd");
				System.out.println(buyerCd);

				item.setBuyerCd(buyerCd);

				System.out.println("sql???");
				buyerRow = bs.listForExcel(item);
				System.out.println("sql???");
				list.add(buyerRow);
			}

		} catch (ParseException e) {
			System.out.println(e.getMessage());
		}

		System.out.println("size" + list.size());

		// ????????? ??????
		Workbook wb = new XSSFWorkbook();
		Sheet sheet = wb.createSheet("??????");
		Row row = null;
		Cell cell = null;
		int rowNo = 0;

		// ????????? ????????? ?????????
		CellStyle headStyle = wb.createCellStyle();

		// ?????? ?????????
		headStyle.setBorderTop(BorderStyle.THIN);
		headStyle.setBorderBottom(BorderStyle.THIN);
		headStyle.setBorderLeft(BorderStyle.THIN);
		headStyle.setBorderRight(BorderStyle.THIN);

		// ????????? ?????????
		headStyle.setFillForegroundColor(HSSFColorPredefined.YELLOW.getIndex());
		headStyle.setFillPattern(FillPatternType.SOLID_FOREGROUND);

		// ????????? ????????? ??????
		headStyle.setAlignment(HorizontalAlignment.CENTER);

		// ???????????? ?????? ????????? ???????????? ??????
		CellStyle bodyStyle = wb.createCellStyle();
		bodyStyle.setBorderTop(BorderStyle.THIN);
		bodyStyle.setBorderBottom(BorderStyle.THIN);
		bodyStyle.setBorderLeft(BorderStyle.THIN);
		bodyStyle.setBorderRight(BorderStyle.THIN);

		// ?????? ??????
		row = sheet.createRow(rowNo++);

		cell = row.createCell(0);
		cell.setCellStyle(headStyle);
		cell.setCellValue("????????????");

		cell = row.createCell(1);
		cell.setCellStyle(headStyle);
		cell.setCellValue("?????????");
		
		cell = row.createCell(2);
		cell.setCellStyle(headStyle);
		cell.setCellValue("?????????");

		cell = row.createCell(3);
		cell.setCellStyle(headStyle);
		cell.setCellValue("????????????");

		cell = row.createCell(4);
		cell.setCellStyle(headStyle);
		cell.setCellValue("?????????");

		cell = row.createCell(5);
		cell.setCellStyle(headStyle);
		cell.setCellValue("??????");

		cell = row.createCell(6);
		cell.setCellStyle(headStyle);
		cell.setCellValue("????????????");

		cell = row.createCell(7);
		cell.setCellStyle(headStyle);
		cell.setCellValue("?????????");

		cell = row.createCell(8);
		cell.setCellStyle(headStyle);
		cell.setCellValue("???????????????");

		
		// ????????? ?????? ??????
		for (Buyer bl : list) {

			row = sheet.createRow(rowNo++);

			cell = row.createCell(0);
			cell.setCellStyle(bodyStyle);
			cell.setCellValue(bl.getBuyerCd());
			System.out.println(bl.getBuyerCd()); 
			
			cell = row.createCell(1);
			cell.setCellStyle(bodyStyle);
			cell.setCellValue(bl.getBname());
			System.out.println(bl.getBname());
			
			cell = row.createCell(2);
			cell.setCellStyle(bodyStyle);
			cell.setCellValue(bl.getManager());
			System.out.println(bl.getManager());

			cell = row.createCell(3);
			cell.setCellStyle(bodyStyle);
			cell.setCellValue(bl.getTel());
			System.out.println(bl.getTel());

			cell = row.createCell(4);
			cell.setCellStyle(bodyStyle);
			cell.setCellValue(bl.getEmail());
			System.out.println(bl.getEmail());

			cell = row.createCell(5);
			cell.setCellStyle(bodyStyle);
			cell.setCellValue(bl.getAddress());
			System.out.println(bl.getAddress());

			cell = row.createCell(6);
			cell.setCellStyle(bodyStyle);
			cell.setCellValue(bl.getCountryCd());
			System.out.println(bl.getCountryCd());

			cell = row.createCell(7);
			cell.setCellStyle(bodyStyle);
			cell.setCellValue(bl.getAdddate().toString());
			System.out.println(bl.getAdddate().toString());

			cell = row.createCell(8);
			cell.setCellStyle(bodyStyle);
			if (bl.getStatusdate() != null) {
				cell.setCellValue(bl.getStatusdate().toString());
			}else {
				cell.setCellValue(bl.getStatusdate());
			}
			
		}
		// ????????? ????????? ????????? ??????
		response.setContentType("ms-vnd/excel");
		response.setHeader("Content-Disposition", "attachment;filename=order.xlsx");
		// ?????? ??????
		try {
			wb.write(response.getOutputStream());
		} finally {
			wb.close();
		}
	}


}

