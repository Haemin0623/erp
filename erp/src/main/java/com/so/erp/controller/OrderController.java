package com.so.erp.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.so.erp.model.OrderHead;
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
		System.out.println("123");
		
		
		List<OrderHead> headList = head.list();
		
		for(OrderHead head : headList) {
			System.out.println(head.getOrderNo());
		}
		
		model.addAttribute("headList", headList);
		
		return "nolay/order";
	}

	
}
