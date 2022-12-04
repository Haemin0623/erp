package com.so.erp.controller;

import java.io.IOException;
import java.sql.Date;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.hssf.util.HSSFColor.HSSFColorPredefined;
import org.apache.poi.ss.usermodel.BorderStyle;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.FillPatternType;
import org.apache.poi.ss.usermodel.HorizontalAlignment;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
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
import com.so.erp.model.OrderHead;
import com.so.erp.model.OrderItem;
import com.so.erp.model.PagingBean;
import com.so.erp.model.Product;
import com.so.erp.service.BuyerService;
import com.so.erp.service.CountryService;
import com.so.erp.service.EmployeeService;
import com.so.erp.service.OrderHeadService;
import com.so.erp.service.OrderItemService;
import com.so.erp.service.ProductService;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

@Controller
public class OrderController {

	@Autowired
	private OrderHeadService hs;
	@Autowired
	private OrderItemService is;
	@Autowired
	private CountryService cs;
	@Autowired
	private EmployeeService es;
	@Autowired
	private ProductService ps;
	@Autowired
	private BuyerService bs;
	
	public void exData(Model model) {
		List<Buyer> buyerEx = bs.list();
		model.addAttribute("buyerEx", buyerEx);
		
		List<Employee> employeeEx = es.list();
		model.addAttribute("employeeEx", employeeEx);
		
		List<Product> productEx = ps.list();
		model.addAttribute("productEx", productEx);
	}
	
	@RequestMapping("order")
	public String order(Model model, OrderHead orderHead, OrderItem orderItem) {
		
		int rowPerPage = 10 ;
		
		if (orderHead.getRowPerPage() != 0) {
			rowPerPage = orderHead.getRowPerPage();
		} 
		if (orderHead.getPageNum() == null || orderHead.getPageNum().equals("")) {
			orderHead.setPageNum("1");
		}
		
		orderHead.setDel("N");		
		orderHead.setSortOrderNo(0);
		orderHead.setSortBuyerCd(0);
		orderHead.setSortOrderDate(1);
		orderHead.setSortEmployeeCd(0);
		orderHead.setSortStatus(0);
		orderHead.setSortStatusDate(0);
		
		int currentPage = Integer.parseInt(orderHead.getPageNum());
		int total = hs.getTotal(orderHead);
		
		orderHead.pagingBean(currentPage, rowPerPage, total);
		
		int startRow = (currentPage - 1) * rowPerPage + 1;
		int endRow = startRow + rowPerPage - 1;
		orderHead.setStartRow(startRow);
		orderHead.setEndRow(endRow);
		
		
		List<OrderHead> headList = hs.search(orderHead);
		
		exData(model);
		
		model.addAttribute("headList", headList);
		model.addAttribute("orderHead", orderHead);
		
		return "nolay/order";
	}
	
