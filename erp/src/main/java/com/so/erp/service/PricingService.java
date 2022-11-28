package com.so.erp.service;

import java.util.List;

import com.so.erp.model.Pricing;

public interface PricingService {

	List<Pricing> pricingList();

	List<Pricing> searchList(Pricing pricing);

}
