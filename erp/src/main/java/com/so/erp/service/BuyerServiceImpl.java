package com.so.erp.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.so.erp.dao.BuyerDao;
import com.so.erp.model.Buyer;

@Service
public class BuyerServiceImpl implements BuyerService {
	
	@Autowired
	private BuyerDao buyer;

	@Override
	public List<Buyer> list() {
		return buyer.list();
	}

}
