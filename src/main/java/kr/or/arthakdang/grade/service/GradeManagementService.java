package kr.or.arthakdang.grade.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.arthakdang.domain.CourseVO;
import kr.or.arthakdang.grade.domain.GradeDTO;
import kr.or.arthakdang.grade.domain.GradeInfoVO;
import kr.or.arthakdang.mapper.GradeManagementMapper;
import kr.or.arthakdang.studentmanagement.domain.StudentVO;

@Service
public class GradeManagementService {

	@Autowired
	private GradeManagementMapper gradeManagementMapper;


	public int insertGrade(GradeDTO gradeDTO) {
		return gradeManagementMapper.insertGrade(gradeDTO);
	};

	public int updateGrade(GradeDTO gradeDTO) {
		return gradeManagementMapper.updateGrade(gradeDTO);
	};

	public int deleteGrade(GradeDTO gradeDTO) {
		return gradeManagementMapper.deleteGrade(gradeDTO);
	};

	public List<GradeInfoVO> getAllClassStudentGrdInfo(String cursNo) {

		return gradeManagementMapper.selectAllGradeInfoListByClass(cursNo);
	}

	public GradeInfoVO selectClassGradeOfStudent(String stuId, String cursNo) {
		
		GradeDTO gradeVO = new GradeDTO();
		gradeVO.setStuId(stuId);
		gradeVO.setCursNo(cursNo);
		return gradeManagementMapper.selectOneGradeInfoByStudentAndClass(gradeVO);
		
	}
	
	public List<StudentVO> selectStudentListToInsert(String cursNo) {
		return gradeManagementMapper.selectStudentListToInsert(cursNo);
	}
	
	public String getAvgScoreByClass(String cursNo) {
		return gradeManagementMapper.selectAvgGradeByClass(cursNo);
	}
}
