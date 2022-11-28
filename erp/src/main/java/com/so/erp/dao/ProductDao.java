package com.so.erp.dao;

import java.util.List;

import com.so.erp.model.PagingBean;
import com.so.erp.model.Product;

public interface ProductDao {

	List<Product> productList(PagingBean pagingBean);

	int getTotal(PagingBean pagingBean);

}
