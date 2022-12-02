package com.so.erp.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.so.erp.model.OrderHead;

@Repository
public class OrderHeadDaoImpl implements OrderHeadDao {

	@Autowired
	private SqlSessionTemplate sst;

	@Override
	public List<OrderHead> list() {
		return sst.selectList("headns.list");
	}

	@Override
	public void insert(OrderHead orderHead) {
		sst.insert("headns.insert", orderHead);
	}

	@Override
	public List<OrderHead> headEmpList() {
		return sst.selectList("headns.headEmpList");
	}

	@Override
	public void orderApproval(OrderHead orderHead) {
		sst.update("headns.orderApproval", orderHead);
	}

	@Override
	public List<OrderHead> search(OrderHead orderHead) {
		return sst.selectList("headns.search", orderHead);
	}

	@Override
	public int approvalRequest(String orderNo) {
		return sst.update("headns.approvalRequest", orderNo);
	}

	@Override
	public int approvalCancel(String orderNo) {
		return sst.update("headns.approvalCancel", orderNo);
	}

	@Override
	public int updateHead(OrderHead orderHead) {
		return sst.update("headns.updateHead", orderHead);
	}

	@Override
	public String getOrderCount(String orderNo) {
		return sst.selectOne("headns.getOrderCount", orderNo);
	}

	@Override
	public void orderDelete(String orderNo) {
		sst.update("headns.orderDelete", orderNo);
		
	}

	@Override
	public void orderRestore(String orderNo) {
		sst.update("headns.orderRestore", orderNo);
		
	}
}
