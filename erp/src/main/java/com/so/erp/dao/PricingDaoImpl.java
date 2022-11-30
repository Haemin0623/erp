package com.so.erp.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.so.erp.model.Pricing;

@Repository
public class PricingDaoImpl implements PricingDao {

	@Autowired
	private SqlSessionTemplate sst;

	@Override
	public List<Pricing> pricingList(Pricing pricing) {
		return sst.selectList("pricingns.pricingList", pricing);
	}

	@Override
	public int insert(Pricing pricing) {
		return sst.insert("pricingns.insert", pricing);
	}

	@Override
	public int getTotal() {
		return sst.selectOne("pricingns.getTotal");
	}

}
