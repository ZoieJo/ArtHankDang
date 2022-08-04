package kr.or.arthakdang.freeboard.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.collections.map.HashedMap;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.or.arthakdang.freeboard.domain.FreeboardVO;
import kr.or.arthakdang.freeboard.domain.LikesVO;
import kr.or.arthakdang.freeboard.domain.PageCondDTO;
import kr.or.arthakdang.freeboard.domain.PageDTO;
import kr.or.arthakdang.freeboard.domain.ReplyVO;
import kr.or.arthakdang.freeboard.service.FreeboardService;
import kr.or.arthakdang.freeboard.service.LikesService;
import kr.or.arthakdang.freeboard.service.ReplyService;
import kr.or.arthakdang.mapper.FreeboardMapper;
import kr.or.arthakdang.mapper.LikesMapper;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/freeboard")
@Slf4j
public class FreeboardController {
	
	@Autowired
	FreeboardService freeboardService;
	
	@Autowired
	LikesService likesService;
	
	@Autowired
	ReplyService replyService;
	
	//전체 게시판 리스트
	@GetMapping("/main")
	public String getList(Model model,PageCondDTO pageCondDTO) {
		
		log.info("ck: " + pageCondDTO.getPageNum());
		log.info("ck: " + pageCondDTO.getPageSize());
		
		PageDTO pageDTO = new PageDTO(pageCondDTO, freeboardService.selectBoardListCnt());
		List<FreeboardVO> freeboardList = freeboardService.selectBoardPage(pageCondDTO);
		
		model.addAttribute("list", freeboardList);
		model.addAttribute("pageDTO",pageDTO); 
		
		return "freeboard/mainFreeboard";
	}
	
	//게시글 쓰기 작성폼
	@GetMapping("/write")
	public String getWrite(Model model) {
		return "freeboard/writeForm";
	}
	
	//게시글 쓰기 작성하고 나서 작성완료 버튼 누르면 메인화면 보여주기
	@PostMapping("/write")
	public String postWrite(FreeboardVO vo, Model model, String pageNum, String pageSize) {
		//작성자 아이디 가져오기(이름 ㄴㄴ임)
		SecurityContext secContext = SecurityContextHolder.getContext();
		String username = secContext.getAuthentication().getName();
		
		log.info("작성자 아이디 : " + username);
		vo.setBdWTR(username);
		
		model.addAttribute("pageNum", pageNum);
		model.addAttribute("pageSize", pageSize);
		
		freeboardService.insertFreeboard(vo);	
		return "redirect:/freeboard/main";
	}
	
	//게시글 상세보기
	@GetMapping("/detail")
	public String getDetail(String bdNo, Model model, String pageNum, String pageSize, HttpServletRequest request, HttpServletResponse response) {
		log.info("받은 게시글 번호 : " + bdNo);
		FreeboardVO freeboardVO = freeboardService.selectBoard(bdNo);
		List<ReplyVO> replyVO = replyService.selectReplyList(bdNo);
		//쿠키에 기존에 접속했던 게시물의 no를 넣어놓음(1시간동안)
		//detail에 들어가기 전에 쿠키를 확인하여 쿠키에 NO이 있다고 하면 조회수 증가하지 않는다.
		Cookie oldCookie = null;
	    Cookie[] cookies = request.getCookies();
	    if (cookies != null) {
	        for (Cookie cookie : cookies) {
	            if (cookie.getName().equals("BoardNO")) {
	                oldCookie = cookie;
	            }
	        }
	    }
	    if (oldCookie != null) {
	        if (!oldCookie.getValue().contains("[" + bdNo + "]")) {
	        	freeboardService.countView(bdNo);
	            oldCookie.setValue(oldCookie.getValue() + "_[" + bdNo + "]");
	            oldCookie.setPath("/");
	            oldCookie.setMaxAge(60 * 60);
	            response.addCookie(oldCookie);
	        }
	    } else {
	    	freeboardService.countView(bdNo);
	        Cookie newCookie = new Cookie("BoardNO","[" + bdNo + "]");
	        newCookie.setPath("/");
	        newCookie.setMaxAge(60 * 60);
	        response.addCookie(newCookie);
	    }
	    
		model.addAttribute("likesCount", likesService.selectCountLike(bdNo));
		model.addAttribute("freeboardVO", freeboardVO);
		model.addAttribute("pageNum", pageNum);
		model.addAttribute("pageSize", pageSize);
		model.addAttribute("replyList", replyVO);
		
		return "freeboard/freeboardListDetail";
	}
	
