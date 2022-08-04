package kr.or.arthakdang.employeemanagement.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.arthakdang.domain.MemberVO;
import kr.or.arthakdang.employeemanagement.domain.EmployeeListPageCountVO;
import kr.or.arthakdang.employeemanagement.domain.EmployeeVO;
import kr.or.arthakdang.employeemanagement.domain.SubVO;
import kr.or.arthakdang.mapper.EmployeeManagementMapper;

@Service
public class EmployeeManagementServiceImpl implements EmployeeManagementService {

	@Autowired
	private EmployeeManagementMapper empManagementMapper;
	
	@Override
	public int joinEmployee(EmployeeVO employeeVO) {
		return empManagementMapper.joinEmployee(employeeVO);
	}

	@Override
	public String viewEmployeeId(EmployeeVO employeeVO) {
		return empManagementMapper.viewEmployeeId(employeeVO);
	}

	@Override
	public List<EmployeeVO> employeeList() {
		return empManagementMapper.employeeList();
	}

	@Override
	public List<EmployeeVO> selectEmployeePage(EmployeeListPageCountVO employeeListPageVO) {
		return empManagementMapper.selectEmployeePage(employeeListPageVO);
	}

	@Override
	public int selectEmployeeTotalCnt() {
		return empManagementMapper.selectEmployeeTotalCnt();
	}
	
	@Override
	public List<EmployeeVO> selectNameEmployee(EmployeeListPageCountVO employeeListPageVO) {
		return empManagementMapper.selectNameEmployee(employeeListPageVO);
	}

	@Override
	public List<EmployeeVO> selectPhNoEmployee(EmployeeListPageCountVO employeeListPageVO) {
		return empManagementMapper.selectPhNoEmployee(employeeListPageVO);
	}

	@Override
	public int employeeNameCnt(EmployeeListPageCountVO employeeListPageVO) {
		return empManagementMapper.employeeNameCnt(employeeListPageVO);
	}

	@Override
	public int employeePhNoCnt(EmployeeListPageCountVO employeeListPageVO) {
		return empManagementMapper.employeePhNoCnt(employeeListPageVO);
	}

	@Override
	public int updateEmployeePw(MemberVO memberVO) {
		return empManagementMapper.updateEmployeePw(memberVO);
	}

	@Override
	public int updateEmployeeInfo(EmployeeVO employeeVO) {
		return empManagementMapper.updateEmployeeInfo(employeeVO);
	}

	@Override
	public int deleteEmployee(EmployeeVO employeeVO) {
		return empManagementMapper.deleteEmployee(employeeVO);
	}

	@Override
	public int joinTeacher(EmployeeVO employeeVO) {
		return empManagementMapper.joinTeacher(employeeVO);
	}

	@Override
	public List<SubVO> subList() {
		return empManagementMapper.subList();
	}

	@Override
	public String selectSeq() {
		return empManagementMapper.selectSeq();
	}
}