	@RequestMapping("orderSearch")
	public String orderSearch(Model model, @RequestParam(name="keyword") String keyword) {
		
		exData(model);
		
		System.out.println("1");
		String window = null;
		
		try {
			
			JSONParser p = new JSONParser();
			Object obj = p.parse(keyword);
			JSONObject keywordObj = JSONObject.fromObject(obj);
			
			window = keywordObj.getString("window");
			System.out.println(window);
			
			OrderHead orderHead = new OrderHead();
			String orderNo = (String) keywordObj.get("orderNo");
			orderHead.setOrderNo(orderNo);
			String buyerCd = (String) keywordObj.get("buyerCd");
			orderHead.setBuyerCd(buyerCd);
			
			System.out.println("2");
			
			String orderFromDate = (String) keywordObj.get("orderFromDate");
			if (orderFromDate != null && !orderFromDate.equals("") ) {
				Date date = Date.valueOf(orderFromDate);
				orderHead.setOrderFromDate(date);
			}

			System.out.println("3");
			
			String orderToDate = (String) keywordObj.get("orderToDate");
			if (orderToDate != null && !orderToDate.equals("") ) {
				Date date = Date.valueOf(orderToDate);
				orderHead.setOrderToDate(date);
			}
			
			System.out.println("4");
			
			String employeeCd = (String) keywordObj.get("employeeCd");
			orderHead.setEmployeeCd(employeeCd);
			String status = (String) keywordObj.get("status");
			orderHead.setStatus(status);
			
			String del = (String) keywordObj.get("del");
			orderHead.setDel(del);
			System.out.println(orderHead.getDel());
			
			// item 검색
			String productCd = (String) keywordObj.get("productCd");
			
			System.out.println(productCd);
			
			orderHead.setProductCd(productCd);
			String requestFromDate = (String) keywordObj.get("requestFromDate");
			if (requestFromDate != null && !requestFromDate.equals("") ) {
				Date date = Date.valueOf(requestFromDate);
				orderHead.setRequestFromDate(date);
			}
			System.out.println(orderHead.getRequestFromDate());
			String requestToDate = (String) keywordObj.get("requestToDate");
			if (requestToDate != null && !requestToDate.equals("") ) {
				Date date = Date.valueOf(requestToDate);
				orderHead.setRequestToDate(date);
			}
			System.out.println(orderHead.getRequestToDate());
			
			int sortOrderNo = Integer.valueOf((String) keywordObj.get("sortOrderNo"));
			orderHead.setSortOrderNo(sortOrderNo);
			int sortBuyerCd = Integer.valueOf((String) keywordObj.get("sortBuyerCd"));
			orderHead.setSortBuyerCd(sortBuyerCd);
			int sortOrderDate = Integer.valueOf((String) keywordObj.get("sortOrderDate"));
			orderHead.setSortOrderDate(sortOrderDate);
			int sortEmployeeCd = Integer.valueOf((String) keywordObj.get("sortEmployeeCd"));
			orderHead.setSortEmployeeCd(sortEmployeeCd);
			int sortStatus = Integer.valueOf((String) keywordObj.get("sortStatus"));
			orderHead.setSortStatus(sortStatus);
			int sortStatusDate = Integer.valueOf((String) keywordObj.get("sortStatusDate"));
			orderHead.setSortStatusDate(sortStatusDate);
			
			
			int rowPerPage = Integer.valueOf((String) keywordObj.get("rowPerPage"));
			int currentPage = Integer.valueOf((String) keywordObj.get("currentPage"));
			int total = hs.getTotal(orderHead);
			
			orderHead.pagingBean(currentPage, rowPerPage, total);
			
			int startRow = (currentPage - 1) * rowPerPage + 1;
			int endRow = startRow + rowPerPage - 1;
			orderHead.setStartRow(startRow);
			orderHead.setEndRow(endRow);
			
			
			List<OrderHead> headList = hs.search(orderHead);
			System.out.println(headList.size());
			
			for (OrderHead oh : headList) {
				System.out.println(oh.toString());
			}
			
			model.addAttribute("headList", headList);
			model.addAttribute("orderHead", orderHead);
			
			System.out.println(orderHead.getStatus());
		} catch (ParseException e) {
			System.out.println(e.getMessage());
		}
		
		System.out.println(window);
		
		if (window.equals("주문관리")) {
			return "nolay/order";
			
		} else if (window.equals("주문승인")) {
			return "nolay/orderApprovalWindow";
			
		} else {
			return window;
		}
		
	}
	
	
	@RequestMapping("orderInsert")
	@ResponseBody
	public boolean orderInsert(Model model, @RequestParam(name="head")String head, @RequestParam(name="items")String items) throws ParseException {		
		
		boolean result = true;
		
		try {
			
			JSONParser p = new JSONParser();
			Object obj =  p.parse(head);
			JSONObject headObj = JSONObject.fromObject(obj);
			
			System.out.println(headObj.toString());
			OrderHead orderHead = new OrderHead();
			String orderNo = (String) headObj.get("orderNo");
			System.out.println("1");
			String buyerCd = (String) headObj.get("buyerCd");
			System.out.println("2");
			String date = (String) headObj.get("orderdate");
			Date orderdate = Date.valueOf(date);
			System.out.println(orderdate);
			orderHead.setOrderNo(orderNo);
			orderHead.setBuyerCd(buyerCd);
			orderHead.setOrderdate(orderdate);
			
			//세션에서 직원 아이디 받아와야 할듯.
			orderHead.setEmployeeCd("SAL005");
			
			System.out.println("헤드 삽입");
			hs.insert(orderHead);
			System.out.println("헤드 삽입완");

			obj = p.parse(items);
			JSONArray arr = JSONArray.fromObject(obj);
			
			System.out.println("맵핑");
			
			OrderItem item = new OrderItem(); 
			
			for (int i = 0; i < arr.size(); i++) {
				
				JSONObject itemObj = (JSONObject) arr.get(i);

				
				String productCd = (String) itemObj.get("productCd");
				System.out.println(productCd);
				int requestqty = Integer.parseInt((String) itemObj.get("requestqty"));
				System.out.println(requestqty);
				int price = Integer.parseInt((String) itemObj.get("price"));
				System.out.println(price);
				int amount = Integer.parseInt((String) itemObj.get("amount"));
				System.out.println(amount);
				String rdate = (String) itemObj.get("requestdate");
				Date requestdate = Date.valueOf(rdate);
				System.out.println(requestdate);
				String remark = (String) itemObj.get("remark");
				System.out.println(remark);
				
				
				item.setOrderNo(orderNo);
				item.setProductCd(productCd);
				item.setRequestqty(requestqty);
				item.setRequestdate(requestdate);
				item.setPrice(price);
				item.setAmount(amount);
				item.setRemark(remark);
				
				System.out.println("전");
				
				is.insert(item);
				System.out.println("후");
			}
		
		} catch (Exception e) {
			System.out.println(e.getMessage());
			result = false;
		}
		
		return result;

	}


