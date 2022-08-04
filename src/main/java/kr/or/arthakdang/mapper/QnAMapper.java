package kr.or.arthakdang.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.arthakdang.qna.domain.QnAVO;

@Mapper
public interface QnAMapper {
	
	public List<QnAVO> selectQnAList();
	public int writeQnA(QnAVO qnAVO);
	public int deleteQnA(QnAVO qnAVO);
	public int updateQnA(QnAVO qnAVO);
	public List<QnAVO> searchQnA(String bdTl);
	public QnAVO selectQnA(String bdNo);
}
