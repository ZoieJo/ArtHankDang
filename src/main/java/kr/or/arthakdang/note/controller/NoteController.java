package kr.or.arthakdang.note.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.or.arthakdang.note.domain.EmpVO;
import kr.or.arthakdang.note.domain.NoteVO;
import kr.or.arthakdang.note.domain.PageDTO;
import kr.or.arthakdang.note.service.NoteService;
import kr.or.arthakdang.security.annotation.CurrentUser;
import kr.or.arthakdang.security.user.CustomUser;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/note")
@Slf4j
public class NoteController {
	
	@Autowired
	NoteService ns;
	
	// 로그인 한 아이디!!
	String myId;
	
	/* 쪽지 페이지 출력 (+ 쪽지 보내는 폼) */
	@GetMapping("/write")
	public String getNote(Model model, @CurrentUser CustomUser user) {
		
		// 로그인 정보, 내 아이디
		model.addAttribute("myId", user.getUsername());
		
		// 직원리스트
		model.addAttribute("emplist", ns.empList(myId));
		
		return "note/note";
	}
	
	/* 받은 쪽지함 출력 */
	@GetMapping("/rvNte")
	public String getRvNte(Model model, @CurrentUser CustomUser user) {
		
		// 현재 로그인한 아이디
		model.addAttribute("myId", user.getUsername());
		
		// 직원 리스트
		model.addAttribute("emplist", ns.empList(myId));
		
		// 받은 쪽지함으로 바로 가기 변수!
		String goRcvBox = "go";
		model.addAttribute("goRcvBox", goRcvBox);
		
		return "note/note";
	}
	
	int rst; // 쪽지 결과
	/* 쪽지 보내기 */
	@PostMapping("/send")
	public String postNote(NoteVO nv, RedirectAttributes rattr) {
		log.info("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@" + nv.toString());
		log.info("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@" + nv.getNteRc().toString());

		// 쪽지 보내기
		String empList = nv.getNteRc().toString();
		log.info("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@" + empList.split(",").length);
		int len = empList.split(",").length; // 길이는?
		if(len > 0) {
			log.info("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ + 보내는이가 여려명 이군요!!");
			for (int i = 0; i < len ; i++) {
				nv.setNteRc(empList.split(",")[i]);
				log.info("확인" + nv);
				rst += ns.writeNote(nv);
			}
		} else {
			rst = ns.writeNote(nv);
		}
		
		String msg = "실패";
		if(rst>0) {msg = "성공적으로 쪽지를 보냈습니다.";}
		rattr.addFlashAttribute("msg", msg);
		return "redirect:/note/write";
	}
	
	
	/* 보낸 쪽지함 ajax */
	@PostMapping(value = "/stNte", produces = "application/json;charset=UTF-8")
	@ResponseBody
	public Map<String, Object> postStNte(@RequestBody Map<String,String> mmap) {
		// 값
		String myId =  mmap.get("l_myId");
		int nowPage =  Integer.parseInt(mmap.get("nowPage"));
		int cntPerPage = Integer.parseInt(mmap.get("cntPerPage"));
		log.info("#############################################"+ myId);
		// 페이징
		int total = ns.sntTtCount(myId); // 받은 쪽지 총 개수
		log.info("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$" + myId);
		int cntPage = 5; // 페이지 숫자의 개수
		
		PageDTO paging = new PageDTO(total, nowPage, cntPerPage, cntPage);
		
		// 리스트 전달 파라미터
		NoteVO ntevo = new NoteVO();
		ntevo.setNteSd(myId);
		ntevo.setStart(paging.getStart());
		ntevo.setEnd(paging.getEnd());
		List<NoteVO> noteList = ns.sntBoxList(ntevo);
		log.info("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ Note List " + noteList);
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("noteList", noteList);
		map.put("paging", paging);
		
		return map;
	}
	
