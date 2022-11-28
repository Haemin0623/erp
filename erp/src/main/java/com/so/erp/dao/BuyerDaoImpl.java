package com.so.erp.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.so.erp.model.Buyer;

@Repository
public class BuyerDaoImpl implements BuyerDao {

	@Autowired
	private SqlSessionTemplate sst;

	@Override
	public List<Buyer> list() {
		return sst.selectList("buyerns.list");
	}
}
