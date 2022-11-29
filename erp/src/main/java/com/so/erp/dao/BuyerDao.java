package com.so.erp.dao;

import java.util.List;

import com.so.erp.model.Buyer;

public interface BuyerDao {

	List<Buyer> list();

	int insert(Buyer buyer);

	int delete(String buyerCd);

}
