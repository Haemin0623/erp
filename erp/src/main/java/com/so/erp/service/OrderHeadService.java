package com.so.erp.service;

import java.util.List;

import com.so.erp.model.OrderHead;

public interface OrderHeadService {

	List<OrderHead> list();

	void insert(OrderHead orderHead);

	List<OrderHead> headItemList();

}
