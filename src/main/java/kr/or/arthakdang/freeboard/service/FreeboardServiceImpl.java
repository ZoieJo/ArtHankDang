package kr.or.arthakdang.freeboard.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.arthakdang.freeboard.domain.FreeboardVO;
import kr.or.arthakdang.freeboard.domain.PageCondDTO;
import kr.or.arthakdang.mapper.FreeboardMapper;

@Service
public class FreeboardServiceImpl implements FreeboardService{
	
	@Autowired
	FreeboardMapper freeboardMapper;
	
	@Override
	public int insertFreeboard(FreeboardVO vo) {
		return freeboardMapper.insertFreeboard(vo);
	}
	
	public int updateFreeboard(FreeboardVO vo) {
		return freeboardMapper.updateFreeboard(vo);
	}
	
	public int deleteFreeboard(String bdNo) {
		return freeboardMapper.deleteFreeboard(bdNo);
	}

	@Override
	public List<FreeboardVO> selectBoardList() {
		return freeboardMapper.selectBoardList();
	}

	@Override
	public FreeboardVO selectBoard(String bdNo) {
		return freeboardMapper.selectBoard(bdNo);
	}

	@Override
	public void countView(String bdNo) {
		freeboardMapper.countView(bdNo);
	}

	@Override
	public List<FreeboardVO> selectBoardPage(PageCondDTO pageCondDTO) {
		return freeboardMapper.selectBoardPage(pageCondDTO);
	}
	
	@Override
	public int selectBoardTotalCnt() {
		return freeboardMapper.selectBoardTotalCnt();
	}

	@Override
	public int selectBoardListCnt() {
		// TODO Auto-generated method stub
		return freeboardMapper.selectBoardListCnt();
	}

	
}
