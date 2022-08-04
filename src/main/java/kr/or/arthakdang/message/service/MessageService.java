package kr.or.arthakdang.message.service;

import java.util.List;

import kr.or.arthakdang.message.domain.LectureVO;
import kr.or.arthakdang.message.domain.MessageDTO;
import kr.or.arthakdang.message.domain.PageDTO;

public interface MessageService {
	
	// 내가 보낸 메시지 DB에 기록
	public int insertMsg(MessageDTO msgDto);
	
	// 내가 보낸 메시지 기록 출력 + 페이징 + 키워드
	public List<MessageDTO> selectMsg(PageDTO pDto);
	
	// 총 개수 구하기
	public int total(PageDTO pDto);
	
	// 상세보기
	public MessageDTO detailMsg(String msgNo);

	// 자료 삭제
	public int deleteMsg(String msgNo);
	
	// 강의별 학생 특정 리스트 구하기
	public List<LectureVO> selectStuList(String myId);
}
