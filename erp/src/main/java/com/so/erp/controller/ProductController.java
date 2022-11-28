package com.so.erp.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.so.erp.model.PagingBean;
import com.so.erp.model.Product;
import com.so.erp.service.ProductService;

@Controller
public class ProductController {

	@Autowired
	private ProductService product;
	
	
	@RequestMapping("productList")
	public String productList(Model model, PagingBean pagingBean, String pageNum) {
		int rowPerPage = 10; // 한 화면에 보여주는 갯수
		if (pageNum == null || pageNum.equals("")) pageNum = "1";
		int currentPage = Integer.parseInt(pageNum);
		int total = product.getTotal(pagingBean);		
		int startRow = (currentPage - 1) * rowPerPage + 1;
		int endRow = startRow + rowPerPage - 1;
		int num = total - startRow + 1;
		pagingBean.setStartRow(startRow);
		pagingBean.setEndRow(endRow);
		List<Product> productList = product.productList(pagingBean);
		PagingBean pb = new PagingBean(currentPage, rowPerPage, total);
		model.addAttribute("productList",productList);
		model.addAttribute("num",num);
		model.addAttribute("pb",pb);
		return "page/productList";
	}
}
