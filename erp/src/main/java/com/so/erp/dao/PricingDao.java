package com.so.erp.dao;

import java.util.List;

import com.so.erp.model.Pricing;

public interface PricingDao {

	List<Pricing> pricingList(Pricing pricing);

	int getTotal();

	void pricingInsert(Pricing pricing);

	int pricingDelete(Pricing pricing);

	int pricingUpdate(Pricing pricing);

	int getPrice(Pricing pricing);


}
