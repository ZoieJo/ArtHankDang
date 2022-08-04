package kr.or.arthakdang.message.controller;

import java.io.UnsupportedEncodingException;
import java.net.URISyntaxException;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.tomcat.util.json.ParseException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.fasterxml.jackson.core.JsonProcessingException;

import kr.or.arthakdang.message.domain.LectureVO;
import kr.or.arthakdang.message.domain.MessageDTO;
import kr.or.arthakdang.message.domain.PageDTO;
import kr.or.arthakdang.message.service.MessageService;
import kr.or.arthakdang.note.service.NoteService;
import kr.or.arthakdang.security.annotation.CurrentUser;
import kr.or.arthakdang.security.user.CustomUser;
import kr.or.arthakdang.sens.api.domain.MessagesRequestDto;
import kr.or.arthakdang.sens.api.service.SmsService;
import lombok.extern.slf4j.Slf4j;

/**
 * 교원의 메시지 전송 컨트롤러
 * @author jerry
 */
@Controller
@Slf4j
@RequestMapping("/msg/teacher")
public class MessageController2 {
	
	// 문자 메시지 보내는 서비스
	@Autowired
	SmsService smss;
	
	// 보낸 문자 메시지 기록 서비스
	@Autowired
	MessageService ms;
	
	/* [교원] 메시지 전송 page GET */
	@GetMapping("/page")
	public String getMsgFormTeacher(@CurrentUser CustomUser user, Model model) {
		// 내 아이디 보내기
		String myId = user.getUsername();
		model.addAttribute("myId", myId);
		
		// 내 강의 듣는 학생 주소록 리스트 -> 내강의 별, 학생 출력
		List<LectureVO> stuList =  ms.selectStuList(myId);
		
		model.addAttribute("stuList", stuList);
		log.info("@@@@@@@@@@@@@@ stuList @@@@@@@@@@@@@ " + stuList);
		
		return "msg/teacherpage";
	}
	
	/* [교원] 메시지 전송 list GET */
	@GetMapping("/list")
	public String getMsgListTeacher(@CurrentUser CustomUser user, Model model, String nowPage, String keyword, String type) {
		// 내 아이디 보내기
		String myId = user.getUsername();
		model.addAttribute("myId", myId);
		
		// 페이징 관련 정보 - 번호, 제목, 내용, 날짜, (삭제), 페이징 뿌리기
		PageDTO setting = new PageDTO(); // 토탈 구하기 위한 세팅값
		setting.setMsgSd(myId);
		setting.setType(type);
		setting.setKeyword(keyword);
		int total = ms.total(setting);
		if(nowPage==null) {
			nowPage = "1";
		}
		int cntPerPage = 10;
		int cntPage = 5;
	
		// 페이징
		PageDTO pDto = new PageDTO(total, Integer.parseInt(nowPage), cntPerPage, cntPage, type, keyword); // null -> 타입
		pDto.setMsgSd(myId); // 아이디도 같이 넣어주기
		log.info("페이징하기위한 파라미터 정보는?????????????? "+ pDto);
		
		// 페이징 전달
		model.addAttribute("paging", pDto);
		
		// 내가 보낸 메시지 리스트 뿌리기
		List<MessageDTO> msgList = ms.selectMsg(pDto);
		log.info("message list @@@@@@@@@@@@@@@@@@@@@@@@" + msgList);
		model.addAttribute("msgList", msgList);
		
		return "msg/teacherlist";
	}
	
	/* [교원] 메시지 전송 list post */
	@PostMapping("/list")
	public String postMsgListTeacher(String myId, Model model, 
			String nowPage, String keyword, String type) {
//		log.info("@@@@@@@@@@@@@@@@@@@@ nowPage " + nowPage);
//		log.info("@@@@@@@@@@@@@@@@@@@@ keyword " + keyword);
//		log.info("@@@@@@@@@@@@@@@@@@@@ type " + type);

		// 토탈 구하기 위한 세팅값
		PageDTO setting = new PageDTO();
		setting.setMsgSd(myId);
		setting.setType(type);
		setting.setKeyword(keyword);
		int total = ms.total(setting);
		
		if(nowPage==null) { nowPage = "1"; }
		int cntPerPage = 10;
		int cntPage = 5;
		
		// 페이징
		PageDTO pDto = new PageDTO(total, Integer.parseInt(nowPage), cntPerPage, cntPage, type, keyword); // null -> 타입
		pDto.setMsgSd(myId); // 아이디도 같이 넣어주기
		log.info("페이징하기위한 파라미터 정보는?????????????? "+ pDto);
		
		// 페이징 전달
		model.addAttribute("paging", pDto);
		
		// 내가 보낸 메시지 리스트 뿌리기
		List<MessageDTO> msgList = ms.selectMsg(pDto);
		log.info("message list @@@@@@@@@@@@@@@@@@@@@@@@" + msgList);
		model.addAttribute("msgList", msgList);
		
		return "msg/teacherlist";
	}
	
	
	/* 메시지 상세 페이지 Modal */
	@GetMapping(value = "/detail", produces = "application/json;charset=UTF-8")
	@ResponseBody
	public MessageDTO getMsgDetail(String msgNo) {
		log.info("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ 넘어온 번호 정보(상세)" + msgNo);
		log.info("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@" + ms.detailMsg(msgNo));
		return ms.detailMsg(msgNo);
	}
	
	
	/* 메시지 삭제 */
	@PostMapping("/delete")
	public String getMsgDelete(String msgNo, RedirectAttributes rattr) {
		log.info("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ 넘어온 번호 정보(단일삭제)" + msgNo);
		String msg = "알 수 없는 오류로 메시지(MMS)를 삭제하지 못했습니다.";
		// 메시지 삭제
		int rst = ms.deleteMsg(msgNo);
		if(rst==1) {
			msg = "해당 메시지(MMS)를 삭제하였습니다.";
		}
		rattr.addFlashAttribute("msg", msg);
		return "redirect:/msg/teacher/list";
	}
	
