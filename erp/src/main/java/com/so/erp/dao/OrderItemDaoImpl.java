package com.so.erp.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.so.erp.model.Employee;
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

	@Override
	public int getTotal(OrderHead orderHead) {
		return sst.selectOne("itemns.getTotal", orderHead);
	}

	@Override
	public int monthAmount7() {
		return sst.selectOne("itemns.monthAmount7");
	}
	@Override
	public int monthAmount8() {
		return sst.selectOne("itemns.monthAmount8");
	}
	@Override
	public int monthAmount9() {
		return sst.selectOne("itemns.monthAmount9");
	}
	@Override
	public int monthAmount10() {
		return sst.selectOne("itemns.monthAmount10");
	}
	@Override
	public int monthAmount11() {
		return sst.selectOne("itemns.monthAmount11");
	}
	@Override
	public int monthAmount12() {
		return sst.selectOne("itemns.monthAmount12");
	}

	@Override
	public List<Employee> listOfSales() {
		return sst.selectList("itemns.listOfSales");
	}

	@Override
	public int amountByEmp(String empCd) {
		return sst.selectOne("itemns.amountByEmp", empCd);
	}

	@Override
	public List<OrderItem> select(String orderNo) {
		return sst.selectList("itemns.select", orderNo);
	}

	@Override
	public void update(OrderItem orderItem) {
		sst.update("itemns.update", orderItem);
		
	}

	@Override
	public void delete(OrderItem orderItem) {
		sst.delete("itemns.delete", orderItem);
		
	}
}
