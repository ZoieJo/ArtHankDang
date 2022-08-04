package kr.or.arthakdang.subject.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.arthakdang.mapper.SubjectMapper;
import kr.or.arthakdang.subject.domain.SubjectVO;

@Service
public class SubjectImpl implements SubjectService {
	
	@Autowired
	SubjectMapper sbm;
	
	// 선택
	@Override
	public List<SubjectVO> selectSub() {
		return sbm.selectSub();
	}

	// 삭제(n -> y)
	@Override
	public int deleteSub(String subNo) {
		return sbm.deleteSub(subNo);
	}

	// 등록
	@Override
	public int insertSub(String subNm) {
		return sbm.insertSub(subNm);
	}

	// 수정
	@Override
	public int updateSub(SubjectVO subVO) {
		return sbm.updateSub(subVO);
	}

}
