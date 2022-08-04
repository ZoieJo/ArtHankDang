package kr.or.arthakdang.notice.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.arthakdang.freeboard.domain.FreeboardVO;
import kr.or.arthakdang.mapper.NoticeMapper;
import kr.or.arthakdang.notice.domain.NoticeVO;
import kr.or.arthakdang.notice.domain.PageCondDTO;

@Service
public class NoticeServiceImpl implements NoticeService {
	
	@Autowired
	NoticeMapper noticemapper;
	
	@Override
	public List<NoticeVO> selectBoardPage(PageCondDTO pageCondDTO) {
		// 페이징 된 게시글 리스트
		return noticemapper.selectBoardPage(pageCondDTO);
	}

	@Override
	public int selectBoardListCnt() {
		// 전체 게시판 게시물 수
		return noticemapper.selectBoardListCnt();
	}

	@Override
	public NoticeVO selectBoard(String bdNo) {
		return noticemapper.selectBoard(bdNo);
	}

	@Override
	public int insertNotice(NoticeVO noticeVO) {
		return noticemapper.insertNotice(noticeVO);
	}

	@Override
	public int updateNotice(NoticeVO noticeVO) {
		return noticemapper.updateNotice(noticeVO);
	}

	@Override
	public int deleteNotice(String bdNo) {
		return noticemapper.deleteNotice(bdNo);
	}


	
}
