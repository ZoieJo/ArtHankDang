package kr.or.arthakdang.crelecture.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.arthakdang.crelecture.domain.CursEvaluationVO;
import kr.or.arthakdang.crelecture.domain.CursVO;
import kr.or.arthakdang.crelecture.service.CommonLectureService;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/opensu")
@Slf4j
public class CommonLectureController {
	
	@Autowired
	CommonLectureService cls;
	
	/* 개설된 강의 리스트*/
	@GetMapping("/sulist")
	public String getSuList(Model model) {
		log.info("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ 여기야!!!! ");
		List<CursVO> curslist = cls.selectCursList();
		log.info("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ 전달 list : " + curslist);
		model.addAttribute("leclist", curslist);
		return "lectureCre/sulist";
	}
	
	/* 개설된 강의 리스트*/
	@PostMapping(value = "/sulist", produces = "application/json;chartset=utf-8")
	@ResponseBody
	public List<CursVO> postSuList(String cursNo) {
		log.info("여기로 왔나요? : " + cursNo);
		return cls.selectCursDtl(cursNo);
	}
	
	
	/* 강의 평가 리스트 */
	@GetMapping("/suevaluation")
	public String getSuEvaluation(Model model) {
		List<CursEvaluationVO> cursevalist = cls.selectCursEvaList();
		log.info("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ 전달 cursevalist : " + cursevalist);
		model.addAttribute("cursevalist", cursevalist);
		return "lectureCre/suevaluation";
	}

}

