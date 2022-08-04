package kr.or.arthakdang.employeemanagement.controller;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.arthakdang.domain.MemberVO;
import kr.or.arthakdang.employeemanagement.domain.EmployeeListPageCountVO;
import kr.or.arthakdang.employeemanagement.domain.EmployeeVO;
import kr.or.arthakdang.employeemanagement.domain.PageVO;
import kr.or.arthakdang.employeemanagement.domain.SubVO;
import kr.or.arthakdang.employeemanagement.service.EmployeeManagementService;
import kr.or.arthakdang.security.annotation.CurrentUser;
import kr.or.arthakdang.security.user.CustomUser;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/employee")
@Slf4j
public class EmployeeManagementController {
	
	@Autowired
	private EmployeeManagementService empManagementService;
	
	@Autowired
	private PasswordEncoder passwordEncoder;
	
	@GetMapping("/join")
	public String getJoinEmployee(Model model) {
		List<SubVO> subList = empManagementService.subList();
		model.addAttribute("subList", subList);
		return "employee/employeejoin";
	}
	
	@PostMapping("/join")
	public String postJoinEmployee(Model model, EmployeeVO employeeVO) {
		log.info("cmcd" + employeeVO.getEmpCmcd());
		int result = 0;
		LocalDateTime now = LocalDateTime.now();
		String time = now.format(DateTimeFormatter.ofPattern("yyMMdd"));
		String seq = empManagementService.selectSeq();
		employeeVO.setEmpId(time + seq);
		employeeVO.setEmpPw(passwordEncoder.encode(time + seq));
		if(employeeVO.getEmpCmcd().equals("02")) {
			result = empManagementService.joinTeacher(employeeVO);
		} else {
			result = empManagementService.joinEmployee(employeeVO);
		}
		String empId = empManagementService.viewEmployeeId(employeeVO);
		model.addAttribute("empId", empId);
		return "employee/joinsuccess";
	}
	
	@GetMapping("/list")
	public String getEmployeeList(Model model, EmployeeListPageCountVO employeeListPageVO) {
//		List<EmployeeVO> employeeList = empManagementService.employeeList();
		PageVO pageVO;
		List<EmployeeVO> employeeList;
		if(employeeListPageVO.getEmpNm() != null && (employeeListPageVO.getEmpPhNo() == null || employeeListPageVO.getEmpPhNo() == "")) {
			employeeList = empManagementService.selectNameEmployee(employeeListPageVO);
			model.addAttribute("empNm", employeeListPageVO.getEmpNm());
			pageVO = new PageVO(employeeListPageVO, empManagementService.employeeNameCnt(employeeListPageVO));
		} else if((employeeListPageVO.getEmpNm() == "" || employeeListPageVO.getEmpNm() == null) && employeeListPageVO.getEmpPhNo() != null){
			pageVO = new PageVO(employeeListPageVO, empManagementService.employeePhNoCnt(employeeListPageVO));
			model.addAttribute("empPhNo", employeeListPageVO.getEmpPhNo());
			employeeList = empManagementService.selectPhNoEmployee(employeeListPageVO);
		} else {
			pageVO = new PageVO(employeeListPageVO, empManagementService.selectEmployeeTotalCnt());
			employeeList = empManagementService.selectEmployeePage(employeeListPageVO);
		}
		model.addAttribute("employeeList", employeeList);
		model.addAttribute("pageVO", pageVO);
		log.info("ck" + employeeListPageVO);
		
		return "employee/employeelist";
	}
	
//	@PostMapping("/updatePw")
//	public String postUpdatePw(MemberVO memberVO) {
//		
//		int result = empManagementService.updateEmployeePw(memberVO);
//		
//		if(result > 0) {
//			return "redirect:/mypage/main";
//		} else {
//			return "redirect:/mypage/memberinfo/edit";
//		}
//	}
	
	@PostMapping("/updateEmpInfo")
	public String postUpdage(EmployeeVO employeeVO) {
		log.info("update employee > " + employeeVO);
		int result = empManagementService.updateEmployeeInfo(employeeVO);
		
		return "redirect:/employee/list";
	}
	
	@PostMapping("/delete")
	public String postDeleteEmployee(EmployeeVO employeeVO) {
		int result = empManagementService.deleteEmployee(employeeVO);
		
		if(result > 0) {
			// 로그아웃 해야함
			return "mypage/deleteSuccess";
		} else {
			return "redirect:mypage/mypageEditForm";
		}
	}
}