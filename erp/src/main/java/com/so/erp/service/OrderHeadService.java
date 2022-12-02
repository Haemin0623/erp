package com.so.erp.service;

import java.util.List;

import com.so.erp.model.OrderHead;

public interface OrderHeadService {

	List<OrderHead> list();

	void insert(OrderHead orderHead);

	List<OrderHead> headEmpList();

	void orderApproval(OrderHead head);

	List<OrderHead> search(OrderHead head);

	int approvalRequest(String orderNo);

	int approvalCancel(String orderNo);

	int updateHead(OrderHead orderHead);

	String getOrderCount(String orderNo);

	void orderDelete(String orderNo);

	void orderRestore(String orderNo);

}