	@RequestMapping("orderStatus")
	public String orderStatus(Model model, OrderHead orderHead, OrderItem orderItem) {
		
		List<Product> productList = ps.list();
		
		List<Buyer> buyerList = bs.list();
		List<Country> countryList = cs.list();
		List<Employee> empList = es.list();
	//	List<OrderItem> orderStatusList = is.orderStatusList();
		List<OrderHead> orderStatusList = is.search(orderHead);
		
		model.addAttribute("productList", productList);
		
		model.addAttribute("buyerList", buyerList);
		model.addAttribute("countryList", countryList);
		model.addAttribute("empList", empList);
		model.addAttribute("orderStatusList", orderStatusList);
		
		return "nolay/orderStatus";
	}
	
	@RequestMapping("orderApprovalWindow")
	public String orderApprovalWindow(Model model) {
		
		List<OrderHead> headList = hs.headEmpList();	// head, employee
		
		model.addAttribute("headList", headList);
		
		return "nolay/orderApprovalWindow";
	}
	
	@RequestMapping("orderItemList")
	public @ResponseBody List<OrderItem> orderItemList(Model model, @RequestParam(name="orderNo")String orderNo) {
		System.out.println(orderNo);
		System.out.println("넘어오나~");
		
		List<OrderItem> itemList = is.itemList(orderNo);
		
		return itemList;
	}
	
	@RequestMapping("orderApproval")
	@ResponseBody
	public boolean orderApproval(Model model, @RequestParam(name="orderNo")String orderNo, 
			@RequestParam(name="reason")String reason, @RequestParam(name="btnValue")String btnValue) {
		System.out.println("orderApproval controller");
		
		boolean result = true;
		
		OrderHead orderHead = new OrderHead();
		orderHead.setOrderNo(orderNo);
		orderHead.setReason(reason);
		orderHead.setStatus(btnValue);	// 승인버튼 누르면 승인으로, 반려버튼 누르면 반려로
		
		System.out.println("orderNo"+orderHead.getOrderNo());
		System.out.println("raseon"+orderHead.getReason());
		System.out.println("btnValue"+orderHead.getStatus());
		
		try {
			hs.orderApproval(orderHead);
			System.out.println("되나요");
			result = true;
		} catch (Exception e) {
			System.out.println("에러"+e.getMessage());
			result = false;
		}
		return result;
	}
	
	@RequestMapping("approvalRequest")
	@ResponseBody
	public int approvalRequest(String orderNo) {
		
		System.out.println(orderNo);
		
		int result = hs.approvalRequest(orderNo);
		
		return result;
	}
	
