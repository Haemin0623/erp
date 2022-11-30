package com.so.erp.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.so.erp.dao.ProductDao;
import com.so.erp.model.PagingBean;
import com.so.erp.model.Product;

@Service
public class ProductServiceImpl implements ProductService {

	@Autowired
	private ProductDao pds;

	@Override
	public List<Product> productList(PagingBean pagingBean, Product product) {
		return pds.productList(pagingBean, product);
	}

	@Override
	public int getTotal(PagingBean pagingBean,Product product) {
		return pds.getTotal(pagingBean,product);
	}
	
	@Override
	public List<Product> list() {
		return pds.list();
	}

	@Override
	public int checkRowDelete(String productCd) {
		return pds.checkRowDelete(productCd);
	}

	@Override
	public int insert(Product product) {
		return pds.insert(product);
	}

	@Override
	public String selectCode(String category) {
		return pds.selectCode(category);
	}


}
