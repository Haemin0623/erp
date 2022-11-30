package com.so.erp.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.so.erp.dao.PricingDao;
import com.so.erp.model.Pricing;

@Service
public class PricingServiceImpl implements PricingService {

	@Autowired
	private PricingDao prd;

	@Override
	public List<Pricing> pricingList(Pricing pricing) {
		return prd.pricingList(pricing);
	}

	@Override
	public int insert(Pricing pricing) {
		return prd.insert(pricing);
	}

	@Override
	public int getTotal() {
		return prd.getTotal();
	}

}
