package kr.or.arthakdang.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.arthakdang.domain.MemberVO;
import kr.or.arthakdang.employeemanagement.domain.EmployeeListPageCountVO;
import kr.or.arthakdang.employeemanagement.domain.EmployeeVO;
import kr.or.arthakdang.employeemanagement.domain.SubVO;

@Mapper
public interface EmployeeManagementMapper {
	
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
	public EmployeeVO selectOneEmployee(String empId);
	public int updateEmployeeInfo(EmployeeVO employeeVO);
	public int deleteEmployee(EmployeeVO employeeVO);
	public int joinTeacher(EmployeeVO employeeVO);
	public List<SubVO> subList();
	public String selectSeq();
	public String employeeInfoCheck(String memId);
}
