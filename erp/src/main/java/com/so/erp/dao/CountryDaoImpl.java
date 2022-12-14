package com.so.erp.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.so.erp.model.Country;

@Repository
public class CountryDaoImpl implements CountryDao {

	@Autowired
	private SqlSessionTemplate sst;

	@Override
	public List<Country> list() {
		return sst.selectList("countryns.list");
	}
}
