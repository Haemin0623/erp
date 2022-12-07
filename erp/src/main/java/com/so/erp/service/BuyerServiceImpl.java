package com.so.erp.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.so.erp.dao.BuyerDao;
import com.so.erp.model.Buyer;

@Service
public class BuyerServiceImpl implements BuyerService {
	
	@Autowired
	private BuyerDao bd;

	@Override
	public List<Buyer> list() {
		return bd.list();
	}

	@Override
	public int insert(Buyer buyer) {
		return bd.insert(buyer);
	}

	@Override
	public int delete(String buyerCd) {
		return bd.delete(buyerCd);
	}

	@Override
	public int update(Buyer buyer) {
		return bd.update(buyer);
	}

	@Override
	public List<Buyer> search(Buyer buyer) {
		return bd.search(buyer);
	}

	@Override
	public List<Buyer> ndlist() {
		return bd.ndlist();
	}

	@Override
	public Buyer select(String buyerCd) {
		return bd.select(buyerCd);
	}

	@Override
	public List<Buyer> dlist() {
		return bd.dlist();
	}

}
