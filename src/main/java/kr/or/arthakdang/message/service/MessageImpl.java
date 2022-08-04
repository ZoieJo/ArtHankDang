package kr.or.arthakdang.message.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.arthakdang.mapper.MessageMapper;
import kr.or.arthakdang.message.domain.LectureVO;
import kr.or.arthakdang.message.domain.MessageDTO;
import kr.or.arthakdang.message.domain.PageDTO;

@Service
public class MessageImpl implements MessageService {

	@Autowired
	MessageMapper mm;
	
	/* 보낸 메시지 기록 */
	@Override
	public int insertMsg(MessageDTO msgDto) {
		return mm.insertMsg(msgDto);
	}

	
	/* 보낸 메시지 기록 가져오기 */
	@Override
	public List<MessageDTO> selectMsg(PageDTO pDto) {
		return mm.selectMsg(pDto);
	}

	
	/* 총 개수 구하기 */
	@Override
	public int total(PageDTO pDto) {
		return mm.total(pDto);
	}

	
	/* 자료 삭제하기 */
	@Override
	public int deleteMsg(String msgNo) {
		return mm.deleteMsg(msgNo);
	}

	
	/* 자료 상세보기 */
	@Override
	public MessageDTO detailMsg(String msgNo) {
		return mm.detailMsg(msgNo);
	}


	/* 강의별 학생 리스트 구하기 */
	@Override
	public List<LectureVO> selectStuList(String myId) {
		return mm.selectStuList(myId);
	}

}
