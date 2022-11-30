package com.so.erp.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.so.erp.model.Buyer;

@Repository
public class BuyerDaoImpl implements BuyerDao {

	@Autowired
	private SqlSessionTemplate sst;

	@Override
	public List<Buyer> list() {
		return sst.selectList("buyerns.list");
	}

	@Override
	public int insert(Buyer buyer) {
		return sst.insert("buyerns.insert", buyer); // buyer객체를 전달
	}

	@Override
	public int delete(String buyerCd) {
		return sst.delete("buyerns.delete",buyerCd);
	}

	@Override
	public int update(Buyer buyer) {
		return sst.update("buyerns.update",buyer);
	}

	@Override
	public List<Buyer> search(Buyer buyer) {
		return sst.selectList("buyerns.search", buyer); //select 문을 사용할건데(여러개니까 list), 이름을 search로 하겠다
	}
}
