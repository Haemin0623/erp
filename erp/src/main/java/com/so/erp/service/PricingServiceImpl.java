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
	public List<Pricing> pricingList() {
		return prd.pricingList();
	}

	@Override
	public List<Pricing> searchList(Pricing pricing) {
		return prd.searchList(pricing);
	}
}
