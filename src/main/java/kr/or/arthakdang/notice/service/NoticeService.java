package kr.or.arthakdang.notice.service;

import java.util.List;

import kr.or.arthakdang.freeboard.domain.FreeboardVO;
import kr.or.arthakdang.notice.domain.NoticeVO;
import kr.or.arthakdang.notice.domain.PageCondDTO;

public interface NoticeService {
	//페이징 된 게시물 리스트
	public List<NoticeVO> selectBoardPage(PageCondDTO pageCondDTO);
	// 총 게시글 수
	public int selectBoardListCnt();
	// 하나의 게시물만 가져오기
	public NoticeVO selectBoard(String bdNo);
	// 글 작성하기	
	public int insertNotice(NoticeVO noticeVO);
	//글 수정하기
	public int updateNotice(NoticeVO noticeVO);
	//글 삭제하기
	public int deleteNotice(String bdNo);	
}
