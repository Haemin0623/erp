package com.so.erp.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.so.erp.dao.OrderItemDao;
import com.so.erp.model.OrderHead;
import com.so.erp.model.OrderItem;

@Service
public class OrderItemServiceImpl implements OrderItemService {

	@Autowired
	private OrderItemDao item;

	@Override
	public void insert(OrderItem orderItem) {
		item.insert(orderItem);
		
	}

	@Override
	public List<OrderItem> itemList(String orderNo) {
		return item.itemList(orderNo);
	}

	@Override
	public List<OrderItem> orderStatusList() {
		return item.orderStatusList();
	}

	@Override
	public List<OrderHead> search(OrderHead orderHead) {
		return item.search(orderHead);
	}
}
