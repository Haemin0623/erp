package com.so.erp.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.so.erp.dao.PricingDao;
import com.so.erp.model.Buyer;
import com.so.erp.model.Pricing;
import com.so.erp.model.Product;

@Service
public class PricingServiceImpl implements PricingService {

	@Autowired
	private PricingDao prd;

	@Override
	public List<Pricing> pricingList(Pricing pricing) {
		return prd.pricingList(pricing);
	}

	@Override
	public int getTotal(Pricing pricing) {
		return prd.getTotal(pricing);
	}

	@Override
	public void pricingInsert(Pricing pricing) {
		prd.pricingInsert(pricing);
	}

	@Override
	public int pricingDelete(Pricing pricing) {
		return prd.pricingDelete(pricing);
	}

	@Override
	public int pricingUpdate(Pricing pricing) {
		return prd.pricingUpdate(pricing);
	}

	@Override
	public int getPrice(Pricing pricing) {
		return prd.getPrice(pricing);
	}

	@Override
	public List<Product> getProductList(Pricing pricing) {
		return prd.getProductList(pricing);
	}
		
	public List<Pricing> search(Pricing pricing) {
		return prd.search(pricing);
	}

	@Override
	public int pricingRestore(Pricing pricing) {
		return prd.pricingRestore(pricing);
	}

	@Override
	public int overlapCheck(Pricing pricing) {
		return prd.overlapCheck(pricing);
	}

	@Override
	public Pricing listForExcel(Pricing pricing) {
		return prd.listForExcel(pricing);
	}
	

}
