package com.so.erp.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.so.erp.dao.BuyerDao;

@Service
public class BuyerServiceImpl implements BuyerService {
	
	@Autowired
	private BuyerDao buyer;

}
