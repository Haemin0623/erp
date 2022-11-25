package com.so.erp.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.so.erp.dao.PricingDao;

@Service
public class PricingServiceImpl implements PricingService {

	@Autowired
	private PricingDao pricing;
}
