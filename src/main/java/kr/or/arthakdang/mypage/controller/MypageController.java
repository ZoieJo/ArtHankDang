package kr.or.arthakdang.mypage.controller;

import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.or.arthakdang.common.service.CourseUtilService;
import kr.or.arthakdang.common.service.MemberService;
import kr.or.arthakdang.domain.MemberDetailInfo;
import kr.or.arthakdang.employeemanagement.domain.EmployeeVO;
import kr.or.arthakdang.employeemanagement.service.EmployeeManagementService;
import kr.or.arthakdang.security.annotation.CurrentUser;
import kr.or.arthakdang.security.user.CustomUser;
import kr.or.arthakdang.studentmanagement.domain.StudentVO;
import kr.or.arthakdang.studentmanagement.service.StudentManagementService;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/mypage")
public class MypageController {

	@Autowired
	private MemberService memberService;

	@Autowired
	private EmployeeManagementService employeeManagementService;

	@Autowired
	private StudentManagementService studentManagementService;

	@Autowired
	private CourseUtilService courseUtilService;

	@GetMapping("/main")
	public String getMypage(Model model, HttpServletRequest req, @CurrentUser CustomUser user) {

		try {
			MemberDetailInfo member = null;

			int memberCode = memberService.getMemberCode(user);
			
			if(memberCode>1) {
				member = memberService.getOneEmployeeById(user.getUsername());
			} else {
				member = memberService.getOneStudentById(user.getUsername());
			}
			
			model.addAttribute("member", member);
			model.addAttribute("memberCode", memberCode);
			model.addAttribute("cursList", courseUtilService.selectCourseInProgress(user));

		} catch (Exception e) {
			req.getSession(false).invalidate();
			return "error/error";
		}
		return "mypage/mypageMain";
	}

	@GetMapping("/memberinfo/detail")
	public String getMypageEditForm(Model model, HttpServletRequest req, @CurrentUser CustomUser user,
			RedirectAttributes rattr) {

		// rattr.addFlashAttribute("pwChecked", true);
		String username = user.getUsername();

		int memberCode = memberService.getMemberCode(user);

		if (memberCode > 1) {
			MemberDetailInfo member = memberService.getOneEmployeeById(username);
			model.addAttribute("memberCode", memberCode);
			model.addAttribute("member", member);
			return "mypage/mypageEditFormEmployee";
		}

		MemberDetailInfo member = memberService.getOneStudentById(username);
		model.addAttribute("memberCode", memberCode);
		model.addAttribute("member", member);
		return "mypage/mypageStuEditForm";
	}

	@PostMapping("/memberinfo/edit")
	public String postMypageEditForm(RedirectAttributes rattr, StudentVO stu, EmployeeVO emp,
			@CurrentUser CustomUser user) {

		String username = user.getUsername();
		log.info("user : " + username);
		int memberCode = memberService.getMemberCode(user);
		log.info("stu : " + stu);
		int result = 0;

		if (memberCode == 1) {
			// StudentVO stu = (StudentVO)member;
			stu.setStuId(username);
			result = studentManagementService.updateStudentInfo(stu);
		} else if (memberCode > 1) {
			// EmployeeVO emp = (EmployeeVO)member;
			emp.setEmpId(username);
			result = employeeManagementService.updateEmployeeInfo(emp);
		} else {
			rattr.addFlashAttribute("msg", "유효하지 않은 회원 정보 입니다. 관리자에게 문의하세요.");
			return "redirect:/mypage/main";
		}

		rattr.addFlashAttribute("pwChecked", true);

		if (result > 0) {

			rattr.addFlashAttribute("msg", "정보 수정에 성공했습니다.");
			// principal 초기화 과정...인데 현재 작동하지 않아서 막아둠
//			Authentication authentication = new UsernamePasswordAuthenticationToken(user, user.getPassword(), user.getAuthorities());
//			SecurityContextHolder.getContext().setAuthentication(authentication);
//			log.info(SecurityContextHolder.getContext().getAuthentication().getName());
			return "redirect:/mypage/main";
		}

		rattr.addFlashAttribute("msg", "회원 정보 수정 중 오류가 발생했습니다.");
		return "redirect:/memberinfo/detail";
	}

	@ResponseBody
	@GetMapping(value = "/resign", produces = "application/json;charset=utf-8")
	public boolean withDrawCheck(@CurrentUser CustomUser user) {
		log.info("resign check... : " + user.getUsername());
		if (courseUtilService.selectCourseInProgress(user) != null) {
			return true;
		}
		return false;
	}

	@ResponseBody
	@PostMapping(value = "/resign", produces = "application/json;charset=utf-8")
	public boolean withDraw(@CurrentUser CustomUser user) {

		return memberService.withdrawMember(user);
	}
	
	@ResponseBody
	@GetMapping(value = "/new", produces = "application/json;charset=utf-8")
	public boolean newMemberCheck(@CurrentUser CustomUser user) {
		log.info("회원 정보 등록 여부 체크중...");
		return memberService.memberInformationCheck(user);
	}

	@ResponseBody
	@PostMapping(value = "/resetPassword", produces = "application/json;charset=utf-8")
	public String passwordReset(@CurrentUser CustomUser user, @RequestBody HashMap<String, String> map) {
		
		log.info("map : " + map);
		
		String currentPw = map.get("currentPw");
		String newPw = map.get("newPw");
		
		log.info("pw : " + currentPw + ", newPw : " + newPw);
		
		return memberService.passwordResetService(user, currentPw, newPw)+"";
				
	}
	
	
}