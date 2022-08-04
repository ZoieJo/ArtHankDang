package kr.or.arthakdang.lectureevaluation.service;

import java.util.List;

import kr.or.arthakdang.lectureevaluation.domain.LectureEvaluationVO;

public interface LectureEvaluationService {

	public List<LectureEvaluationVO> myLectureList(String stuId);
	public LectureEvaluationVO myLecture(LectureEvaluationVO lectureEvaluationVO);
	public int lectureEvaluation(LectureEvaluationVO lectureEvaluationVO);
	public int evaluationCheck(LectureEvaluationVO lectureEvaluationVO);
	public int deleteEvalulation(LectureEvaluationVO lectureEvaluationVO);
}
