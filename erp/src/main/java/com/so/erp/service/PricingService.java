package com.so.erp.service;

import java.util.List;

import com.so.erp.model.Pricing;

public interface PricingService {

	List<Pricing> pricingList(Pricing pricing);

	int insert(Pricing pricing);

	int getTotal();


}
