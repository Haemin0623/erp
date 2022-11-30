package com.so.erp.service;

import java.util.List;

import com.so.erp.model.Pricing;

public interface PricingService {

	List<Pricing> pricingList(Pricing pricing);

	int getTotal();

	void pricingInsert(Pricing pricing);

	int pricingDelete(Pricing pricing);


}
