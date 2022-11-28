package com.so.erp.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

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
	
	@RequestMapping("orderInsert")
	public String orderInsert(Model model, OrderHead orderHead, OrderItem orderItem) {		
		orderHead.setOrderNo("3");
		orderItem.setOrderNo("3");
		orderItem.setAmount(orderItem.getPrice() * orderItem.getRequestqty());
		
		hs.insert(orderHead);
		is.insert(orderItem);
		
		
		
		List<OrderItem> itmeList = is.itemList(orderHead.getOrderNo());
		
		model.addAttribute("itmeList", itmeList);
		
		return "nolay/orderInsert";
	}


	@RequestMapping("orderStatus")
	public String orderStatus(Model model) {
		List<Product> productList = ps.list();
		List<Buyer> buyerList = bs.list();
		List<Country> countryList = cs.list();
		List<Employee> empList = es.list();
//		List<OrderHead> orderStatus = head.
		
		model.addAttribute("productList", productList);
		model.addAttribute("buyerList", buyerList);
		model.addAttribute("countryList", countryList);
		model.addAttribute("empList", empList);
		return "page/orderStatus";
	}
	
}
