package com.so.erp.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.so.erp.model.Buyer;
import com.so.erp.model.Pricing;
import com.so.erp.model.Product;

@Repository
public class PricingDaoImpl implements PricingDao {

	@Autowired
	private SqlSessionTemplate sst;

	@Override
	public List<Pricing> pricingList(Pricing pricing) {
		return sst.selectList("pricingns.pricingList", pricing);
	}

	@Override
	public int getTotal() {
		return sst.selectOne("pricingns.getTotal");
	}

	@Override
	public void pricingInsert(Pricing pricing) {
		sst.insert("pricingns.insert", pricing);
	}

	@Override
	public int pricingDelete(Pricing pricing) {
		return sst.update("pricingns.delete", pricing);
	}

	@Override
	public int pricingUpdate(Pricing pricing) {
		return sst.update("pricingns.update", pricing);
	}

	@Override
	public int getPrice(Pricing pricing) {
		return sst.selectOne("pricingns.getPrice", pricing);
	}

	@Override
	public List<Product> getProductList(String buyerCd) {
		return sst.selectList("pricingns.getProductList", buyerCd);
	}

}
