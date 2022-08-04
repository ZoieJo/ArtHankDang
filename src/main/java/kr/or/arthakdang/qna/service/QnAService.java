package kr.or.arthakdang.qna.service;

import java.util.List;

import kr.or.arthakdang.qna.domain.QnAVO;

public interface QnAService {
	public List<QnAVO> selectQnAList();
	public int writeQnA(QnAVO qnAVO);
	public int deleteQnA(QnAVO qnAVO);
	public int updateQnA(QnAVO qnAVO);
	public List<QnAVO> searchQnA(String bdTl);
	public QnAVO selectQnA(String bdNo);
}
