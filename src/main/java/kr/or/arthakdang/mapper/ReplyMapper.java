package kr.or.arthakdang.mapper;

import java.util.List;

import kr.or.arthakdang.freeboard.domain.ReplyVO;

public interface ReplyMapper {
	public int insertReply(ReplyVO replyVO);
	public int updateReply(ReplyVO replyVO);
	public int deleteReply(String rpyNo);
	public ReplyVO selectReply(String rpyNo);
	public List<ReplyVO> selectReplyList(String bdNo);
	public List<ReplyVO> selectReplyList2(String bdNo);
	public int selectReplyListCnt(String bdNo);
	public int deleteReply2(String bdNo);
}
