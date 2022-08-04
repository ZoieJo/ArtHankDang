package kr.or.arthakdang.qna.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.arthakdang.qna.domain.QnAVO;
import kr.or.arthakdang.qna.service.QnAService;
import kr.or.arthakdang.security.annotation.CurrentUser;
import kr.or.arthakdang.security.user.CustomUser;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class QnAController {
	
	@Autowired
	private QnAService qnAService;
	
	@GetMapping("/qna")
	public String getQnA(Model model, @CurrentUser CustomUser user) {
		List<QnAVO> qnAList = qnAService.selectQnAList();
		model.addAttribute("qnAList", qnAList);
		model.addAttribute("user", user);
		return "qna/qnaList";
	}
	
	@PostMapping("/qna/write")
	public String postQnAWrite(QnAVO qnAVO) {
		log.info("qnaVO" + qnAVO);
		int result = qnAService.writeQnA(qnAVO);
		return "redirect:/qna";
	}
	
	@PostMapping("/qna/delete")
	public String postQnADelete(QnAVO qnAVO) {
		log.info("qnaVO 삭제 " + qnAVO);
		int result = qnAService.deleteQnA(qnAVO);
		
		return "redirect:/qna";
	}

	@PostMapping("/qna/update")
	public String postQnAUpdate(QnAVO qnAVO) {
		int result = qnAService.updateQnA(qnAVO);
		return "redirect:/qna";
	}
	
	@PostMapping(value = "/qna/qnaInfo", produces = "application/json")
	@ResponseBody
	public QnAVO postQnAInfo(@RequestBody Map<String, String> value) {
		
		QnAVO qnA = qnAService.selectQnA(value.get("bdNo"));
		return qnA;
	}
	
	@PostMapping(value = "/qna/searchQnA", produces = "application/json")
	@ResponseBody
	public List<QnAVO> postSearchQnA(@RequestBody Map<String, String> value) {
		List<QnAVO> searchQnAList = qnAService.searchQnA(value.get("bdTl"));
		return searchQnAList;
	}
}
