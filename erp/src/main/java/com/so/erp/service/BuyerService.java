package com.so.erp.service;

import java.util.List;

import com.so.erp.model.Buyer;

public interface BuyerService {

	List<Buyer> list();

	int insert(Buyer buyer);

	int delete(String buyerCd);

	int update(Buyer buyer);

}
