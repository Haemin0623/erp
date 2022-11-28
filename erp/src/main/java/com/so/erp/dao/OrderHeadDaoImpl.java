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
}
