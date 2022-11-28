package com.so.erp.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.so.erp.model.PagingBean;
import com.so.erp.model.Product;

@Repository
public class ProductDaoImpl implements ProductDao {

	@Autowired
	private SqlSessionTemplate sst;

	@Override
	public List<Product> productList(PagingBean pagingBean) {
		return sst.selectList("productns.productList",pagingBean);
	}

	@Override
	public int getTotal(PagingBean pagingBean) {
		return sst.selectOne("productns.getTotal",pagingBean);
	}
}
