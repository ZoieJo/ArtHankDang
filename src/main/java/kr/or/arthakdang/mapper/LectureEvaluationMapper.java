package kr.or.arthakdang.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.arthakdang.lectureevaluation.domain.LectureEvaluationVO;

@Mapper
public interface LectureEvaluationMapper {
	public List<LectureEvaluationVO> myLectureList(String stuId);
	public LectureEvaluationVO myLecture(LectureEvaluationVO lectureEvaluationVO);
	public int lectureEvaluation(LectureEvaluationVO lectureEvaluationVO);
	public int evaluationCheck(LectureEvaluationVO lectureEvaluationVO);
	public int deleteEvalulation(LectureEvaluationVO lectureEvaluationVO);
}
