package com.so.erp.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.so.erp.dao.CountryDao;

@Service
public class CountryServiceImpl implements CountryService {

	@Autowired
	private CountryDao country;
}
