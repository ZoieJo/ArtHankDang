package kr.or.arthakdang.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.arthakdang.grade.domain.GradeDTO;
import kr.or.arthakdang.grade.domain.GradeInfoVO;
import kr.or.arthakdang.studentmanagement.domain.StudentVO;

@Mapper
public interface GradeManagementMapper {

	public int insertGrade(GradeDTO gradeDTO);
	public int updateGrade(GradeDTO gradeDTO);
	public int deleteGrade(GradeDTO gradeDTO);
	public GradeDTO selectOneGrade(String grdNo);
	
	public GradeInfoVO selectOneGradeInfoByStudentAndClass(GradeDTO gradeDTO);
	
	public List<GradeInfoVO> selectAllGradeInfoListByClass(String cursNo);
	public List<GradeDTO> selectAllGradeListByStudent(String stuId);

	public List<StudentVO> selectStudentListToInsert(String cursNo);
	
	public String selectAvgGradeByClass(String cursNo);
	
}