	/* 받은 쪽지함 ajax */
	@PostMapping(value = "/rvNte", produces = "application/json;charset=UTF-8")
	@ResponseBody
	public Map<String, Object> postRvNte(@RequestBody Map<String,String> mmap) {
		// 가져온 값
		String l_myId =  mmap.get("l_myId");
		int nowPage =  Integer.parseInt(mmap.get("nowPage"));
		int cntPerPage = Integer.parseInt(mmap.get("cntPerPage"));
		
		// 페이징
		int total = ns.rcvTtCount(l_myId); // 받은 쪽지 총 개수
		int cntPage = 5; // 페이지 숫자의 개수
		
		PageDTO paging = new PageDTO(total, nowPage, cntPerPage, cntPage);
		log.info(paging.getStart() + "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ 결과값은?");
		log.info(paging.getEnd() + "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ 결과값은?");
		
		// 리스트 전달 파라미터
		NoteVO ntv = new NoteVO();
		ntv.setNteRc(l_myId);
		ntv.setStart(paging.getStart());
		ntv.setEnd(paging.getEnd());
		log.info("@@@@@@@@@@@@@@@ " + ntv + " @@@@@@@@@@@@@@@@@@@@");
		List<NoteVO> noteList = ns.rcvBoxList(ntv);
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("noteList", noteList);
		map.put("paging", paging);
		
		return map;
	}
	
	
	/* 보낸 쪽지 상세*/
	@GetMapping(value = "/sntNteDtl", produces = "application/json;charset=UTF-8")
	@ResponseBody
	public NoteVO getSntDtl(String nteNo) {
		return ns.sntNteDtl(nteNo);
	}
	
	
	/* 받은 쪽지 상세 읽음 변경(최초 1회)*/
	@GetMapping(value = "/rcvNteDtl",  produces = "application/json;charset=UTF-8")
	@ResponseBody
	public NoteVO getRcvDtl(String nteNo) {
		// 받은 쪽지의 번호로 해당 글의 읽음 표시 확인
		String rd = ns.rcvNteDtl(nteNo).getNteRed();
		log.info("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ 받은쪽지상세 "+rd);
		// 읽음 변경
		if(rd.equals("N")) {
			ns.changeRed(nteNo);
		}
		return ns.rcvNteDtl(nteNo);
	}
	
	/* 보낸 쪽지 개별 삭제(히든) */
	@GetMapping(value = "/sntNteDtlDel", produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String getSdNteDel(String nteNo) {
		log.info("@@@@@@@@@@@@@@@@@@@@@@ 보낸 쪽지 개별 삭제 컨트롤러 @@@@@@@@@@@@@@@@@@@@@@@@@@");
		int rst = ns.changeSdDel(nteNo);
		String msg = "알 수 없는 명령...";
		if(rst==1) msg = "보낸 쪽지가 삭제되었습니다.";
		return msg;
	}
	
	
	/* 받은 쪽지 개별 삭제(히든) */
	@GetMapping(value = "/rcvNteDtlDel", produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String getRvNteDel(String nteNo) {
		int rst = ns.changeRcDel(nteNo);
		String msg = "알 수 없는 명령...";
		if(rst==1) msg = "받은 쪽지가 삭제되었습니다.";
		return msg;
	}
	
	/* 보낸 쪽지 일괄 삭제 */
	@PostMapping(value = "/sntAllDel", produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String getSdAllDel(@RequestBody Map<String, List<String>> map) {
		int rst = 0;
		List<String> nteList = map.get("nteNoList");
		
		/* 아래 것도 실행됨*/
//		for (String string : nteList) {
//			rst += ns.changeSdDel(string);
//		}

		rst = ns.changeSdAllDel(nteList); // 통채로 배열 집어 넣기
		
		String msg = "알 수 없는 명령...";
		if(rst>0) msg = "보낸 쪽지가 모두 삭제되었습니다.";
		return msg;
	}
	
	/* 받은 쪽지 일괄 삭제 */
	@PostMapping(value = "/rcvAllDel")
	@ResponseBody
	public String getRcAllDel(@RequestBody Map<String, List<String>> map) {
		int rst = 0;
		List<String> nteList = map.get("nteRcvList");

		rst = ns.changeRcAllDel(nteList); // 통채로 배열 집어 넣기
		
		String msg = "알 수 없는 명령...";
		if(rst>0) msg = "받은 쪽지가 모두 삭제되었습니다.";
		return msg;
	}
	
}