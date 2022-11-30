package com.so.erp.controller;

import java.sql.Date;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
import com.so.erp.model.Product;
import com.so.erp.service.BuyerService;
import com.so.erp.service.CountryService;
import com.so.erp.service.EmployeeService;
import com.so.erp.service.OrderHeadService;
import com.so.erp.service.OrderItemService;
import com.so.erp.service.ProductService;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;

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
	
	@RequestMapping("order")
	public String order(Model model, OrderHead orderHead, OrderItem orderItem) {
		
		System.out.println(orderHead.getStatus());
		orderHead.setStatus("null");
		// List<OrderHead> headList = hs.list();
		List<OrderHead> headList = hs.search(orderHead);
		
		model.addAttribute("headList", headList);
		
		return "nolay/order";
	}
	
	@RequestMapping("orderSearch")
	public String orderSearch(Model model, @RequestParam(name="keyword") String keyword) {
		
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
			
			List<OrderHead> headList = hs.search(orderHead);
			System.out.println(headList.size());
			
			for (OrderHead oh : headList) {
				System.out.println(oh.toString());
			}
			
			model.addAttribute("headList", headList);
			model.addAttribute("orderHead", orderHead);
			
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
			String orderNo = "221128CVS001015";
			System.out.println("1");
			String buyerCd = (String) headObj.get("buyerCd");
			System.out.println("2");
			String date = (String) headObj.get("orderdate");
			Date orderdate = Date.valueOf(date);
			System.out.println(orderdate);
			orderHead.setOrderNo(orderNo);
			orderHead.setBuyerCd(buyerCd);
			orderHead.setOrderdate(orderdate);
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
	public String orderStatus(Model model) {
		
//		List<Product> productList = ps.list();
//		List<Buyer> buyerList = bs.list();
//		List<Country> countryList = cs.list();
//		List<Employee> empList = es.list();
		List<OrderItem> orderStatusList = is.orderStatusList();
		
//		model.addAttribute("productList", productList);
//		model.addAttribute("buyerList", buyerList);
//		model.addAttribute("countryList", countryList);
//		model.addAttribute("empList", empList);
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
	@RequestMapping("orderStatusSearch")
	public String orderStatusSearch(Model model, @RequestParam(name="keyword") String keyword) {
		
		System.out.println("1");
		
		try {
			
			JSONParser p = new JSONParser();
			Object obj = p.parse(keyword);
			JSONObject keywordObj = JSONObject.fromObject(obj);
			
			OrderItem orderItem = new OrderItem();
			
			String orderNo = (String) keywordObj.get("orderNo");
			orderItem.setOrderNo(orderNo);
			System.out.println(orderItem.getOrderNo());
			
			String buyerCd = (String) keywordObj.get("buyerCd");
			orderItem.setBuyerCd(buyerCd);
			
			System.out.println("2");
			
			String orderFromDate = (String) keywordObj.get("orderFromDate");
			if (orderFromDate != null && !orderFromDate.equals("") ) {
				Date date = Date.valueOf(orderFromDate);
				orderItem.setOrderFromDate(date);
			}

			System.out.println("3");
			
			String orderToDate = (String) keywordObj.get("orderToDate");
			if (orderToDate != null && !orderToDate.equals("") ) {
				Date date = Date.valueOf(orderToDate);
				orderItem.setOrderToDate(date);
			}
			
			System.out.println("4");
			
			String employeeCd = (String) keywordObj.get("employeeCd");
			orderItem.setEmployeeCd(employeeCd);
			String status = (String) keywordObj.get("status");
			orderItem.setStatus(status);
			
			String productCd = (String) keywordObj.get("productCd");
			orderItem.setProductCd(productCd);
			
			String requestdate = (String) keywordObj.get("requestdate");
			if (requestdate != null && !requestdate.equals("") ) {
				Date date = Date.valueOf(requestdate);
				orderItem.setRequestdate(date);
			}
			
			List<OrderItem> orderStatusList = is.search(orderItem);
			model.addAttribute("orderStatusList", orderStatusList);
			model.addAttribute("orderHead", orderItem);
			System.out.println("5");
		} catch (ParseException e) {
			System.out.println(e.getMessage());
		}
		return "nolay/orderStatus";
		

		
	}
	
}
