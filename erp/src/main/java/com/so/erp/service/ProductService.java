package com.so.erp.service;

import java.util.List;

import com.so.erp.model.PagingBean;
import com.so.erp.model.Product;

public interface ProductService {

	List<Product> productList(PagingBean pagingBean, Product product);

	int getTotal(PagingBean pagingBean,Product product);

	List<Product> list();

	int checkRowDelete(String productCd);


}
