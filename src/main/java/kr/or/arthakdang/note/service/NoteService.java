package kr.or.arthakdang.note.service;

import java.util.List;

import kr.or.arthakdang.note.domain.EmpVO;
import kr.or.arthakdang.note.domain.NoteVO;

public interface NoteService {
	
	// 쪽지 작성
	public int writeNote(NoteVO nv);
	
	
	// 직원 명단 리스트 뽑기
	public List<EmpVO> empList(String myId);
	// 부서 종류
	public List<EmpVO> getDep();
	
	
	// 받은 쪽지 총 개수;
	public int rcvTtCount(String myId);
	// 받은 쪽지 리스트 뽑기
	public List<NoteVO> rcvBoxList(NoteVO nv);
	// 안 읽은 받은 쪽지 리스트
	public List<NoteVO> justRcvList(String myId);
	
	
	// 보낸 쪽지 총 개수;
	public int sntTtCount(String myId);
	// 보낸 쪽지 리스트 뽑기
	public List<NoteVO> sntBoxList(NoteVO nv);

	
	// 받은 쪽기 상세
	public NoteVO rcvNteDtl(String nteNo);
	// 보낸 쪽지 상세
	public NoteVO sntNteDtl(String nteNo);
	
	
	// 읽음 표시 변경
	public int changeRed(String nteNo);
	
	
	// 보낸이가 쪽지 삭제
	public int changeSdDel(String nteNo);
	// 받은이가 쪽지 삭제
	public int changeRcDel(String nteNo);
	
	
	// 보낸이가 쪽지 일괄 삭제
	public int changeSdAllDel(List<String> nteList);
	// 보낸이가 쪽지 일괄 삭제
	public int changeRcAllDel(List<String> nteList);
	
}
