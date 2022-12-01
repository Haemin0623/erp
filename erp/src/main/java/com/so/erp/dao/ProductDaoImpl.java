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

	@Override
	public int checkRowDelete(String productCd) {
		return sst.update("productns.checkRowDelete",productCd);
	}

	@Override
	public int insert(Product product) {
		return sst.insert("productns.insert",product);
	}

	@Override
	public String selectCode(String category) {
		return sst.selectOne("productns.selectCode",category);
	}

	@Override
	public int update(Product product) {
		return sst.update("productns.update",product);
	}

	@Override
	public Product insertselect(Product product) {
		return sst.selectOne("productns.insertselect",product);
	}


}
