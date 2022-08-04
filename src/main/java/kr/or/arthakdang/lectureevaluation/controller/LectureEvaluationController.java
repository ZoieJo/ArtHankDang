package kr.or.arthakdang.lectureevaluation.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.arthakdang.lectureevaluation.domain.LectureEvaluationVO;
import kr.or.arthakdang.lectureevaluation.service.LectureEvaluationService;
import kr.or.arthakdang.security.annotation.CurrentUser;
import kr.or.arthakdang.security.user.CustomUser;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class LectureEvaluationController {

	@Autowired
	private LectureEvaluationService lectureEvaluationService;
	
	@GetMapping("/lecture/evaluation")
	public String getEvaluation(Model model, @CurrentUser CustomUser user) {
		
		List<LectureEvaluationVO> myLectureList = lectureEvaluationService.myLectureList(user.getMember().getMemId());
		
		for(LectureEvaluationVO myLecture : myLectureList) {
			int check = lectureEvaluationService.evaluationCheck(myLecture);
			myLecture.setEvalChk(check);
			log.info("eval " + myLecture.getEvalChk());
		}
		log.info("myLecture " + myLectureList);
		model.addAttribute("myLectureList", myLectureList);
		model.addAttribute("user", user);
		return "lecture/lectureEvaluation";
	}
	
	@PostMapping(value = "/lecture/evaluation/modal", produces = "application/json")
	@ResponseBody
	public LectureEvaluationVO postEvaluationModal(@RequestBody Map<String, String> values, @CurrentUser CustomUser user, LectureEvaluationVO lectureEvaluationVO) {
		lectureEvaluationVO.setCursNo(values.get("cursNo"));
		lectureEvaluationVO.setStuId(user.getMember().getMemId());
		LectureEvaluationVO myLecture = lectureEvaluationService.myLecture(lectureEvaluationVO);
		return myLecture;
	}
	
	@PostMapping("/lecture/evaluationSend")
	public String postEvaluationSend(LectureEvaluationVO lectureEvaluationVO) {
		int result = lectureEvaluationService.lectureEvaluation(lectureEvaluationVO);
		return "redirect:/lecture/evaluation";
	}
	
	@PostMapping("/lecture/evaluation/delete")
	public String postEvaluationDelete(LectureEvaluationVO lectureEvaluationVO, @CurrentUser CustomUser user) {
		lectureEvaluationVO.setStuId(user.getMember().getMemId());
		int result = lectureEvaluationService.deleteEvalulation(lectureEvaluationVO);
		return "redirect:/lecture/evaluation";
	}
}
