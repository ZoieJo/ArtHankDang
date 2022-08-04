package kr.or.arthakdang.cslrg.service;

import java.util.List;

import kr.or.arthakdang.cslrg.domain.CslrgPageCondDTO;
import kr.or.arthakdang.cslrg.domain.CslrgVO;
import kr.or.arthakdang.notice.domain.PageCondDTO;
import kr.or.arthakdang.studentmanagement.domain.StudentVO;


public interface CslrgService {

//상담일지	 
	public int insertCslrg(CslrgVO vo);
	public int updateCslrg(CslrgVO vo);
	public int deleteCslrg(String cslrgNo);
	public CslrgVO selectCslrg(String cslrgNo);
	public List<CslrgVO> CslList();
	public List<String> cslTimeList(String r_date);
	public List<CslrgVO> cslrgList(String stuId);

	
//전체 상당내역 수 구하는 메소드
	public int countCslrgNm(String keyword);

//페이지별 상담정보 리스트를  불러오는 메소드
	public List<CslrgVO> getCountCslrgListPage(CslrgPageCondDTO cslrgPageCondDTO);
	
	
//상담내역관리 관련----------------------------------------------------------------------	
		public List<String> NewCslTimeList(String r_date);

		public int updateNewCslrg(CslrgVO vo);
	
	// 상담신청현황 목록 조회
		public List<CslrgVO> cslcdList(CslrgPageCondDTO cslrgPageCondDTO);

		// 상담관리 상담현황 수정
		public int updateCslrcd(CslrgVO vo);
		
		
		//상담 결과 내용 수정
		public int cslrgResultCnt(CslrgVO vo);
		
//신규상담신청---------------------
		public int newCslrgInsert(CslrgVO vo);
		
//상담결과 목록---------------------
		public List<CslrgVO> cslcdSubList(CslrgPageCondDTO cslrgPageCondDTO);

//신규상담목록
		public List<CslrgVO> newCslrgList(CslrgPageCondDTO cslrgPageCondDTO);
	
//신규 상담 내역 삭제
		public int deleteNewCslrg(String cslrgNo);
		
//신규 상당내역 수 구하는 메소드
		public int countNewCslrgNm(String keyword);		
		
//선생:상담신청관리 수 구하는 메소드
		public int countCslrdCnt(String keyword);
		
//선생:상담신청결과 수 구하는 메소드
		public int countSubList(String keyword);
		
}