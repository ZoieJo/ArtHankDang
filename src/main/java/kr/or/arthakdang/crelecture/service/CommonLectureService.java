package kr.or.arthakdang.crelecture.service;


import java.util.List;

import kr.or.arthakdang.crelecture.domain.CursEvaluationVO;
import kr.or.arthakdang.crelecture.domain.CursVO;

public interface CommonLectureService {
	
	// 1. 강의실 정보
	public List<CursVO> selectCursList();
	
	// 2. 강의실 상세 정보
	public List<CursVO> selectCursDtl(String cursNo);
	
	//3. 강의 평가 리스트
	public List<CursEvaluationVO> selectCursEvaList();
}
