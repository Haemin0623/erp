package com.so.erp.controller;

import java.io.IOException;
import java.sql.Date;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.poi.hssf.util.HSSFColor.HSSFColorPredefined;
import org.apache.poi.ss.usermodel.BorderStyle;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.FillPatternType;
import org.apache.poi.ss.usermodel.HorizontalAlignment;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.so.erp.model.Employee;
import com.so.erp.model.OrderHead;
import com.so.erp.service.EmployeeService;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

@Controller
public class EmployeeController {

	@Autowired
	private EmployeeService es;

	@RequestMapping("emp")
	public String emp(Model model, Employee employee) {
		
		int rowPerPage = 20 ;
		
		if (employee.getRowPerPage() != 0) {
			rowPerPage = employee.getRowPerPage();
		} 
		if (employee.getPageNum() == null || employee.getPageNum().equals("")) {
			employee.setPageNum("1");
		}
		
		employee.setDel("N");
		
		int currentPage = Integer.parseInt(employee.getPageNum());
		int total = es.getTotal(employee);
		
		employee.pagingBean(currentPage, rowPerPage, total);
		int startRow = (currentPage - 1) * rowPerPage + 1;
		int endRow = startRow + rowPerPage - 1;
		employee.setStartRow(startRow);
		employee.setEndRow(endRow);
		
		employee.setSortEmployeeCd(0);
		employee.setSortEname(0);
		employee.setSortAdddate(1);
		employee.setSortJob(0);
		employee.setSortDepartment(0);
		employee.setSortAuthority(0);
		
		List<Employee> empList = es.search(employee);
		
		model.addAttribute("empList", empList);
		
		return "nolay/emp";
	}
	
	@RequestMapping("empInsert")
	@ResponseBody
	public boolean empInsert(Model model, Employee employee) {
		
		boolean result = true;
		
		try {
			es.insert(employee);
		} catch (Exception e) {
			System.out.println(e.getMessage());
			result = false;
		}
		
		return result;
	}
	
	@RequestMapping("empSearch")
	public String empSearch(Model model, @RequestParam(name="keyword") String keyword) {
		
		System.out.println("1");
		
		try {
			
			JSONParser p = new JSONParser();
			Object obj = p.parse(keyword);
			JSONObject keywordObj = JSONObject.fromObject(obj);
			
			Employee employee = new Employee();
			
			String employeeCd = (String) keywordObj.get("employeeCd");
			employee.setEmployeeCd(employeeCd);
			String ename = (String) keywordObj.get("ename");
			employee.setEname(ename);
			String job = (String) keywordObj.get("job");
			employee.setJob(job);
			String department = (String) keywordObj.get("department");
			employee.setDepartment(department);
			
			String addFromDate = (String) keywordObj.get("addFromDate");
			if (addFromDate != null && !addFromDate.equals("") ) {
				Date date = Date.valueOf(addFromDate);
				employee.setAddFromDate(date);
			}
			
			String addToDate = (String) keywordObj.get("addToDate");
			if (addToDate != null && !addToDate.equals("") ) {
				Date date = Date.valueOf(addToDate);
				employee.setAddToDate(date);
			}
			
			System.out.println("4");
			
			String authority = (String) keywordObj.get("authority");
			employee.setAuthority(authority);
			
			String del = (String) keywordObj.get("del");
			employee.setDel(del);
			
			int sortEmployeeCd = Integer.valueOf((String) keywordObj.get("sortEmployeeCd"));
			employee.setSortEmployeeCd(sortEmployeeCd);
			int sortEname = Integer.valueOf((String) keywordObj.get("sortEname"));
			employee.setSortEname(sortEname);
			int sortJob = Integer.valueOf((String) keywordObj.get("sortJob"));
			employee.setSortJob(sortJob);
			int sortDepartment = Integer.valueOf((String) keywordObj.get("sortDepartment"));
			employee.setSortDepartment(sortDepartment);
			int sortAdddate = Integer.valueOf((String) keywordObj.get("sortAdddate"));
			employee.setSortAdddate(sortAdddate);
			int sortAuthority = Integer.valueOf((String) keywordObj.get("sortAuthority"));
			employee.setSortAuthority(sortAuthority);			
			
			int rowPerPage = Integer.valueOf((String) keywordObj.get("rowPerPage"));
			int currentPage = Integer.valueOf((String) keywordObj.get("currentPage"));
			int total = es.getTotal(employee);
			
			employee.pagingBean(currentPage, rowPerPage, total);
			
			int startRow = (currentPage - 1) * rowPerPage + 1;
			int endRow = startRow + rowPerPage - 1;
			employee.setStartRow(startRow);
			employee.setEndRow(endRow);
			
			List<Employee> empList = es.search(employee);
			System.out.println(empList.size());
			
			for (Employee oh : empList) {
				System.out.println(oh.toString());
			}
			
			model.addAttribute("empList", empList);
			model.addAttribute("employee", employee);
			
		} catch (ParseException e) {
			System.out.println(e.getMessage());
		}
		
		return "nolay/emp";
	}
	
