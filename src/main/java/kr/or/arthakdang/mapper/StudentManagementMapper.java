package kr.or.arthakdang.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.arthakdang.domain.MemberVO;
import kr.or.arthakdang.studentmanagement.domain.StudentListPageCountVO;
import kr.or.arthakdang.studentmanagement.domain.StudentVO;

@Mapper
public interface StudentManagementMapper {

	public int joinStudent(StudentVO stuVO);
	public String viewStudentId(StudentVO stuVO);
	public List<StudentVO> studentList();
	public List<StudentVO> selectStudentPage(StudentListPageCountVO studentListPageVO);
	public int selectStudentTotalCnt();
	public List<StudentVO> selectNameStudent(StudentListPageCountVO studentListPageVO);
	public List<StudentVO> selectPhNoStudent(StudentListPageCountVO studentListPageVO);
	public int studentNameCnt(StudentListPageCountVO studentListPageVO);	
	public StudentVO selectOneStudent(String stuId);
	public int studentPhNoCnt(StudentListPageCountVO studentListPageVO);
	public int updateStudentPw(MemberVO memVO);
	public int updateStudentInfo(StudentVO stuVO);
	public int deleteStudent(StudentVO stuVO);
	public String studentInfoCheck(String memId);
	public List<String> searchEmployee();
	public String selectSeq();

	
}
