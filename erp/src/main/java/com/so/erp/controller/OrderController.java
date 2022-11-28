package com.so.erp.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.so.erp.model.OrderHead;
import com.so.erp.model.OrderItem;
import com.so.erp.service.OrderHeadService;
import com.so.erp.service.OrderItemService;

@Controller
public class OrderController {

	@Autowired
	private OrderHeadService head;
	@Autowired
	private OrderItemService item;
	
	@RequestMapping("order")
	public String order(Model model) {
		
		List<OrderHead> headList = head.list();
		
		model.addAttribute("headList", headList);
		
		return "nolay/order";
	}
	
	@RequestMapping("orderInsert")
	public String orderInsert(Model model, OrderHead orderHead, OrderItem orderItem) {		
		orderHead.setOrderNo("3");
		orderItem.setOrderNo("3");
		orderItem.setAmount(orderItem.getPrice() * orderItem.getRequestqty());
		
		head.insert(orderHead);
		item.insert(orderItem);
		
		
		
		List<OrderItem> itmeList = item.itemList(orderHead.getOrderNo());
		
		model.addAttribute("itmeList", itmeList);
		
		return "nolay/orderInsert";
	}

	
}
