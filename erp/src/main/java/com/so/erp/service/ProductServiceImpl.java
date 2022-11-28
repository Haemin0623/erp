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
	private ProductDao product;

	@Override
	public List<Product> productList(PagingBean pagingBean) {
		return product.productList(pagingBean);
	}

	@Override
	public int getTotal(PagingBean pagingBean) {
		return product.getTotal(pagingBean);
	}
}
