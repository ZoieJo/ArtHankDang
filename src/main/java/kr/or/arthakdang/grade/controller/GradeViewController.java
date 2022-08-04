package kr.or.arthakdang.grade.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.or.arthakdang.common.service.CourseUtilService;
import kr.or.arthakdang.grade.service.GradeManagementService;
import kr.or.arthakdang.security.annotation.CurrentUser;
import kr.or.arthakdang.security.user.CustomUser;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/grade")
public class GradeViewController {

	@Autowired
	CourseUtilService courseUtilService;
	
	@Autowired
	GradeManagementService gradeManagementService;
	
	@GetMapping("/main")
	public String getgradeMain(@CurrentUser CustomUser user, Model model) {
		model.addAttribute("cursList", courseUtilService.selectCourseInProgress(user));
		model.addAttribute("endedCursList", courseUtilService.selectCourseCompleted(user));
		return "grade/gradeMain";
	}
	
	@GetMapping("/detail")
	public String getgradeDetail(@CurrentUser CustomUser user, String cursNo, Model model, RedirectAttributes rattr) {

		if(!courseUtilService.isThisStudentCanAccessable(user, cursNo)) {
			rattr.addFlashAttribute("msg", "잘못된 접근입니다.");
			return "redirect:/main";
		}

		model.addAttribute("avg", gradeManagementService.getAvgScoreByClass(cursNo));
		model.addAttribute("grd", gradeManagementService.selectClassGradeOfStudent(user.getUsername(), cursNo));
		model.addAttribute("curs", courseUtilService.getClassInfo(cursNo));		
		
		return "grade/gradeDetail";
	}
	
}
