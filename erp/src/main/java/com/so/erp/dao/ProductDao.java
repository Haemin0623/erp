package com.so.erp.dao;

import java.util.List;

import com.so.erp.model.OrderHead;
import com.so.erp.model.PagingBean;
import com.so.erp.model.Product;

public interface ProductDao {

	List<Product> productList(PagingBean pagingBean, Product product);

	int getTotal(PagingBean pagingBean,Product product);

	List<Product> list();

	int checkRowDelete(String productCd);

	int insert(Product product);

	String selectCode(String category);

	int update(Product product);

	Product insertselect(Product product);

	List<Product> allList();

	int amountByProduct(String productCd);
	
	Product listForExcel(Product item);

	Product updateselect(Product product);

	List<Product> activeList();


}
