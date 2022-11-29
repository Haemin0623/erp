package com.so.erp.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.so.erp.dao.OrderHeadDao;
import com.so.erp.model.OrderHead;

@Service
public class OrderHeadServiceImpl implements OrderHeadService {

	@Autowired
	private OrderHeadDao head;

	@Override
	public List<OrderHead> list() {
		return head.list();
	}

	@Override
	public void insert(OrderHead orderHead) {
		head.insert(orderHead);
		
	}

	@Override
	public List<OrderHead> headItemList() {
		return head.headItemList();
	}
}
