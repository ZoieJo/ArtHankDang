package kr.or.arthakdang.freeboard.service;

import java.util.List;

import kr.or.arthakdang.freeboard.domain.ReplyVO;

public interface ReplyService {
	public int insertReply(ReplyVO replyVO);

	public int updateReply(ReplyVO replyVO);

	public int deleteReply(String rpyNo);

	public ReplyVO selectReply(String bdNo);
	
	public int deleteReply2(String bdNo);

	public List<ReplyVO> selectReplyList(String bdNo);

	public List<ReplyVO> selectReplyList2(String bdNo);

	public int selectReplyListCnt(String bdNo);
}
