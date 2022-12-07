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
	public List<OrderHead> headEmpList() {
		return head.headEmpList();
	}

	@Override
	public void orderApproval(OrderHead orderHead) {
		head.orderApproval(orderHead);
	}

	@Override
	public List<OrderHead> search(OrderHead orderHead) {
		return head.search(orderHead);
	}

	@Override
	public int approvalRequest(String orderNo) {
		return head.approvalRequest(orderNo);
		
	}

	@Override
	public int approvalCancel(String orderNo) {
		return head.approvalCancel(orderNo);
	}

	@Override
	public int updateHead(OrderHead orderHead) {
		return head.updateHead(orderHead);
	}

	@Override
	public String getOrderCount(String orderNo) {
		return head.getOrderCount(orderNo);
	}

	@Override
	public void orderDelete(String orderNo) {
		head.orderDelete(orderNo);
		
	}

	@Override
	public void orderRestore(String orderNo) {
		head.orderRestore(orderNo);
	}

	@Override
	public int getTotal(OrderHead orderHead) {
		return head.getTotal(orderHead);
	}

	@Override
	public OrderHead listForExcel(OrderHead item) {
		return head.listForExcel(item);
	}
}
