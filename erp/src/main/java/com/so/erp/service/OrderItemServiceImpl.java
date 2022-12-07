package com.so.erp.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.so.erp.dao.OrderItemDao;
import com.so.erp.model.Employee;
import com.so.erp.model.OrderHead;
import com.so.erp.model.OrderItem;

@Service
public class OrderItemServiceImpl implements OrderItemService {

	@Autowired
	private OrderItemDao id;

	@Override
	public void insert(OrderItem orderItem) {
		id.insert(orderItem);
		
	}

	@Override
	public List<OrderItem> itemList(String orderNo) {
		return id.itemList(orderNo);
	}

	@Override
	public List<OrderItem> orderStatusList() {
		return id.orderStatusList();
	}

	@Override
	public List<OrderHead> search(OrderHead orderHead) {
		return id.search(orderHead);
	}

	@Override
	public OrderHead listForExcel(OrderHead item) {
		return id.listForExcel(item);
	}

	@Override
	public int getTotal(OrderHead orderHead) {
		return id.getTotal(orderHead);
	}

	@Override
	public int monthAmount7() {
		return id.monthAmount7();
	}
	@Override
	public int monthAmount8() {
		return id.monthAmount8();
	}
	@Override
	public int monthAmount9() {
		return id.monthAmount9();
	}
	@Override
	public int monthAmount10() {
		return id.monthAmount10();
	}
	@Override
	public int monthAmount11() {
		return id.monthAmount11();
	}
	@Override
	public int monthAmount12() {
		return id.monthAmount12();
	}

	@Override
	public List<Employee> listOfSales() {
		return id.listOfSales();
	}

	@Override
	public int amountByEmp(String empCd) {
		return id.amountByEmp(empCd);
	}
}
