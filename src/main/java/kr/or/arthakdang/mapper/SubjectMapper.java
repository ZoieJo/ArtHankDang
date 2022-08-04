package kr.or.arthakdang.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.arthakdang.subject.domain.SubjectVO;

@Mapper
public interface SubjectMapper {
	
	public List<SubjectVO> selectSub();
	public int deleteSub(String subNo);
	public int insertSub(String subNm);
	public int updateSub(SubjectVO subVO);

}