	/* 메시지 일괄 삭제 */
	@PostMapping("/allDelete")
	public String getAllDelete(String msgNo, RedirectAttributes rattr) {
		log.info("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ 넘어온 번호 정보(일괄삭제)" + msgNo);
		
		// 삭제하기
		String msgNoList[] = msgNo.split(",");
		log.info("@@@@@@@@@@@@@@@@@@@@ 길이 " + msgNoList.length);
		
		int rst = 0;
		for (String msgN : msgNoList) {
			ms.deleteMsg(msgN);
			rst++;
		}
		
		// 결과 메시지
		String msg = "알 수 없는 오류로 메시지(MMS)를 삭제하지 못했습니다.";
		if(rst>0) {
			msg = "해당 메시지(MMS)를 삭제하였습니다.";
		}
		rattr.addFlashAttribute("msg", msg);
		
		return "redirect:/msg/teacher/list";
	}
	
	/* 메시지 보내기 AJAX 처리 + DB입력 */
	@PostMapping(value = "/page", produces = "text/plain;charset=UTF-8")
	@ResponseBody
	public String postMsgPage(@RequestBody Map<String,String> data, @CurrentUser CustomUser user) {
		// 메시지 보낸 결과 정보
		String msg = "";
		
		// 보내는 메시지 정보
		String msgRcNm = data.get("msgRcNm"); // 이름
		String msgPhNm = data.get("msgPhNm"); // 전번
		String msgCnt = data.get("msgCnt"); // 내용
		String[] phNoList = msgPhNm.split(",");
		log.info("길이는?  " + phNoList.length);
		
		// 그룹 문자 보내기
		if(phNoList.length>1) {
			log.info("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ 단체문자 보내기");
			List<MessagesRequestDto> groupMsg = new ArrayList<MessagesRequestDto>();
			for (String phNo : phNoList) {
				MessagesRequestDto msd = new MessagesRequestDto(phNo, msgCnt);
				groupMsg.add(msd);
			}
			try {
				MessageDTO msgDto = new MessageDTO();
				msgDto.setMsgCmcd("MSG02");
				msgDto.setMsgCnt(msgCnt);
				msgDto.setMsgRc(msgRcNm);
				msgDto.setMsgSd(user.getUsername()); // 전송한 사람 아이디
				ms.insertMsg(msgDto);
				
				smss.sendSmsList(groupMsg); // 전송
				msg = "메시지(MMS)를 보냈습니다.";
				
			} catch (JsonProcessingException | InvalidKeyException | UnsupportedEncodingException
					| NoSuchAlgorithmException | ParseException | URISyntaxException e) {
				e.printStackTrace();
				msg = "메시지를 보내는 중 문제가 발생하였습니다.";
			}
			
		}
		// 단일 문자 보내기
		else {
			try {
				log.info("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ 단일문자 보내기");
				MessageDTO msgDto = new MessageDTO();
				msgDto.setMsgCmcd("MSG01");
				msgDto.setMsgCnt(msgCnt);
				msgDto.setMsgRc(msgRcNm);
				msgDto.setMsgSd(user.getUsername()); // 전송한 사람 아이디
				ms.insertMsg(msgDto); // db에 먼저 보내기
				
				smss.sendSms(msgPhNm, msgCnt); // 전송
				msg = "메시지(MMS)를 보냈습니다.";
				
			} catch (JsonProcessingException | InvalidKeyException | UnsupportedEncodingException | NoSuchAlgorithmException
					| ParseException | URISyntaxException e) {
				e.printStackTrace();
				msg = "메시지를 보내는 중 문제가 발생하였습니다.";
			}
		}
		
		return msg;
	}	

}

