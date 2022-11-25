package com.so.erp.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class BuyerDaoImpl implements BuyerDao {

	@Autowired
	private SqlSessionTemplate sst;
}
