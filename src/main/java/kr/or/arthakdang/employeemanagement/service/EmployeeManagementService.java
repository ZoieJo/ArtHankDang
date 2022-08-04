package kr.or.arthakdang.employeemanagement.service;

import java.util.List;

import kr.or.arthakdang.domain.MemberVO;
import kr.or.arthakdang.employeemanagement.domain.EmployeeListPageCountVO;
import kr.or.arthakdang.employeemanagement.domain.EmployeeVO;
import kr.or.arthakdang.employeemanagement.domain.SubVO;

public interface EmployeeManagementService {

	public int joinEmployee(EmployeeVO employeeVO);
	public String viewEmployeeId(EmployeeVO employeeVO);
	public List<EmployeeVO> employeeList();
	public List<EmployeeVO> selectEmployeePage(EmployeeListPageCountVO employeeListPageVO);
	public int selectEmployeeTotalCnt();
	public List<EmployeeVO> selectNameEmployee(EmployeeListPageCountVO employeeListPageVO);
	public List<EmployeeVO> selectPhNoEmployee(EmployeeListPageCountVO employeeListPageVO);
	public int employeeNameCnt(EmployeeListPageCountVO employeeListPageVO);
	public int employeePhNoCnt(EmployeeListPageCountVO employeeListPageVO);
	public int updateEmployeePw(MemberVO memberVO);
	public int updateEmployeeInfo(EmployeeVO employeeVO);
	public int deleteEmployee(EmployeeVO employeeVO);
	public int joinTeacher(EmployeeVO employeeVO);
	public List<SubVO> subList();
	public String selectSeq();
}
