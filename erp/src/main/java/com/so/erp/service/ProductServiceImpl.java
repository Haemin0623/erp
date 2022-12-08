package com.so.erp.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.so.erp.dao.ProductDao;
import com.so.erp.model.OrderHead;
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

	@Override
	public int update(Product product) {
		return pds.update(product);
	}

	@Override
	public Product insertselect(Product product) {
		return pds.insertselect(product);
	}

	@Override
	public List<Product> allList() {
		return pds.allList();
	}

	@Override
	public int amountByProduct(String productCd) {
		return pds.amountByProduct(productCd);
	}
	@Override
	public Product listForExcel(Product item) {
		return pds.listForExcel(item);
	}

	@Override
	public Product updateselect(Product product) {
		return pds.updateselect(product);
	}

	@Override
	public List<Product> activeList() {
		return pds.activeList();
	}


}
