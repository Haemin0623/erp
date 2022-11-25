package com.so.erp.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.so.erp.model.Dept;
import com.so.erp.service.DeptService;

@Controller
public class DeptController {

	@Autowired
	private DeptService ds;
	
	@RequestMapping("deptList")
	public String deptList(Model model) {
		List<Dept> deptList = ds.list();
		
		model.addAttribute("deptList", deptList);
		
		return "/dept/_05_deptList";
	}
	
	@RequestMapping(value = "dnoChk", produces = "text/html;charset=utf-8")
	@ResponseBody	// jsp로 가지 말고 바로 본문을 전달.
	public String dnoChk(int deptno) {
		String msg = "";
		Dept dept = ds.select(deptno);
		
		if (dept == null) {
			msg = "사용 가능!!";
		} else {
			msg = "중복된 코드!";
		}
		
		return msg;
	}
	
}
