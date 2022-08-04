package kr.or.arthakdang.studentmanagement.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.arthakdang.domain.MemberVO;
import kr.or.arthakdang.mapper.StudentManagementMapper;
import kr.or.arthakdang.studentmanagement.domain.StudentListPageCountVO;
import kr.or.arthakdang.studentmanagement.domain.StudentVO;
import lombok.extern.slf4j.Slf4j;

@Service
public class StudentManagementServiceImpl implements StudentManagementService {

	@Autowired
	private StudentManagementMapper stuManagementMapper;

	@Override
	public int joinStudent(StudentVO stuVO) {
		return stuManagementMapper.joinStudent(stuVO);
	}

	@Override
	public String viewStudentId(StudentVO stuVO) {
		return stuManagementMapper.viewStudentId(stuVO);
	}

	@Override
	public List<StudentVO> studentList() {
		return stuManagementMapper.studentList();
	}

	@Override
	public List<StudentVO> selectStudentPage(StudentListPageCountVO studentListPageVO) {
		return stuManagementMapper.selectStudentPage(studentListPageVO);
	}

	@Override
	public int selectStudentTotalCnt() {
		return stuManagementMapper.selectStudentTotalCnt();
	}

	@Override
	public List<StudentVO> selectNameStudent(StudentListPageCountVO studentListPageVO) {
		return stuManagementMapper.selectNameStudent(studentListPageVO);
	}

	@Override
	public List<StudentVO> selectPhNoStudent(StudentListPageCountVO studentListPageVO) {
		return stuManagementMapper.selectPhNoStudent(studentListPageVO);
	}

	@Override
	public int studentNameCnt(StudentListPageCountVO studentListPageVO) {
		return stuManagementMapper.studentNameCnt(studentListPageVO);
	}

	@Override
	public int studentPhNoCnt(StudentListPageCountVO studentListPageVO) {
		return stuManagementMapper.studentPhNoCnt(studentListPageVO);
	}

	@Override
	public int updateStudentPw(MemberVO memVO) {
		return stuManagementMapper.updateStudentPw(memVO);
	}

	@Override
	public int updateStudentInfo(StudentVO stuVO) {
		return stuManagementMapper.updateStudentInfo(stuVO);
	}

	@Override
	public int deleteStudent(StudentVO stuVO) {
		return stuManagementMapper.deleteStudent(stuVO);
	}

	@Override
	public List<String> searchEmployee() {
		return stuManagementMapper.searchEmployee();
	}

	@Override
	public String selectSeq() {
		return stuManagementMapper.selectSeq();
	}
}