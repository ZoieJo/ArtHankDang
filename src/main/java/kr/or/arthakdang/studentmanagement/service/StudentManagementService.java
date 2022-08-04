package kr.or.arthakdang.studentmanagement.service;

import java.util.List;

import kr.or.arthakdang.domain.MemberVO;
import kr.or.arthakdang.studentmanagement.domain.StudentListPageCountVO;
import kr.or.arthakdang.studentmanagement.domain.StudentVO;

public interface StudentManagementService {
	public int joinStudent(StudentVO stuVO);
	public String viewStudentId(StudentVO stuVO);
	public List<StudentVO> studentList();
	public List<StudentVO> selectStudentPage(StudentListPageCountVO studentListPageVO);
	public int selectStudentTotalCnt();
	public List<StudentVO> selectNameStudent(StudentListPageCountVO studentListPageVO);
	public List<StudentVO> selectPhNoStudent(StudentListPageCountVO studentListPageVO);
	public int studentNameCnt(StudentListPageCountVO studentListPageVO);
	public int studentPhNoCnt(StudentListPageCountVO studentListPageVO);
	public int updateStudentPw(MemberVO memVO);
	public int updateStudentInfo(StudentVO stuVO);
	public int deleteStudent(StudentVO stuVO);
	public List<String> searchEmployee();
	public String selectSeq();
}
