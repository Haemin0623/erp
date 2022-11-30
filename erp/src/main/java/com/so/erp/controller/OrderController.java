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
		
		System.out.println(orderHead.getOrderNo());
		// List<OrderHead> headList = hs.list();
		List<OrderHead> headList = hs.search(orderHead);
		
		model.addAttribute("headList", headList);
		
		return "nolay/order";
	}
	
	@RequestMapping("orderSearch")
	public String orderSearch(Model model, @RequestParam(name="keyword") String keyword) {
		
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
			
			String productCd = (String) keywordObj.get("productCd");
			String requestdate = (String) keywordObj.get("requestdate");
			
			List<OrderHead> headList = hs.search(orderHead);
			model.addAttribute("headList", headList);
			model.addAttribute("orderHead", orderHead);
			
		} catch (ParseException e) {
			System.out.println(e.getMessage());
		}
		
		return "nolay/order";
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
		List<Product> productList = ps.list();
		List<Buyer> buyerList = bs.list();
		List<Country> countryList = cs.list();
		List<Employee> empList = es.list();
		List<OrderItem> orderStatusList = is.orderStatusList();
		
		model.addAttribute("productList", productList);
		model.addAttribute("buyerList", buyerList);
		model.addAttribute("countryList", countryList);
		model.addAttribute("empList", empList);
		model.addAttribute("orderStatusList", orderStatusList);
		return "page/orderStatus";
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
			@RequestParam(name="reason")String reason) {
		
		boolean result = true;
		OrderHead orderHead = new OrderHead();
		orderHead.setReason(reason);
		System.out.println("raseon완료"+orderHead.getReason());
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
	
	
	
	
	
}
