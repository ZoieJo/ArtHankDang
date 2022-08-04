package kr.or.arthakdang.note.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.arthakdang.mapper.NoteMapper;
import kr.or.arthakdang.note.domain.EmpVO;
import kr.or.arthakdang.note.domain.NoteVO;


@Service
//@Slf4j
public class NoteImpl implements NoteService {

	@Autowired
	NoteMapper nm;
	
	/* 쪽지 작성 */
	@Override
	public int writeNote(NoteVO nv) {
		return nm.writeNote(nv);
	}

	/* 보낼 이 리스트 (나 제외) */
	@Override
	public List<EmpVO> empList(String myId) {
		return nm.empList(myId);
	}
	
	/* 부서 종류 구하기 */
	@Override
	public List<EmpVO> getDep() {
		return nm.getDep();
	}

	
	
	
	/* 받은 쪽지 쪽지 총 개수 */
	@Override
	public int rcvTtCount(String myId) {
		return nm.rcvTtCount(myId);
	}
	/* 받은 쪽지 리스트 */
	@Override
	public List<NoteVO> rcvBoxList(NoteVO nv) {
		return nm.rcvBoxList(nv);
	}
	/* 안 읽은 받은 쪽지 리스트*/
	@Override
	public List<NoteVO> justRcvList(String myId) {
		return nm.justRcvList(myId);
	}
	
	
	
	
	/* 보낸 쪽지 쪽지 총 개수 */
	@Override
	public int sntTtCount(String myId) {
		return nm.sntTtCount(myId);
	}
	/* 보낸 쪽지 리스트 */
	@Override
	public List<NoteVO> sntBoxList(NoteVO nv) {
		return nm.sntBoxList(nv);
	}
	
	
	
	
	/* 보낸 쪽지 상세 */
	@Override
	public NoteVO sntNteDtl(String nteNo) {
		return nm.sntNteDtl(nteNo);
	}
	
	/* 받은 쪽지 상세 */
	@Override
	public NoteVO rcvNteDtl(String nteNo) {
		return nm.rcvNteDtl(nteNo);
	}
	
	/* 받은 쪽지 읽음 변경*/
	@Override
	public int changeRed(String nteNo) {
		return nm.changeRed(nteNo);
	}

	/* 보낸이가 쪽지를 삭제 */
	@Override
	public int changeSdDel(String nteNo) {
		return nm.changeSdDel(nteNo);
	}

	/* 받은이가 쪽지를 삭제 */
	@Override
	public int changeRcDel(String nteNo) {
		return nm.changeRcDel(nteNo);
	}

	/* 보낸이가 쪽지를 일괄 삭제*/
	@Override
	public int changeSdAllDel(List<String> nteList) {
		return nm.changeSdAllDel(nteList);
	}

	/* 받은이가 쪽지를 일괄 삭제*/
	@Override
	public int changeRcAllDel(List<String> nteList) {
		return nm.changeRcAllDel(nteList);
	}

}
