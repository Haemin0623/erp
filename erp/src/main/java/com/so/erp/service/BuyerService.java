package com.so.erp.service;

import java.util.List;

import com.so.erp.model.Buyer;

public interface BuyerService {

	List<Buyer> list();

	int insert(Buyer buyer);

	int delete(String buyerCd);

	int update(Buyer buyer);

	List<Buyer> search(Buyer buyer);

	List<Buyer> ndlist();

	Buyer select(String buyerCd); //고객 신규등록시 중복체크

	List<Buyer> dlist();

	int getTotal(Buyer buyer);

	void buyerRestore(String buyerCd);

}
