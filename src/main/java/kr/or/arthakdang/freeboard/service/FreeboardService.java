package kr.or.arthakdang.freeboard.service;

import java.util.List;

import kr.or.arthakdang.freeboard.domain.FreeboardVO;
import kr.or.arthakdang.freeboard.domain.PageCondDTO;


public interface FreeboardService {
	
	public int insertFreeboard(FreeboardVO vo);
	
	public int updateFreeboard(FreeboardVO vo);
	
	public int deleteFreeboard(String bdNo);
	
	public int selectBoardListCnt();
	
	//전체 리스트 뿌려줄때
	public List<FreeboardVO> selectBoardList();

	//하나만 출력(검색할때)
	public FreeboardVO selectBoard(String bdNo);
	
	public void countView(String bdNo);
	
	public int selectBoardTotalCnt();
	
	public List<FreeboardVO> selectBoardPage(PageCondDTO pageCondDTO);
}
