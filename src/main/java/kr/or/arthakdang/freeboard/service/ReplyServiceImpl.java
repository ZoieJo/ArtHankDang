package kr.or.arthakdang.freeboard.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.arthakdang.freeboard.domain.ReplyVO;
import kr.or.arthakdang.mapper.ReplyMapper;

@Service
public class ReplyServiceImpl implements ReplyService{
	
	@Autowired
	private ReplyMapper replyMapper;
	
	@Override
	public int insertReply(ReplyVO replyVO) {
		return replyMapper.insertReply(replyVO);
	}

	@Override
	public int updateReply(ReplyVO replyVO) {
		return replyMapper.updateReply(replyVO);
	}

	@Override
	public int deleteReply(String rpyNo) {
		return replyMapper.deleteReply(rpyNo);
	}

	@Override
	public ReplyVO selectReply(String rpyNo) {
		return replyMapper.selectReply(rpyNo);
	}

	@Override
	public List<ReplyVO> selectReplyList(String bdNo) {
		//필요한 로직을 추가할 수 있음
		return replyMapper.selectReplyList(bdNo);
	}

	@Override
	public List<ReplyVO> selectReplyList2(String bdNo) {
		return replyMapper.selectReplyList2(bdNo);
	}

	@Override
	public int selectReplyListCnt(String bdNo) {
		return replyMapper.selectReplyListCnt(bdNo);
	}

	@Override
	public int deleteReply2(String bdNo) {
		return replyMapper.deleteReply2(bdNo);
	}
}
