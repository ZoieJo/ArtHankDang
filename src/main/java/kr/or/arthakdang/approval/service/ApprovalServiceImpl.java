package kr.or.arthakdang.approval.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.arthakdang.approval.domain.AprldocVO;
import kr.or.arthakdang.approval.domain.AprllnVO;
import kr.or.arthakdang.approval.domain.UsdeaprllnVO;
import kr.or.arthakdang.domain.CurspnVO;
import kr.or.arthakdang.employeemanagement.domain.EmployeeVO;
import kr.or.arthakdang.mapper.ApprovalMapper;

@Service
public class ApprovalServiceImpl implements ApprovalService {

	@Autowired
	private ApprovalMapper mapper;

	@Override
	public List<EmployeeVO> empList(String emp_id) {
		return mapper.empList(emp_id);
	}

	@Override
	public int insertUsdeaprlln(UsdeaprllnVO vo) {
		return mapper.insertUsdeaprlln(vo);
	}

	@Override
	public int insertUsdeaprllndtl(Map<String, Object> map) {
		return mapper.insertUsdeaprllndtl(map);
	}

	@Override
	public int insertUsdeaprlrefln(Map<String, Object> map) {
		return mapper.insertUsdeaprlrefln(map);
	}

	@Override
	public UsdeaprllnVO getAprlln(UsdeaprllnVO vo) {
		return mapper.getAprlln(vo);
	}

	@Override
	public List<UsdeaprllnVO> getAprllnNo(String memId) {
		return mapper.getAprllnNo(memId);
	}

	@Override
	public int deleteAprlln(String usdeaprllnNo) {
		return mapper.deleteAprlln(usdeaprllnNo);
	}

	@Override
	public int deleteAprllndtl(String usdeaprllnNo) {
		return mapper.deleteAprllndtl(usdeaprllnNo);
	}

	@Override
	public int deleteAprlrefln(String usdeaprllnNo) {
		return mapper.deleteAprlrefln(usdeaprllnNo);
	}

	@Override
	public EmployeeVO userInfo(String empId) {
		return mapper.userInfo(empId);
	}

	@Override
	public String getEmpPosition(String empId) {
		return mapper.getEmpPosition(empId);
	}

	@Override
	public int saveAprlTemp(AprldocVO aprldocVO) {
		return mapper.saveAprlTemp(aprldocVO);
	}

	@Override
	public List<AprldocVO> tempAprldocList(String memId) {
		return mapper.tempAprldocList(memId);
	}

	@Override
	public int updateAprlTemp(AprldocVO aprldocVO) {
		return mapper.updateAprlTemp(aprldocVO);
	}

	@Override
	public AprldocVO aprldocInfo(String aprldocNo) {
		return mapper.aprldocInfo(aprldocNo);
	}

	@Override
	public List<CurspnVO> getCurspnList() {
		return mapper.getCurspnList();
	}

	@Override
	public int insertAprldoc(AprldocVO vo) {
		return mapper.insertAprldoc(vo);
	}

	@Override
	public int insertAprlln(AprllnVO vo) {
		return mapper.insertAprlln(vo);
	}

	@Override
	public List<AprldocVO> getSendboxList(String memId) {
		return mapper.getSendboxList(memId);
	}



}