	@RequestMapping("approvalCancel")
	@ResponseBody
	public int approvalCancel(String orderNo) {
		
		System.out.println(orderNo);
		
		int result = hs.approvalCancel(orderNo);
		
		return result;
	}
	@RequestMapping("orderSearch2")
	public String orderSearch2(Model model, @RequestParam(name="keyword") String keyword) {
		
		System.out.println("1");
		
		try {
			
			JSONParser p = new JSONParser();
			Object obj = p.parse(keyword);
			JSONObject keywordObj = JSONObject.fromObject(obj);
			
			
			OrderHead orderHead = new OrderHead();
			String orderNo = (String) keywordObj.get("orderNo");
			orderHead.setOrderNo(orderNo);
			String buyerCd = (String) keywordObj.get("buyerCd");
			orderHead.setBuyerCd(buyerCd);
			System.out.println(buyerCd);
			
			System.out.println("2");
			
			String orderFromDate = (String) keywordObj.get("orderFromDate");
			if (orderFromDate != null && !orderFromDate.equals("") ) {
				Date date = Date.valueOf(orderFromDate);
				orderHead.setOrderFromDate(date);
			}

			System.out.println("3");
			
			String orderToDate = (String) keywordObj.get("orderToDate");
			if (orderToDate != null && !orderToDate.equals("") ) {
				Date date = Date.valueOf(orderToDate);
				orderHead.setOrderToDate(date);
			}
			
			System.out.println("4");
			
			String employeeCd = (String) keywordObj.get("employeeCd");
			orderHead.setEmployeeCd(employeeCd);
			
			String status = (String) keywordObj.get("status");
			orderHead.setStatus(status);
			
			// item 검색
			String productCd = (String) keywordObj.get("productCd");
			
			System.out.println(productCd);
			
			orderHead.setProductCd(productCd);
			String requestFromDate = (String) keywordObj.get("requestFromDate");
			if (requestFromDate != null && !requestFromDate.equals("") ) {
				Date date = Date.valueOf(requestFromDate);
				orderHead.setRequestFromDate(date);
			}
			System.out.println(orderHead.getRequestFromDate());
			String requestToDate = (String) keywordObj.get("requestToDate");
			if (requestToDate != null && !requestToDate.equals("") ) {
				Date date = Date.valueOf(requestToDate);
				orderHead.setRequestToDate(date);
			}
			System.out.println(orderHead.getRequestToDate());
			
			
			// 고객명
			String bname = keywordObj.getString("bname");
			orderHead.setBname(bname);
			System.out.println("고객명"+orderHead.getBname());
						
			// 상품명
			String pname = keywordObj.getString("pname");
			orderHead.setPname(pname);
			System.out.println("상품명"+orderHead.getPname());
			
			
			
			
			// 승인자
//			String signempCd = keywordObj.getString("signempCd");
//			orderHead.setSignempCd(signempCd);
//			System.out.println("승인자코드" + orderHead.getSignempCd());
			

			
			// 국가코드
			String countryCd = keywordObj.getString("countryCd");
			orderHead.setCountryCd(countryCd);
			
			
			
			
			
			List<OrderHead> orderStatusList = is.search(orderHead);
			
			System.out.println(orderStatusList.size());
			
			for (OrderHead oh : orderStatusList) {
				System.out.println(oh.toString());
				
				// 영업담당자명
				orderHead.setEname(oh.getEname());
				orderHead.setJob(oh.getJob());
				orderHead.setDepartment(oh.getDepartment());
				// 국가명
				orderHead.setCname(oh.getCname());
				// 승인자명
//				orderHead.setSignempName(oh.getAuth());
			}
			System.out.println(orderHead.getAuth());
			//System.out.println(orderHead.getSignempName());
			
			model.addAttribute("orderStatusList", orderStatusList);
			model.addAttribute("orderItem", orderHead);
			
			
			List<Product> productList = ps.list();
			List<Buyer> buyerList = bs.list();
			List<Country> countryList = cs.list();
			List<Employee> empList = es.list();
			
			model.addAttribute("productList", productList);
			model.addAttribute("buyerList", buyerList);
			model.addAttribute("countryList", countryList);
			model.addAttribute("empList", empList);
			
			
			
		} catch (ParseException e) {
			System.out.println(e.getMessage());
		}
		
		
			return "nolay/orderStatus";
		
	}
	
