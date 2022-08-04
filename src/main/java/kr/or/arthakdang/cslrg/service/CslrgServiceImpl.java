package kr.or.arthakdang.cslrg.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.arthakdang.cslrg.domain.CslrgPageCondDTO;
import kr.or.arthakdang.cslrg.domain.CslrgVO;
import kr.or.arthakdang.mapper.CslrgMapper;
import kr.or.arthakdang.notice.domain.PageCondDTO;

@Service
public class CslrgServiceImpl implements CslrgService {

	@Autowired
	private CslrgMapper cslrgMapper;

	@Override
	public int insertCslrg(CslrgVO vo) {
		return cslrgMapper.insertCslrg(vo);
	}

	@Override
	public int updateCslrg(CslrgVO vo) {
		return cslrgMapper.updateCslrg(vo);
	}

	@Override
	public int deleteCslrg(String cslrgNo) {
		return cslrgMapper.deleteCslrg(cslrgNo);
	}

	@Override
	public CslrgVO selectCslrg(String cslrgNo) {
		return cslrgMapper.selectCslrg(cslrgNo);
	}

	@Override
	public List<CslrgVO> CslList() {
		return cslrgMapper.CslList();
	}

	@Override
	public List<String> cslTimeList(String r_date) {
		return cslrgMapper.cslTimeList(r_date);
	}

	@Override
	public List<CslrgVO> cslrgList(String stuId) {
		return cslrgMapper.cslrgList(stuId);
	}

//------------------------------상담신청 내역	
	@Override
	public List<CslrgVO> cslcdList(CslrgPageCondDTO cslrgPageCondDTO) {
		return cslrgMapper.cslcdList(cslrgPageCondDTO);
	}

	//수정
	@Override
	public int updateCslrcd(CslrgVO vo) {
		return cslrgMapper.updateCslrcd(vo);
	}

	@Override
	public int cslrgResultCnt(CslrgVO vo) {
		return cslrgMapper.cslrgResultCnt(vo);
	}

//신규상담신청	
	@Override
	public int newCslrgInsert(CslrgVO vo) {
		return cslrgMapper.newCslrgInsert(vo);
	}



//신규상담내역 삭제
	@Override
	public int deleteNewCslrg(String cslrgNo) {
		return cslrgMapper.deleteNewCslrg(cslrgNo);
	}

//전체 상담수 가져옴
	@Override
	public int countCslrgNm(String keyword) {
		return cslrgMapper.countCslrgNm(keyword);
	}

	@Override
	public List<CslrgVO> getCountCslrgListPage(CslrgPageCondDTO cslrgPageCondDTO) {		
		return cslrgMapper.getCountCslrgListPage(cslrgPageCondDTO);
	}

	@Override
	public List<CslrgVO> cslcdSubList(CslrgPageCondDTO cslrgPageCondDTO) {
		return cslrgMapper.cslcdSubList(cslrgPageCondDTO);
	}

	@Override
	public List<CslrgVO> newCslrgList(CslrgPageCondDTO cslrgPageCondDTO) {
		return cslrgMapper.newCslrgList(cslrgPageCondDTO);
	}

//신규 상당내역 수 구하는 메소드
	@Override
	public int countNewCslrgNm(String keyword) {		
		return cslrgMapper.countNewCslrgNm(keyword);
	}

//선생:상담신청관리 수 구하는 메소드	
	@Override
	public int countCslrdCnt(String keyword) {
		return cslrgMapper.countCslrdCnt(keyword);
	}

	@Override
	public int countSubList(String keyword) {	
		return cslrgMapper.countSubList(keyword);
	}

	@Override
	public List<String> NewCslTimeList(String r_date) {
		return cslrgMapper.NewCslTimeList(r_date);
	}

	@Override
	public int updateNewCslrg(CslrgVO vo) {
		return cslrgMapper.updateNewCslrg(vo);
	}
}
