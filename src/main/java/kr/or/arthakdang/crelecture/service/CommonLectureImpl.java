package kr.or.arthakdang.crelecture.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.arthakdang.crelecture.domain.CursEvaluationVO;
import kr.or.arthakdang.crelecture.domain.CursVO;
import kr.or.arthakdang.mapper.CreLectureMapper2;

@Service
public class CommonLectureImpl implements CommonLectureService {

	@Autowired
	CreLectureMapper2 cl2;

	// 강의 리스트 가져오기 + 썸네일
	@Override
	public List<CursVO> selectCursList() {
		return cl2.selectCursList();
	}

	// 강의 상세 정보
	@Override
	public List<CursVO> selectCursDtl(String cursNo) {
		return cl2.selectCursDtl(cursNo);
	}

	// 강의 평가 목록
	@Override
	public List<CursEvaluationVO> selectCursEvaList() {
		return cl2.selectCursEvaList();
	}

}