	@RequestMapping("empUpdate.do")
	@ResponseBody
	public boolean empUpdate(Employee employee) {
		
		boolean result = true;
		
		try {
			es.update(employee);
		} catch (Exception e) {
			System.out.println(e.getMessage());
			result = false;
		}
		
		return result;
	}
	
	@RequestMapping("employeeDelete")
	@ResponseBody
	public boolean employeeDelete(String[] checkRows) {
		boolean result = true;
		
		for (String employeeCd : checkRows){
			try {
				es.employeeDelete(employeeCd);
			} catch (Exception e) {
				System.out.println("실패 : " + employeeCd);
				result = false;
			}			
		}
		return result;
	}
	
	
	@RequestMapping("employeeRestore")
	@ResponseBody
	public boolean employeeRestore(String[] checkRows) {
		boolean result = true;
		
		for (String employeeCd : checkRows){
			try {
				es.employeeRestore(employeeCd);
			} catch (Exception e) {
				System.out.println("실패 : " + employeeCd);
				result = false;
			}			
		}
		return result;
	}
	
	@RequestMapping("getSALCount")
	@ResponseBody
	public String getSALCount(String department) {
		int count = es.getSALCount(department);
		String number = String.format("%03d", count);
		
		System.out.println(number);
		
		return number;
	}
	
