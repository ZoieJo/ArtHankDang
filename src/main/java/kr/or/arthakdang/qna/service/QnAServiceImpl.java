package kr.or.arthakdang.qna.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.arthakdang.mapper.QnAMapper;
import kr.or.arthakdang.qna.domain.QnAVO;

@Service
public class QnAServiceImpl implements QnAService {

	@Autowired
	private QnAMapper qnAMapper;
	
	@Override
	public List<QnAVO> selectQnAList() {
		return qnAMapper.selectQnAList();
	}

	@Override
	public int writeQnA(QnAVO qnAVO) {
		return qnAMapper.writeQnA(qnAVO);
	}

	@Override
	public int deleteQnA(QnAVO qnAVO) {
		return qnAMapper.deleteQnA(qnAVO);
	}

	@Override
	public int updateQnA(QnAVO qnAVO) {
		return qnAMapper.updateQnA(qnAVO);
	}

	@Override
	public List<QnAVO> searchQnA(String bdTl) {
		return qnAMapper.searchQnA(bdTl);
	}

	@Override
	public QnAVO selectQnA(String bdNo) {
		return qnAMapper.selectQnA(bdNo);
	}

}
