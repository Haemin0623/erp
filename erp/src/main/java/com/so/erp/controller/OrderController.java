package com.so.erp.controller;

import java.sql.Date;
import java.util.ArrayList;
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

import org.json.simple.JSONObject;
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
	public String order(Model model) {
		
		List<OrderHead> headList = hs.list();
		
		model.addAttribute("headList", headList);
		
		return "nolay/order";
	}
	
	
	@SuppressWarnings("unchecked")
	@RequestMapping("orderInsert")
	@ResponseBody
	public boolean orderInsert(Model model, @RequestParam(name="head")String head, @RequestParam(name="items")String items) throws ParseException {		
		
		boolean result = true;
		
		try {
			
			JSONParser p = new JSONParser();
			JSONObject obj = (JSONObject) p.parse(head);
			
			System.out.println(obj.toString());
			OrderHead orderHead = new OrderHead();
			String orderNo = "221128CVS002001";
			System.out.println("1");
			String buyerCd = (String) obj.get("buyerCd");
			System.out.println("2");
			String date = (String) obj.get("orderdate");
			Date orderdate = Date.valueOf(date);
			System.out.println(orderdate);
			orderHead.setOrderNo(orderNo);
			orderHead.setBuyerCd(buyerCd);
			orderHead.setOrderdate(orderdate);
			orderHead.setEmployeeCd("SAL005");
			
			System.out.println("헤드 삽입");
			hs.insert(orderHead);
			System.out.println("헤드 삽입완");
			
			List<Map<String,Object>> orderItems = new ArrayList<>();
			orderItems = JSONArray.fromObject(items);
			
			OrderItem item = new OrderItem(); 
			
			for (Map<String,Object> orderItem : orderItems) {
				
				System.out.println(orderItem.toString());
				
				String productCd = (String) orderItem.get("productCd");
				int requestqty = (int) orderItem.get("requestqty");
				int price = (int) orderItem.get("price");
				int amount = (int) orderItem.get("amount");
				Date requestdate = (Date) orderItem.get("requestdate");
				String remark = (String) orderItem.get("remark");
				
				item.setOrderNo(orderNo);
				item.setProductCd(productCd);
				item.setRequestqty(requestqty);
				item.setRequestdate(requestdate);
				item.setPrice(price);
				item.setAmount(amount);
				item.setRemark(remark);
				
				is.insert(item);
			}
		
		} catch (Exception e) {
			e.getMessage();
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
	
}
