package kr.or.arthakdang.crelecture.service;

import java.util.List;

import kr.or.arthakdang.crelecture.domain.CursVO;
import kr.or.arthakdang.crelecture.domain.InteattchVO;
import kr.or.arthakdang.crelecture.domain.LecturePlanVO;
import kr.or.arthakdang.crelecture.domain.SearchInfoVO;
import kr.or.arthakdang.crelecture.domain.TcrDtlVO;

public interface LectureService {
	
	// 1. 강의실 정보
	public List<LecturePlanVO> selectFaciInfo();
	
	// 2. 강의 계획 생성
	public int insertLecPn(LecturePlanVO lecPnVO);
	
	// 3. 파일 정보 넣기
	public int insertFile(InteattchVO inteAttVO); 
	
	// 4. 내 강의 계획 가져오기
	public List<LecturePlanVO> selectPnList(SearchInfoVO siVO);
	
	// 5. 강의 계획 모두 가져오기
	public List<LecturePlanVO> selectPnAllList(SearchInfoVO siVO);
	
	// 6. 승인된 계획서의 강의만 등록
	public int insertCurs(CursVO cursVO);
	
	// 7. 승인된 계획서 정보 가져오기
	public LecturePlanVO selectOkPnVO(String pnNo);
	
	// 8. 계획서 넣을 때, 시간 상세 정보도 같이 넣기
	public int insertCursTM(CursVO cursVO);	

	// 9. 강의 넣을 때, 해당 계획서를 쓴 교원의 과목 가져오기
	public TcrDtlVO selectSubject(String tcrId);
	
	// 10. 강의 계획 상세보기
	public LecturePlanVO selectPnDtl(String curspnNo);
	
	// 11. 강의 계획 승인전 삭제
	public int deleteCurspn(String curspnNo);
	
	// 12. 승인된 강의 계획서 번호가져오기
	public List<String> selectPnNo();
	
	// 13. 강의 생성 후 썸네일 파일 정보 저장
	public int insertThumbnail(InteattchVO inteAttVO);
	
	// 14. 강의 계획서 변경
	public int updateCurspn(LecturePlanVO lecPnVO);
	
	// 15. 테스트 변경
	public int updateJava();
}