	@RequestMapping("orderUpdate.do")
	@ResponseBody
	public boolean orderUpdate(OrderHead orderHead) {
		
		boolean result = false;
		
		int check = hs.updateHead(orderHead);
		
		if (check > 0) {
			result = true;
		}
		
		return result;
	}
	
	@RequestMapping("getOrderCount")
	@ResponseBody
	public String getOrderCount(String orderNo) {
		
		String count = hs.getOrderCount(orderNo);
		System.out.println("몇개?" + count);
		
		return count;
	}
	
	@RequestMapping("orderDelete")
	@ResponseBody
	public boolean orderDelete(String[] checkRows) {
		boolean result = true;
		
		for (String orderNo : checkRows){
			try {
				hs.orderDelete(orderNo);
			} catch (Exception e) {
				System.out.println("실패 : " + orderNo);
				result = false;
			}			
		}
		return result;
	}
	
	
	@RequestMapping("orderRestore")
	@ResponseBody
	public boolean orderRestore(String[] checkRows) {
		boolean result = true;
		
		for (String orderNo : checkRows){
			try {
				hs.orderRestore(orderNo);
			} catch (Exception e) {
				System.out.println("실패 : " + orderNo);
				result = false;
			}			
		}
		return result;
	}
	@RequestMapping("excelDown.do")
	@ResponseBody
	public void excelDown(HttpServletResponse response,	@RequestParam(name="items")String items) throws IOException {
		
		// 출력할 주문리스트
		List<OrderHead> list = new ArrayList<>();
		OrderHead orderRow = new OrderHead();

		try {
			JSONParser p = new JSONParser();
			Object obj = p.parse(items);
			JSONArray arr = JSONArray.fromObject(obj);
			
			System.out.println("1");
			
			OrderHead item = new OrderHead();
			
			for (int i = 0; i < arr.size(); i++) {
				
				JSONObject itemObj = (JSONObject) arr.get(i);
				String orderNo = (String) itemObj.get("orderNo");
				System.out.println(orderNo);
				String productCd = (String) itemObj.get("productCd");
				System.out.println(productCd);
				
				item.setOrderNo(orderNo);
				item.setProductCd(productCd);
				
				orderRow = is.listForExcel(item);
				System.out.println(orderRow.getOrderdate());
				orderRow.getOrderdate();
				list.add(orderRow);
			}
			
			
		} catch (ParseException e) {
			System.out.println(e.getMessage());
		}
		
		
		System.out.println("size"+list.size());
		
		for (OrderHead oh : list) {
			System.out.println(oh.toString());
		}
		
		
		
		try {
			
		
		
		// 워크북 생성
		Workbook wb = new HSSFWorkbook();
		Sheet sheet = wb.createSheet("주문 현황");
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
	    cell.setCellValue("주문일");
	    
	    cell = row.createCell(1);
	    cell.setCellStyle(headStyle);
	    cell.setCellValue("주문번호");
	    
	    cell = row.createCell(2);
	    cell.setCellStyle(headStyle);
	    cell.setCellValue("상품코드");
	    
	    cell = row.createCell(3);
	    cell.setCellStyle(headStyle);
	    cell.setCellValue("상품명");
	    
	    cell = row.createCell(4);
	    cell.setCellStyle(headStyle);
	    cell.setCellValue("주문수량");
	    
	    cell = row.createCell(5);
	    cell.setCellStyle(headStyle);
	    cell.setCellValue("판매가");
	    
	    cell = row.createCell(6);
	    cell.setCellStyle(headStyle);
	    cell.setCellValue("금액 합계");
	    
	    cell = row.createCell(7);
	    cell.setCellStyle(headStyle);
	    cell.setCellValue("영업담당자");
	    
	    cell = row.createCell(8);
	    cell.setCellStyle(headStyle);
	    cell.setCellValue("상태");
	    
	    cell = row.createCell(9);
	    cell.setCellStyle(headStyle);
	    cell.setCellValue("상태변경일");
	    
	    cell = row.createCell(10);
	    cell.setCellStyle(headStyle);
	    cell.setCellValue("승인자");
	    
	    cell = row.createCell(11);
	    cell.setCellStyle(headStyle);
	    cell.setCellValue("납품요청일");
	    
	    cell = row.createCell(12);
	    cell.setCellStyle(headStyle);
	    cell.setCellValue("고객코드");
	    
	    cell = row.createCell(13);
	    cell.setCellStyle(headStyle);
	    cell.setCellValue("고객명");
	    
	    cell = row.createCell(14);
	    cell.setCellStyle(headStyle);
	    cell.setCellValue("고객담당자");
	    
	    cell = row.createCell(15);
	    cell.setCellStyle(headStyle);
	    cell.setCellValue("고객연락처");
	    
	    cell = row.createCell(16);
	    cell.setCellStyle(headStyle);
	    cell.setCellValue("고객이메일");
	    
	    cell = row.createCell(17);
	    cell.setCellStyle(headStyle);
	    cell.setCellValue("비고");
	    
	 // 데이터 부분 생성
	    for(OrderHead li : list) {

	        row = sheet.createRow(rowNo++);

	        cell = row.createCell(0);
	        cell.setCellStyle(bodyStyle);
	        cell.setCellValue(li.getOrderdate());
	        System.out.println(li.getOrderdate());
	        
		    cell = row.createCell(1);
		    cell.setCellStyle(bodyStyle);
		    cell.setCellValue(li.getOrderNo());
		    System.out.println(li.getOrderNo());
		    
		    cell = row.createCell(2);
		    cell.setCellStyle(bodyStyle);
		    cell.setCellValue(li.getProductCd());
		    System.out.println(li.getProductCd());
		    
		    cell = row.createCell(3);
		    cell.setCellStyle(bodyStyle);
		    cell.setCellValue(li.getPname());
		    System.out.println(li.getPname());
		    
		    cell = row.createCell(4);
		    cell.setCellStyle(bodyStyle);
		    cell.setCellValue(li.getRequestqty());
		    System.out.println(li.getRequestqty());
		    
		    cell = row.createCell(5);
		    cell.setCellStyle(bodyStyle);
		    cell.setCellValue(li.getPrice());
		    System.out.println(li.getPrice());
		    
		    
		    cell = row.createCell(6);
		    cell.setCellStyle(bodyStyle);
		    cell.setCellValue(li.getAmount());
		    System.out.println(li.getAmount());
		    
		    cell = row.createCell(7);
		    cell.setCellStyle(bodyStyle);
		    cell.setCellValue(li.getEname());
		    
		    cell = row.createCell(8);
		    cell.setCellStyle(bodyStyle);
		    cell.setCellValue(li.getStatus());
		    
		    cell = row.createCell(9);
		    cell.setCellStyle(bodyStyle);
		    cell.setCellValue(li.getStatusdate());
		    
		    cell = row.createCell(10);
		    cell.setCellStyle(bodyStyle);
		    cell.setCellValue(li.getAuth());
		    
		    cell = row.createCell(11);
		    cell.setCellStyle(bodyStyle);
		    cell.setCellValue(li.getRequestdate());
		    
		    cell = row.createCell(12);
		    cell.setCellStyle(bodyStyle);
		    cell.setCellValue(li.getBuyerCd());
		    
		    cell = row.createCell(13);
		    cell.setCellStyle(bodyStyle);
		    cell.setCellValue(li.getBname());
		    
		    cell = row.createCell(14);
		    cell.setCellStyle(bodyStyle);
		    cell.setCellValue(li.getManager());
		    
		    cell = row.createCell(15);
		    cell.setCellStyle(bodyStyle);
		    cell.setCellValue(li.getTel());
		    
		    cell = row.createCell(16);
		    cell.setCellStyle(bodyStyle);
		    cell.setCellValue(li.getEmail());
		    
		    cell = row.createCell(17);
		    cell.setCellStyle(bodyStyle);
		    cell.setCellValue(li.getRemark());

	    }
	
	    // 컨텐츠 타입과 파일명 지정
	    response.setContentType("ms-vnd/excel");
	    response.setHeader("Content-Disposition", "attachment;filename=order.xls");
	    
	    // 엑셀 출력
	    wb.write(response.getOutputStream());
	    wb.close();
	    
		} catch (IOException e) {
			e.printStackTrace();
		}
	    
	}
	
}
