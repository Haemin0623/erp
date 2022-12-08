package com.so.erp.dao;

import java.util.List;

import com.so.erp.model.Buyer;

public interface BuyerDao {

	List<Buyer> list();

	int insert(Buyer buyer);

	int delete(String buyerCd);

	int update(Buyer buyer);

	List<Buyer> search(Buyer buyer);

	List<Buyer> ndlist();

	Buyer select(String buyerCd);

	List<Buyer> dlist();

	int getTotal(Buyer buyer);

	void buyerRestore(String buyerCd);

	Buyer listForExcel(Buyer item);

	String selectCode(String autoCompleteCd);


}
