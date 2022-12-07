package com.so.erp.dao;

import java.util.List;

import com.so.erp.model.Employee;
import com.so.erp.model.OrderHead;
import com.so.erp.model.OrderItem;

public interface OrderItemDao {

	void insert(OrderItem orderItem);

	List<OrderItem> itemList(String orderNo);

	List<OrderItem> orderStatusList();

	List<OrderHead> search(OrderHead orderHead);

	OrderHead listForExcel(OrderHead item);

	int getTotal(OrderHead orderHead);

	int monthAmount7();
	int monthAmount8();
	int monthAmount9();
	int monthAmount10();
	int monthAmount11();
	int monthAmount12();

	List<Employee> listOfSales();

	int amountByEmp(String empCd);

}
