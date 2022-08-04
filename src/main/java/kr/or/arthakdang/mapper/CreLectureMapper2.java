package kr.or.arthakdang.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.arthakdang.crelecture.domain.CursEvaluationVO;
import kr.or.arthakdang.crelecture.domain.CursVO;

@Mapper
public interface CreLectureMapper2 {
	
	// 강의 리스트 가져오기
	public List<CursVO> selectCursList();
	
	// 강의실 상세 정보
	public List<CursVO> selectCursDtl(String cursNo);

	// 강의 평가 리스트
	public List<CursEvaluationVO> selectCursEvaList();
}
