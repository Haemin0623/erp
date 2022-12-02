package com.so.erp.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.so.erp.model.OrderHead;
import com.so.erp.model.OrderItem;

@Repository
public class OrderItemDaoImpl implements OrderItemDao {

	@Autowired
	private SqlSessionTemplate sst;

	@Override
	public void insert(OrderItem orderItem) {
		sst.insert("itemns.insert", orderItem);
		
	}

	@Override
	public List<OrderItem> itemList(String orderNo) {
		return sst.selectList("itemns.itemList", orderNo);
	}

	@Override
	public List<OrderItem> orderStatusList() {
		return sst.selectList("itemns.orderStatusList");
	}

	@Override
	public List<OrderHead> search(OrderHead orderHead) {
		return sst.selectList("itemns.search", orderHead);
	}

	@Override
	public OrderHead listForExcel(OrderHead item) {
		return sst.selectOne("itemns.listForExcel", item);
	}
}
