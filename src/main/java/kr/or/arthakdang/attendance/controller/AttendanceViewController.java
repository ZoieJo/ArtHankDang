package kr.or.arthakdang.attendance.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.or.arthakdang.attendance.service.AttendanceManagementService;
import kr.or.arthakdang.common.service.CourseUtilService;
import kr.or.arthakdang.security.annotation.CurrentUser;
import kr.or.arthakdang.security.user.CustomUser;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/attendance")
public class AttendanceViewController {
	
	@Autowired
	private CourseUtilService courseUtilService;
	
	@Autowired
	private AttendanceManagementService attendanceManagementService;
	
	@GetMapping("/main")
	public String getgradeMain(@CurrentUser CustomUser user, Model model) {
		model.addAttribute("cursList", courseUtilService.selectCourseInProgress(user));
		model.addAttribute("endedCursList", courseUtilService.selectCourseCompleted(user));
		return "attendance/attendanceMain";
	}
	
	@GetMapping("/detail")
	public String getgradeDetail(@CurrentUser CustomUser user, String cursNo, Model model, RedirectAttributes rattr) {

		log.info("input cursNo : " + cursNo);
		
		
		if(!courseUtilService.isThisStudentCanAccessable(user, cursNo)) {
			rattr.addFlashAttribute("msg", "잘못된 접근입니다.");
			return "redirect:/main";
		}
		
		model.addAttribute("atd", attendanceManagementService.selectClassAttendanceListOfStudent(user.getUsername(), cursNo));
		model.addAttribute("curs", courseUtilService.getClassInfo(cursNo));		
		
		return "attendance/attendanceDetail";
	}
}
