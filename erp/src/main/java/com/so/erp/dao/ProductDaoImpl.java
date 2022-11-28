package com.so.erp.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
	public List<Product> productList(PagingBean pagingBean, Product product) {
		Map<String,Object> map = new HashMap<>();
		map.put("product", product);
		map.put("pagingBean", pagingBean);
		return sst.selectList("productns.productList",map);
	}

	@Override
	public int getTotal(PagingBean pagingBean,Product product) {
		Map<String,Object> map = new HashMap<>();
		map.put("product", product);
		map.put("pagingBean", pagingBean);
		return sst.selectOne("productns.getTotal",map);
	}

	@Override
	public List<Product> list() {
		return sst.selectList("productns.list");
	}
}
