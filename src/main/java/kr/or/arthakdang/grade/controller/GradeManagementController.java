package kr.or.arthakdang.grade.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.arthakdang.common.service.CourseUtilService;
import kr.or.arthakdang.common.service.MemberService;
import kr.or.arthakdang.domain.CourseVO;
import kr.or.arthakdang.grade.domain.GradeDTO;
import kr.or.arthakdang.grade.domain.GradeInfoVO;
import kr.or.arthakdang.grade.service.GradeManagementService;
import kr.or.arthakdang.security.annotation.CurrentUser;
import kr.or.arthakdang.security.user.CustomUser;
import kr.or.arthakdang.studentmanagement.domain.StudentVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/grdManagement")
public class GradeManagementController {
	
	@Autowired
	private CourseUtilService courseUtilService;
	
	@Autowired
	private GradeManagementService gradeManagementService;
	
	@Autowired
	private MemberService memberService;

	
	@GetMapping("/main")
	public String getMainPage(@CurrentUser CustomUser user, Model model) {
		List<CourseVO> cursList = courseUtilService.selectCourseInProgress(user);
		List<CourseVO> endedCursList = courseUtilService.selectCourseCompleted(user);
		
		
		model.addAttribute("cursList", cursList);
		model.addAttribute("endedCursList", endedCursList);
		log.info("list : " + cursList);
		return "gradeManagement/gradeManagementMain";
	}
	
	
	@GetMapping("/list")
	public String getClassGrdListPage(@CurrentUser CustomUser user, String cursNo, Model model) {
		boolean check = courseUtilService.isThisEmployeeCanAccessable(user, cursNo);
		if (!check) {

			model.addAttribute("msg", "조회 권한이 없습니다.");
			return "gradeManagement/classGradeList";
		}
		log.info(user.getUsername() + " 사용자 권한 확인 완료");
		model.addAttribute("cursNo", cursNo);
		model.addAttribute("avg", gradeManagementService.getAvgScoreByClass(cursNo));
		model.addAttribute("curs", courseUtilService.getClassInfo(cursNo));	
		model.addAttribute("cursTerm", courseUtilService.getCourseDateInfo(cursNo));
		//model.addAttribute("stuList", gradeManagementService.selectStudentListToInsert(cursNo));

		return "gradeManagement/classGradeList";
	}

	@ResponseBody
	@GetMapping(value = "/list/data", produces = "application/json; charset=utf-8")
	public List<GradeInfoVO> getClassGrdListData(@CurrentUser CustomUser user, String cursNo) {
		boolean check = courseUtilService.isThisEmployeeCanAccessable(user, cursNo);
		if (!check) {
			return null;
		}
		log.info(user.getUsername() + "로부터 받은 ajax 요청, 사용자 권한 확인 완료");

		return gradeManagementService.getAllClassStudentGrdInfo(cursNo);

	}

	@GetMapping("/detail")
	public String getClassStudentGrdDetailPage(@CurrentUser CustomUser user, String cursNo, String stuId, Model model) {
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

		return "gradeManagement/studentAttendanceDetail";
	}

	
	@ResponseBody
	@GetMapping(value = "/detail/data", produces = "application/json; charset=utf-8")
	public GradeInfoVO getGrdData(@CurrentUser CustomUser user, String cursNo, String stuId) {
		boolean checkForEmp = courseUtilService.isThisEmployeeCanAccessable(user, cursNo);
		boolean checkForStu = courseUtilService.isThisStudentCanAccessable(user, cursNo);
		if (checkForEmp || checkForStu) { // 사용자가 권한이 있는 교직원이거나, 권한이 있는 학생이면
			log.info(user.getUsername() + "로부터 받은 ajax 요청, 사용자 권한 확인 완료");
			GradeInfoVO grade = gradeManagementService.selectClassGradeOfStudent(stuId, cursNo);
			return grade;	
		}	
		
		return null;
	}
	
	@ResponseBody
	@PostMapping(value = "/detail/update", produces = "application/json; charset=utf-8")
	public String updateClassStudentGrade(@RequestBody GradeDTO dto,  @CurrentUser CustomUser user) {
		if(!courseUtilService.isThisEmployeeCanAccessable(user, dto.getCursNo())) {
			return "잘못된 접근입니다.";
		}
		
		dto.setGrdWrt(user.getUsername());

		
		log.info("출석 수정을 위해 받은 값 : " + dto);
		
		int result = gradeManagementService.updateGrade(dto);
		
		if (result > 0) {
			return "수정 완료되었습니다.";
		}
		return "수정하지 못했습니다. 다시 시도해 주세요.";
	}
	
	@ResponseBody
	@PostMapping(value = "/detail/insert", produces = "application/json; charset=utf-8")
	public String insertClassStudentGrade(@RequestBody GradeDTO dto, @CurrentUser CustomUser user) {
		
		if(!courseUtilService.isThisEmployeeCanAccessable(user, dto.getCursNo())) {
			return "잘못된 접근입니다.";
		}
		
		dto.setGrdWrt(user.getUsername());

		log.info("출석 입력을 위해 받은 값 : " + dto);
		int result = gradeManagementService.insertGrade(dto);
		
		if (result > 0) {
			return "등록 완료되었습니다.";
		}
		return "등록하지 못했습니다. 다시 시도해 주세요.";
	}
	
	@ResponseBody
	@PostMapping(value = "/detail/delete", produces = "application/json; charset=utf-8")
	public String deleteClassStudentGrade(@RequestBody GradeDTO dto,  @CurrentUser CustomUser user) {
		
		if(!courseUtilService.isThisEmployeeCanAccessable(user, dto.getCursNo())) {
			return "잘못된 접근입니다.";
		}
		
		log.info("출석 삭제를 위해 받은 값 : " + dto);
		
		int result = gradeManagementService.deleteGrade(dto);
		
		if (result > 0) {
			return "삭제 완료되었습니다.";
		}
		return "삭제하지 못했습니다. 다시 시도해 주세요.";
	}
	
	@ResponseBody
	@GetMapping(value = "/detail/stuList", produces = "application/json; charset=utf-8")
	public List<StudentVO> getStuData(String cursNo) {
		return gradeManagementService.selectStudentListToInsert(cursNo);
	}
	
	
}
