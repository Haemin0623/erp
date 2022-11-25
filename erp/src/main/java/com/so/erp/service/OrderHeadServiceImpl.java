package com.so.erp.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.so.erp.dao.OrderHeadDao;

@Service
public class OrderHeadServiceImpl implements OrderHeadService {

	@Autowired
	private OrderHeadDao head;
}
