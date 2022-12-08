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

	@Override
	public List<Buyer> ndlist() { //삭제한것 리스트업
		return sst.selectList("buyerns.ndlist");
	}

	@Override
	public Buyer select(String buyerCd) {
		return sst.selectOne("buyerns.select",buyerCd);
	}

	@Override
	public List<Buyer> dlist() { //삭제안한것 리스트업
		return sst.selectList("buyerns.dlist");
	}
	
	public int getTotal(Buyer buyer) {
		return sst.selectOne("buyerns.getTotal", buyer);
	}

	@Override
	public void buyerRestore(String buyerCd) {
		sst.update("buyerns.buyerRestore", buyerCd);
	}

	@Override
	public Buyer listForExcel(Buyer item) {
		return sst.selectOne("buyerns.listForExcel", item);
	}

	@Override
	public String selectCode(String autoCompleteCd) {
		return sst.selectOne("buyerns.selectCode",autoCompleteCd);
	}
}
