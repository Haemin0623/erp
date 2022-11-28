package com.so.erp.service;

import java.util.List;

import com.so.erp.model.PagingBean;
import com.so.erp.model.Product;

public interface ProductService {

	List<Product> productList(PagingBean pagingBean);

	int getTotal(PagingBean pagingBean);

}
