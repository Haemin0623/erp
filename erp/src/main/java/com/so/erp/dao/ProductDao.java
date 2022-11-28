package com.so.erp.dao;

import java.util.List;

import com.so.erp.model.PagingBean;
import com.so.erp.model.Product;

public interface ProductDao {

	List<Product> productList(PagingBean pagingBean, Product product);

	int getTotal(PagingBean pagingBean,Product product);

}
