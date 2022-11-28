package com.so.erp.dao;

import java.util.List;

import com.so.erp.model.Pricing;

public interface PricingDao {

	List<Pricing> pricingList();

	List<Pricing> searchList(Pricing pricing);

}
