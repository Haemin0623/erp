package com.so.erp.service;

import java.util.List;

import com.so.erp.model.OrderItem;

public interface OrderItemService {

	void insert(OrderItem orderItem);

	List<OrderItem> itemList(String orderNo);

	List<OrderItem> orderStatusList();

}
