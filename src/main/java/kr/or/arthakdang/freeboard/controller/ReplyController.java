package kr.or.arthakdang.freeboard.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.arthakdang.freeboard.domain.FreeboardVO;
import kr.or.arthakdang.freeboard.domain.PageCondDTO;
import kr.or.arthakdang.freeboard.domain.ReplyVO;
import kr.or.arthakdang.freeboard.service.ReplyService;
import lombok.extern.slf4j.Slf4j;


@Slf4j
@RequestMapping("/reply")
@Controller
public class ReplyController {
	
	@Autowired
	private  ReplyService replyService;

	@RequestMapping(value = "/write", method = RequestMethod.GET)
	public void getReplyView(@RequestParam("bdNo") String bdNo, Model model) {
		
		ReplyVO replyVO = replyService.selectReply(bdNo);
		
		model.addAttribute("replyVO", replyVO);
		
	}
	
	//보내주는거
	@PostMapping(value = "/write",produces = "application/json; charset=utf-8")
	public String postReply(@RequestParam("bdNo") String bdNo, Model model, ReplyVO replyVO, @ModelAttribute PageCondDTO pageCondDTO) {
		//replyVO : ReplyVO(rpyNo=0, bdNo=fbd00171, memNm=null, rpyCnt=테스트..., rpyWtDt=null, rpyMdDt=null, memId=20220615103642)
		log.info("replyVO : " + replyVO.getMemId() + " hiyaho");
		//pageCondDTO : PageCondDTO(pageNum=1, pageSize=10, pageRange=10)
		log.info("pageCondDTO : " + pageCondDTO.toString());
		
		int result = replyService.insertReply(replyVO);
		
		
		
		
		return "redirect:/freeboard/detail?bdNo="+replyVO.getBdNo()+"&pageNum="+pageCondDTO.getPageNum()+"&pageSize="+pageCondDTO.getPageSize();
	}
	
	@ResponseBody
	@PostMapping(value = "/update", produces = "application/json; charset=utf-8")
	public String postReplyUpdate(@RequestBody ReplyVO replyVO) {
			log.info("replyVO > " + replyVO);
			replyService.updateReply(replyVO);
		
		return "freeboard/detail";
	}

	@ResponseBody
	@PostMapping("/delete")
	public String postReplyDelete(@RequestBody ReplyVO replyVO) {
		
		replyService.deleteReply(replyVO.getRpyNo());
		
		return "success";
		
	}

	
}
