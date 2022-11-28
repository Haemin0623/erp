package com.so.erp.dao;

import java.util.List;

import com.so.erp.model.OrderItem;

public interface OrderItemDao {

	void insert(OrderItem orderItem);

	List<OrderItem> itemList(String orderNo);

	List<OrderItem> orderStatusList();

}
