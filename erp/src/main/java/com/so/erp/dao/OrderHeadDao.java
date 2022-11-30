package com.so.erp.dao;

import java.util.List;

import com.so.erp.model.OrderHead;

public interface OrderHeadDao {

	List<OrderHead> list();

	void insert(OrderHead orderHead);

	List<OrderHead> headEmpList();

	void orderApproval(OrderHead orderHead);

	List<OrderHead> search(OrderHead orderHead);

	int approvalRequest(String orderNo);

	int approvalCancel(String orderNo);

}
