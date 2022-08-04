package kr.or.arthakdang.notice.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.or.arthakdang.notice.domain.NoticeVO;
import kr.or.arthakdang.notice.domain.PageCondDTO;
import kr.or.arthakdang.notice.domain.PageDTO;
import kr.or.arthakdang.notice.service.NoticeService;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/notice")
public class NoticeController {
	
	@Autowired
	NoticeService noticeService;
	
	@GetMapping("/main")
	public String getList(Model model, PageCondDTO pageCondDTO) {
		
		log.info("ck: " + pageCondDTO.getPageNum());
		log.info("ck: " + pageCondDTO.getPageSize());
		
		PageDTO pageDTO = new PageDTO(pageCondDTO, noticeService.selectBoardListCnt());
		List<NoticeVO> noticeboardList = noticeService.selectBoardPage(pageCondDTO);
		
		model.addAttribute("list", noticeboardList);
		model.addAttribute("pageDTO",pageDTO); 
		
		return "notice/mainNoticeBoard";
	}
	
	//게시글 상세보기
	@GetMapping("/detail")
	public String getDetail(String bdNo, Model model, String pageNum, String pageSize) {
		log.info("받은 게시글 번호 : " + bdNo);
		NoticeVO noticeVO = noticeService.selectBoard(bdNo);
		
		model.addAttribute("noticeVO", noticeVO);
		model.addAttribute("pageNum", pageNum);
		model.addAttribute("pageSize", pageSize);
		
		return "notice/noticeboardListDetail";
	}
	
	//게시글 쓰기 작성폼
	@GetMapping("/write")
	public String getWrite(Model model) {
		return "notice/noticeboardWriteForm";
	}
	
	//게시글 쓰기 작성하고 나서 작성완료 버튼 누르면 메인화면 보여주기
	@PostMapping("/write")
	public String postWrite(NoticeVO noticeVO,Model model) {
		//작성자 아이디 가져오기(이름 ㄴㄴ임)
		SecurityContext secContext = SecurityContextHolder.getContext();
		String username = secContext.getAuthentication().getName();
		
		log.info("작성자 아이디 : " + username);
		noticeVO.setBdWTR(username);
		
		noticeService.insertNotice(noticeVO);	
		return "redirect:main";
	}
	
	@GetMapping("/update")
	public String getUpdate(String bdNo, Model model) {
		
		//작성자 아이디 가져오기(이름 ㄴㄴ임)
		SecurityContext secContext = SecurityContextHolder.getContext();
		String username = secContext.getAuthentication().getName();
		
		log.info("작성자 아이디 : " + username);
		
		NoticeVO noticeVO = noticeService.selectBoard(bdNo);
		
		String boardWriter = noticeVO.getBdWTR();
		
//		if(!boardWriter.equals(username)) {
//			return "redirect:detail?bdNo="+freeboardVO.getBdNo();
//		}
		
		model.addAttribute("noticeVO", noticeVO);
		return "notice/updateForm";
	}	
	
	
	@PostMapping("/update")
	public String postUpdate(String bdNo, String bdTL, String bdCNT, RedirectAttributes rattr) {
		
		log.info("notice 업데이트 완료!!");
		//현재 로그인된 사용자 아이디 가져오기(이름 ㄴㄴ임)
		SecurityContext secContext = SecurityContextHolder.getContext();
		String username = secContext.getAuthentication().getName();
		
		NoticeVO noticeVO = new NoticeVO();
		noticeVO.setBdTL(bdTL);
		noticeVO.setBdNo(bdNo);
		noticeVO.setBdCNT(bdCNT);
		
		log.info("작성자 아이디 : " + username);
		
		log.info("noticeVO >>>>>>>>> " + noticeVO.toString());
		
		// 입력받은 글번호로 조회한 게시글정보와 시도하는 이용자 정보가 타당한지 비교
		NoticeVO checkNoticeVO = noticeService.selectBoard(bdNo);
		String boardWriter = checkNoticeVO.getBdWTR(); // hidden으로 받은 글번호의 게시글 작성자id

		noticeService.updateNotice(noticeVO);
		
		return "redirect:detail?bdNo="+noticeVO.getBdNo();
	}
		
	//게시글 삭제
	@PostMapping(value = "/delete")
	@ResponseBody
	public String getDelete(@RequestBody Map<String, String> myMap) {
		
		//작성자 아이디 가져오기(이름 ㄴㄴ임)
//		SecurityContext secContext = SecurityContextHolder.getContext();
//		String username = secContext.getAuthentication().getName();
		
//		log.info("작성자 아이디 : " + myMap.get("memId"));
		
//		NoticeVO noticeVO = noticeService.selectBoard(myMap.get("bdNo"));

		noticeService.deleteNotice(myMap.get("bdNo"));
		return "OK";
	}
	
	
}
