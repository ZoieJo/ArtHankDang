package kr.or.arthakdang.subject.service;

import java.util.List;

import kr.or.arthakdang.subject.domain.SubjectVO;

public interface SubjectService {
	
	public List<SubjectVO> selectSub();
	public int deleteSub(String subNo);
	public int insertSub(String subNm);
	public int updateSub(SubjectVO subVO);
}
