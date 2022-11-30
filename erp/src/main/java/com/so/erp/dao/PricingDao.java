package com.so.erp.dao;

import java.util.List;

import com.so.erp.model.Pricing;

public interface PricingDao {

	List<Pricing> pricingList(Pricing pricing);

	int insert(Pricing pricing);

	int getTotal();


}
