package kr.or.arthakdang.lectureevaluation.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.arthakdang.lectureevaluation.domain.LectureEvaluationVO;
import kr.or.arthakdang.mapper.LectureEvaluationMapper;

@Service
public class LectureEvaluationServiceImpl implements LectureEvaluationService {

	@Autowired
	private LectureEvaluationMapper lectureEvaluationMapper;
	
	@Override
	public List<LectureEvaluationVO> myLectureList(String stuId) {
		return lectureEvaluationMapper.myLectureList(stuId);
	}

	@Override
	public LectureEvaluationVO myLecture(LectureEvaluationVO lectureEvaluationVO) {
		return lectureEvaluationMapper.myLecture(lectureEvaluationVO);
	}

	@Override
	public int lectureEvaluation(LectureEvaluationVO lectureEvaluationVO) {
		return lectureEvaluationMapper.lectureEvaluation(lectureEvaluationVO);
	}

	@Override
	public int evaluationCheck(LectureEvaluationVO lectureEvaluationVO) {
		return lectureEvaluationMapper.evaluationCheck(lectureEvaluationVO);
	}

	@Override
	public int deleteEvalulation(LectureEvaluationVO lectureEvaluationVO) {
		return lectureEvaluationMapper.deleteEvalulation(lectureEvaluationVO);
	}

}
