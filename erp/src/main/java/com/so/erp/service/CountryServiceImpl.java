package com.so.erp.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.so.erp.dao.CountryDao;
import com.so.erp.model.Country;

@Service
public class CountryServiceImpl implements CountryService {

	@Autowired
	private CountryDao country;

	@Override
	public List<Country> list() {
		return country.list();
	}
}