	@PostMapping(value="/detail",produces = "application/json; charset=utf-8")
	@ResponseBody
	public int postDetail(@RequestBody Map<String,String> map, Model model,LikesVO likesVo) {
		log.info("map" + map);
		log.info("memId" + map.get("memId"));
		likesVo.setBdNo(map.get("bdNo"));
		likesVo.setMemId(map.get("memId"));
		log.info("bdNo" + likesVo.getBdNo());
		log.info("bdNo" + likesVo.getMemId());
		/*
		 * 이미 좋아요를 누른적이 있는지 체크?
		 * 없다면 Insert하고 증가
		 */
		if(likesService.checkLike(likesVo) == 0){			
			likesService.insertLike(likesVo);
		} else {
			likesService.deleteLike(likesVo);
		}
		
		log.info("vo");
		return likesService.selectCountLike(likesVo.getBdNo());
	}
	
	//게시글 삭제
	@PostMapping(value = "/delete")
	@ResponseBody
	public String getDelete(@RequestBody Map<String, String> myMap) {
		log.info("hiyaho: " + myMap);
		
		//작성자 아이디 가져오기(이름 ㄴㄴ임)
		SecurityContext secContext = SecurityContextHolder.getContext();
		String username = secContext.getAuthentication().getName();
		
		log.info("작성자 아이디 : " + myMap.get("memId"));
		
		FreeboardVO freeboardVO = freeboardService.selectBoard(myMap.get("bdNo"));
		
		String boardWriter = freeboardVO.getBdWTR();
		
//		if(!boardWriter.equals(username)) {
//			//return "redirect:detail?bdNo="+freeboardVO.getBdNo(); // AJAX일 땐 이따구로 쓰면 안됨,
//			return "NG";
//		}

		freeboardService.deleteFreeboard(myMap.get("bdNo"));
		return "OK";
	}
	
	@GetMapping("/update")
	public String getUpdate(String bdNo, Model model, String pageNum, String pageSize) {
		
		//작성자 아이디 가져오기(이름 ㄴㄴ임)
		SecurityContext secContext = SecurityContextHolder.getContext();
		String username = secContext.getAuthentication().getName();
		
		log.info("작성자 아이디 : " + username);
		
		FreeboardVO freeboardVO = freeboardService.selectBoard(bdNo);
		
		String boardWriter = freeboardVO.getBdWTR();
		
//		if(!boardWriter.equals(username)) {
//			return "redirect:detail?bdNo="+freeboardVO.getBdNo();
//		}
		
		model.addAttribute("freeboardVO", freeboardVO);
		model.addAttribute("pageNum", pageNum);
		model.addAttribute("pageSize", pageSize);
		
		return "freeboard/updateForm";
	}	
	
	
	@PostMapping("/update")
	public String postUpdate(FreeboardVO vo, RedirectAttributes rattr, String pageNum, String pageSize) {

		//현재 로그인된 사용자 아이디 가져오기(이름 ㄴㄴ임)
		SecurityContext secContext = SecurityContextHolder.getContext();
		String username = secContext.getAuthentication().getName();
		
		log.info("작성자 아이디 : " + username);
		
		String bdNo = vo.getBdNo();
		// 입력받은 글번호로 조회한 게시글정보와 시도하는 이용자 정보가 타당한지 비교
		FreeboardVO checkBoardVO = freeboardService.selectBoard(bdNo);
		String boardWriter = checkBoardVO.getBdWTR(); // hidden으로 받은 글번호의 게시글 작성자id

		freeboardService.updateFreeboard(vo);
		
		return "redirect:detail?bdNo="+vo.getBdNo()+ "&pageNum="+ pageNum + "&pageSize=" + pageSize ;
	}
	
}