	@RequestMapping("empExcelDown")
	@ResponseBody
	public void orderExcelDown(HttpServletResponse response, @RequestParam(name="items")String items) throws IOException {
		System.out.println("시작");
		//List<OrderHead> list = is.search(checkRow); List<OrderHead> checkRow,
		// 출력할 주문리스트
		List<Employee> list = new ArrayList<>();
		
		Employee orderRow = new Employee();

		try {
			JSONParser p = new JSONParser();
			Object obj = p.parse(items);
			JSONArray arr = JSONArray.fromObject(obj);
			
			System.out.println("1");
			
			Employee item = new Employee();
			
			for (int i = 0; i < arr.size(); i++) {
				
				JSONObject itemObj = (JSONObject) arr.get(i);
				String employeeCd = (String) itemObj.get("employeeCd");
				System.out.println(employeeCd);
				
				item.setEmployeeCd(employeeCd);
				
				System.out.println("sql전");
				orderRow = es.listForExcel(item);
				System.out.println("sql후");
				list.add(orderRow);
			}
			
			
		} catch (ParseException e) {
			System.out.println(e.getMessage());
		}
		
		
		System.out.println("size"+list.size());

		
		
			
		
		
		// 워크북 생성
		Workbook wb = new XSSFWorkbook();
		Sheet sheet = wb.createSheet("주문 현황");
		Row row = null;
		Cell cell = null;
		int rowNo = 0;
		
		// 테이블 헤더용 스타일
		CellStyle headStyle = wb.createCellStyle();
		
		// 가는 경계선
		headStyle.setBorderTop(BorderStyle.THIN);
	    headStyle.setBorderBottom(BorderStyle.THIN);
	    headStyle.setBorderLeft(BorderStyle.THIN);
	    headStyle.setBorderRight(BorderStyle.THIN);

	    // 배경색 노란색
	    headStyle.setFillForegroundColor(HSSFColorPredefined.YELLOW.getIndex());
	    headStyle.setFillPattern(FillPatternType.SOLID_FOREGROUND);
	    
	    // 데이터 가운데 정렬
	    headStyle.setAlignment(HorizontalAlignment.CENTER);
	    
	    // 데이터용 경계 스타일 테두리만 지정
	    CellStyle bodyStyle = wb.createCellStyle();
	    bodyStyle.setBorderTop(BorderStyle.THIN);
	    bodyStyle.setBorderBottom(BorderStyle.THIN);
	    bodyStyle.setBorderLeft(BorderStyle.THIN);
	    bodyStyle.setBorderRight(BorderStyle.THIN);
	    
	    // 헤더 생성
	    row = sheet.createRow(rowNo++);
	    
	    cell = row.createCell(0);
	    cell.setCellStyle(headStyle);
	    cell.setCellValue("직원코드");
	    
	    cell = row.createCell(1);
	    cell.setCellStyle(headStyle);
	    cell.setCellValue("직원명");
	    
	    cell = row.createCell(2);
	    cell.setCellStyle(headStyle);
	    cell.setCellValue("직책");
	    
	    cell = row.createCell(3);
	    cell.setCellStyle(headStyle);
	    cell.setCellValue("부서");
	    
	    cell = row.createCell(4);
	    cell.setCellStyle(headStyle);
	    cell.setCellValue("등록일");
	    
	    cell = row.createCell(5);
	    cell.setCellStyle(headStyle);
	    cell.setCellValue("승인권한");
	    
	    cell = row.createCell(6);
	    cell.setCellStyle(headStyle);
	    cell.setCellValue("상태변경일");
	    
	    
	 // 데이터 부분 생성
	    for(Employee li : list) {

	        row = sheet.createRow(rowNo++);

	        cell = row.createCell(0);
	        cell.setCellStyle(bodyStyle);
	        cell.setCellValue(li.getEmployeeCd());
	        System.out.println(li.getEmployeeCd());
	        
		    cell = row.createCell(1);
		    cell.setCellStyle(bodyStyle);
		    cell.setCellValue(li.getEname());
		    System.out.println(li.getEname());
		    
		    cell = row.createCell(2);
		    cell.setCellStyle(bodyStyle);
		    cell.setCellValue(li.getJob());
		    System.out.println(li.getJob());
		    
		    cell = row.createCell(3);
		    cell.setCellStyle(bodyStyle);
		    cell.setCellValue(li.getDepartment());
		    System.out.println(li.getDepartment());
		    
		    cell = row.createCell(4);
		    cell.setCellStyle(bodyStyle);
		    cell.setCellValue(li.getAdddate().toString());
		    System.out.println(li.getAdddate().toString());
		    
		    cell = row.createCell(5);
		    cell.setCellStyle(bodyStyle);
		    cell.setCellValue(li.getAuthority());
		    System.out.println(li.getAuthority());
		    
		    cell = row.createCell(6);
		    cell.setCellStyle(bodyStyle);
		    cell.setCellValue(li.getStatusdate().toString());
		    System.out.println(li.getStatusdate().toString());
	    }
	
	    // 컨텐츠 타입과 파일명 지정
	    response.setContentType("ms-vnd/excel");
	    response.setHeader("Content-Disposition", "attachment;filename=order.xlsx");
	    
	    // 엑셀 출력
	    try {
            wb.write(response.getOutputStream());
        } finally {
            wb.close();
        }
	    
	    
	}
	
}
