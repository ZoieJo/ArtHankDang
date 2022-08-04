package kr.or.arthakdang.studentmanagement.controller;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.List;
import java.util.Random;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.arthakdang.domain.MemberVO;
import kr.or.arthakdang.studentmanagement.domain.PageVO;
import kr.or.arthakdang.studentmanagement.domain.StudentListPageCountVO;
import kr.or.arthakdang.studentmanagement.domain.StudentVO;
import kr.or.arthakdang.studentmanagement.service.StudentManagementService;
import lombok.extern.slf4j.Slf4j;
import net.nurigo.sdk.NurigoApp;
import net.nurigo.sdk.message.model.Message;
import net.nurigo.sdk.message.request.SingleMessageSendingRequest;
import net.nurigo.sdk.message.response.SingleMessageSentResponse;
import net.nurigo.sdk.message.service.DefaultMessageService;
import oracle.jdbc.proxy.annotation.Post;

@Controller
@Slf4j
public class StudentManagementController {
	
	final DefaultMessageService messageService;

    public StudentManagementController() {
        this.messageService = NurigoApp.INSTANCE.initialize("NCSFQ0OTRZQTJI0F", "OPWWLJE4IDQNN2CAXLIBAJTZLHS4XV7Z", "https://api.coolsms.co.kr");
    }
	
	
	@Autowired
	private StudentManagementService stuManagementService;
	
	@Autowired
	private PasswordEncoder passwordEncoder;
	
	@GetMapping("/student/join")
	public String getStudentJoin(Model model) {
		List<String> employeeList = stuManagementService.searchEmployee();
		model.addAttribute("employeeList", employeeList);
		log.info("employeeList" + employeeList);
		return "student/studentjoin";
	}
	
	@PostMapping("/student/join")
	public String postStudentJoin(Model model, StudentVO stuVO) {
		LocalDateTime now = LocalDateTime.now();
		String time = now.format(DateTimeFormatter.ofPattern("yyMMdd"));
		String seq = stuManagementService.selectSeq();
		stuVO.setStuId(time + seq);
		stuVO.setStuPw(passwordEncoder.encode(time + seq));
		int result = stuManagementService.joinStudent(stuVO);
		if(result != 0) {
			String stuId = stuManagementService.viewStudentId(stuVO);
			model.addAttribute("stuId", stuId);
			log.info(stuVO.getStuPhNo());
			
			Message message = new Message();
	        // 발신번호 및 수신번호는 반드시 01012345678 형태로 입력되어야 합니다.
	        message.setFrom("01083427973");
	        message.setTo(stuVO.getStuPhNo());
	        message.setText(stuVO.getStuNm() + "님 회원가입이 완료되었습니다. 아이디 및 비밀번호는 담당 멘토님에게 문의해주세요.");
	        
	        SingleMessageSentResponse response = this.messageService.sendOne(new SingleMessageSendingRequest(message));
	        System.out.println(response);
			
			return "student/joinsuccess";
		} else {
			return "student/studentjoin";
		}
	}
	
	@GetMapping("/student/list")
	public String getStudentList(Model model, StudentListPageCountVO studentListPageVO) {
//		List<StudentVO> studentList = stuManagementService.studentList();
		PageVO pageVO;
//		List<StudentVO> searchStudentList = stuManagementService.selectNameStudent(studentVO);
		log.info("getname" + studentListPageVO.getStuNm());
		log.info("getph" + studentListPageVO.getStuPhNo());
		log.info("studentListPageVO2" + studentListPageVO);
		List<StudentVO> studentList; 
		
		if(studentListPageVO.getStuNm() != null && (studentListPageVO.getStuPhNo() == null || studentListPageVO.getStuPhNo() == "")) {
			pageVO = new PageVO(studentListPageVO, stuManagementService.studentNameCnt(studentListPageVO));
			model.addAttribute("stuNm", studentListPageVO.getStuNm());
			studentList = stuManagementService.selectNameStudent(studentListPageVO);
		} else if((studentListPageVO.getStuNm() == null || studentListPageVO.getStuNm() == "") && studentListPageVO.getStuPhNo() != null) {
			pageVO = new PageVO(studentListPageVO, stuManagementService.studentPhNoCnt(studentListPageVO));
			model.addAttribute("stuPhNo", studentListPageVO.getStuPhNo());
			studentList = stuManagementService.selectPhNoStudent(studentListPageVO);
		} else {
			pageVO = new PageVO(studentListPageVO, stuManagementService.selectStudentTotalCnt());
			studentList = stuManagementService.selectStudentPage(studentListPageVO);
		}
		log.info("studentListPageVO" + studentListPageVO);
//		log.info("stuentList" + studentList);
		model.addAttribute("studentList", studentList);
		model.addAttribute("pageVO", pageVO);
		return "student/studentlist";
	}
	
//	@PostMapping("/mypage/updatePw")
//	public String postUpdatePw(MemberVO memVO) {
//		
//		log.info("memvo > " + memVO);
//		int result = stuManagementService.updateStudentPw(memVO);
//		if(result > 0) {
//			return "redirect:/mypage/main";
//		}
//		return "redirect:/mypage/memberinfo/edit";
//	}
	
	@PostMapping("/student/update")
	public String postUpdateInfo(StudentVO stuVO) {
		int result = stuManagementService.updateStudentInfo(stuVO);
		
		return "redirect:/student/list";
	}
	
//	@PostMapping("/student/delete")
//	public String postDeleteMember(StudentVO stuVO) {
//		int result = stuManagementService.deleteStudent(stuVO);
//		
//		if(result > 0) {
//			// 로그인상태 해제해야함
//			return "mypage/deleteSuccess"; 
//		} else {
//			return "redirect:/mypage/memberinfo/edit";
//		}
//	}
	
    public SingleMessageSentResponse sendOne(String phNo) {
        Message message = new Message();
        // 발신번호 및 수신번호는 반드시 01012345678 형태로 입력되어야 합니다.
        message.setFrom("01083427973");
        message.setTo(phNo);
        message.setText("회원가입이 완료되었습니다. 아이디 및 비밀번호는 담당 멘토님에게 문의해주세요.");

        SingleMessageSentResponse response = this.messageService.sendOne(new SingleMessageSendingRequest(message));
        System.out.println(response);

        return response;
    }	
}
