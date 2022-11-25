package com.so.erp.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.so.erp.service.OrderHeadService;
import com.so.erp.service.OrderItemService;

@Controller
public class OrderController {

	@Autowired
	private OrderHeadService head;
	@Autowired
	private OrderItemService item;

	
}
