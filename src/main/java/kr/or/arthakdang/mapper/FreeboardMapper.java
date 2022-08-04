package kr.or.arthakdang.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.arthakdang.freeboard.domain.FreeboardVO;
import kr.or.arthakdang.freeboard.domain.PageCondDTO;

@Mapper
public interface FreeboardMapper {
	
	public int insertFreeboard(FreeboardVO vo);
	
	public int updateFreeboard(FreeboardVO vo);
	
	public int deleteFreeboard(String bdNo);
	
	public int selectBoardListCnt();

	public List<FreeboardVO> selectBoardList();
	
	public FreeboardVO selectBoard(String bdNo);
	
	public void countView(String bdNo);
	
	public int selectBoardTotalCnt();
	
	//지정된  pageSize만큼에 해당되는 page 가져오깅
	public List<FreeboardVO> selectBoardPage(PageCondDTO pageCondDTO);
	
}
