package kr.or.arthakdang.attendance.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.arthakdang.attendance.domain.AttendanceDTO;
import kr.or.arthakdang.attendance.domain.AttendanceInfoDTO;
import kr.or.arthakdang.attendance.domain.StudentAttendanceListDTO;
import kr.or.arthakdang.attendance.service.AttendanceManagementService;
import kr.or.arthakdang.attendance.service.CheckInService;
import kr.or.arthakdang.common.service.CourseUtilService;
import kr.or.arthakdang.common.service.MemberService;
import kr.or.arthakdang.domain.CourseVO;
import kr.or.arthakdang.mapper.CourseMapper;
import kr.or.arthakdang.security.annotation.CurrentUser;
import kr.or.arthakdang.security.user.CustomUser;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/atdManagement")
public class AttendanceManagementController {

	@Autowired
	private AttendanceManagementService attendanceManagementService;

	@Autowired
	private CheckInService checkInService;
	
	@Autowired
	private MemberService memberService;

	@Autowired
	private CourseUtilService courseUtilService;
	
	@GetMapping("/main")
	public String getMainPage(@CurrentUser CustomUser user, Model model) {
		List<CourseVO> cursList = courseUtilService.selectCourseInProgress(user);
		List<CourseVO> endedCursList = courseUtilService.selectCourseCompleted(user);
		model.addAttribute("cursList", cursList);
		model.addAttribute("endedCursList", endedCursList);
		log.info("list : " + cursList);
		return "attendanceManagement/attendanceManagementMain";
	}
	
	
	
	@GetMapping("/list")
	public String getClassAtdListPage(@CurrentUser CustomUser user, String cursNo, Model model) {
		boolean check = courseUtilService.isThisEmployeeCanAccessable(user, cursNo);
		if (!check) {

			model.addAttribute("msg", "조회 권한이 없습니다.");
			return "attendanceManagement/classAttendanceList";
		}
		log.info(user.getUsername() + " 사용자 권한 확인 완료");
		model.addAttribute("cursNo", cursNo);
		model.addAttribute("cursTerm", courseUtilService.getCourseDateInfo(cursNo));
		
		return "attendanceManagement/classAttendanceList";
	}

	@ResponseBody
	@GetMapping(value = "/list/data", produces = "application/json; charset=utf-8")
	public List<AttendanceInfoDTO> getClassAtdListData(@CurrentUser CustomUser user, String cursNo) {
		boolean check = courseUtilService.isThisEmployeeCanAccessable(user, cursNo);
		if (!check) {
			return null;
		}
		log.info(user.getUsername() + "로부터 받은 ajax 요청, 사용자 권한 확인 완료");

		return attendanceManagementService.getAllStudentAtdInfoListByClass(cursNo);

	}
	
	@ResponseBody
	@GetMapping(value = "/today", produces = "application/json; charset=utf-8")
	public List<AttendanceDTO> getTodaysClassAtdListData(@CurrentUser CustomUser user, String cursNo) {
		boolean check = courseUtilService.isThisEmployeeCanAccessable(user, cursNo);
		if (!check) {
			return null;
		}
		log.info(user.getUsername() + "로부터 받은 ajax 요청, 사용자 권한 확인 완료");

		AttendanceDTO dto = new AttendanceDTO();
		
		return attendanceManagementService.selectTodaysAttendanceListbyClass(cursNo);

	}

	@GetMapping("/detail")
	public String getClassStudentAtdDetailPage(@CurrentUser CustomUser user, String cursNo, String stuId, Model model) {
		boolean checkForEmp = courseUtilService.isThisEmployeeCanAccessable(user, cursNo);
		boolean checkForStu = courseUtilService.isThisStudentCanAccessable(user, cursNo);
		if (!checkForEmp && !checkForStu) { // 사용자가 권한이 있는 교직원이거나, 권한이 있는 학생이면
			return "";
		}
		log.info(user.getUsername() + " 사용자 권한 확인 완료");
		model.addAttribute("courseVO", courseUtilService.getClassInfo(cursNo));
		model.addAttribute("studentVO", memberService.getOneStudentById(stuId));
		model.addAttribute("stuId", stuId);
		model.addAttribute("cursNo", cursNo);

		return "attendanceManagement/studentAttendanceDetail";
	}

	
	@ResponseBody
	@GetMapping(value = "/detail/data", produces = "application/json; charset=utf-8")
	public List<AttendanceDTO> getAtdData(@CurrentUser CustomUser user, String cursNo, String stuId) {
		boolean checkForEmp = courseUtilService.isThisEmployeeCanAccessable(user, cursNo);
		boolean checkForStu = courseUtilService.isThisStudentCanAccessable(user, cursNo);
		if (checkForEmp || checkForStu) { // 사용자가 권한이 있는 교직원이거나, 권한이 있는 학생이면
			log.info(user.getUsername() + "로부터 받은 ajax 요청, 사용자 권한 확인 완료");
			List<AttendanceDTO> list = attendanceManagementService.selectClassAttendanceListOfStudent(stuId, cursNo);
			return list;	
		}	
		
		return null;
	}
	
	@ResponseBody
	@PostMapping(value = "/detail/update", produces = "application/json; charset=utf-8")
	public String updateClassStudentAtdDetail(@RequestBody AttendanceDTO dto) {
		log.info("출석 수정을 위해 받은 값 : " + dto);
		
		int result = attendanceManagementService.updateAttendance(dto);
		
		if (result > 0) {
			return "수정 완료되었습니다.";
		}
		return "수정하지 못했습니다. 다시 시도해 주세요.";
	}
	
	@ResponseBody
	@PostMapping(value = "/detail/insert", produces = "application/json; charset=utf-8")
	public String insertClassStudentAtdDetail(@RequestBody AttendanceDTO dto) {
		log.info("출석 입력을 위해 받은 값 : " + dto);
		
		int result = attendanceManagementService.insertAttendance(dto);
		
		if (result > 0) {
			return "등록 완료되었습니다.";
		}
		return "등록하지 못했습니다. 다시 시도해 주세요.";
	}
	
	@ResponseBody
	@PostMapping(value = "/detail/delete", produces = "application/json; charset=utf-8")
	public String deleteClassStudentAtdDetail(@RequestBody AttendanceDTO dto) {
		log.info("출석 삭제를 위해 받은 값 : " + dto);
		
		int result = attendanceManagementService.deleteAttendance(dto);
		
		if (result > 0) {
			return "삭제 완료되었습니다.";
		}
		return "삭제하지 못했습니다. 다시 시도해 주세요.";
	}
}
