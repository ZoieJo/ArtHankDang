package kr.or.arthakdang.crelecture.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.arthakdang.crelecture.domain.CursVO;
import kr.or.arthakdang.crelecture.domain.InteattchVO;
import kr.or.arthakdang.crelecture.domain.LecturePlanVO;
import kr.or.arthakdang.crelecture.domain.SearchInfoVO;
import kr.or.arthakdang.crelecture.domain.TcrDtlVO;
import kr.or.arthakdang.mapper.CreLectureMapper;

@Service
public class LectureImpl implements LectureService {

	@Autowired
	CreLectureMapper crelec;
	
	/* 1. 강의실 정보 */
	@Override
	public List<LecturePlanVO> selectFaciInfo() {
		return crelec.selectFaciInfo();
	}

	/* 2. 강의 계획 생성 */
	@Override
	public int insertLecPn(LecturePlanVO lecPnVO) {
		return crelec.insertLecPn(lecPnVO);
	}

	/* 3. 업로드 파일 정보 저장 */
	@Override
	public int insertFile(InteattchVO inteAttVO) {
		return crelec.insertFile(inteAttVO);
	}
	
	/* 4. 내 강의 계획 가져오기 */
	@Override
	public List<LecturePlanVO> selectPnList(SearchInfoVO siVO) {
		return crelec.selectPnList(siVO);
	}
	
	/* 5. 강의 계획 모두 가져오기 */
	@Override
	public List<LecturePlanVO> selectPnAllList(SearchInfoVO siVO) {
		return crelec.selectPnAllList(siVO);
	}
	
	/* 6. 승인된 계획서의 강의만 등록 + 8.번이랑 같이 이루어짐*/
	@Override
	public int insertCurs(CursVO cursVO) {
		return crelec.insertCurs(cursVO);
	}

	/* 7. 승인된 계획서 정보 가져오기 */
	@Override
	public LecturePlanVO selectOkPnVO(String pnNo) {
		return crelec.selectOkPnVO(pnNo);
	}

	/* 8. 계획서 넣을 때, 시간 상세 정보도 같이 넣기 + 6.번이랑 같이 이루어짐*/
	@Override
	public int insertCursTM(CursVO cursVO) {
		return crelec.insertCursTM(cursVO);
	}

	/*  9. 강의 넣을 때, 해당 계획서를 쓴 교원의 과목 가져오기 */
	@Override
	public TcrDtlVO selectSubject(String tcrId) {
		return crelec.selectSubject(tcrId);
	}

	/* 10. 강의 계획 상세보기 */
	@Override
	public LecturePlanVO selectPnDtl(String curspnNo) {
		return crelec.selectPnDtl(curspnNo);
	}

	/* 11. 강의 계획서 승인 전 삭제 */
	@Override
	public int deleteCurspn(String curspnNo) {
		return crelec.deleteCurspn(curspnNo);
	}

	/* 12. 승인된 강의 계획서 번호 가져오기 */
	@Override
	public List<String> selectPnNo() {
		return crelec.selectPnNo();
	}

	/* 13. 강의 썸네일 정보 저장 */
	@Override
	public int insertThumbnail(InteattchVO inteAttVO) {
		return crelec.insertThumbnail(inteAttVO);
	}

	/* 14. 강의 계획 변경 */
	@Override
	public int updateCurspn(LecturePlanVO lecPnVO) {
		return crelec.updateCurspn(lecPnVO);
	}

	
	/* 15. test */
	@Override
	public int updateJava() {
		return crelec.updateJava();
	}
	
	
	

}
