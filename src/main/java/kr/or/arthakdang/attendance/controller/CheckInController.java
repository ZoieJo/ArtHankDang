package kr.or.arthakdang.attendance.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.or.arthakdang.attendance.domain.CheckInQrDTO;
import kr.or.arthakdang.attendance.domain.CheckInResultDTO;
import kr.or.arthakdang.attendance.service.CheckInService;
import kr.or.arthakdang.common.service.MemberService;
import kr.or.arthakdang.domain.QrCodeDTO;
import kr.or.arthakdang.qrcode.service.QrCodeService;
import kr.or.arthakdang.studentmanagement.service.StudentManagementService;
import lombok.extern.slf4j.Slf4j;

/**
 * 학생 출석 입력 컨트롤러
 * 
 * @author hyeonseo
 * 
 *
 */
@Slf4j
@Controller
@RequestMapping("/attend")
public class CheckInController {

	@Autowired
	private CheckInService checkInService;
	@Autowired
	private QrCodeService qrCodeService;
	@Autowired
	private MemberService memberService;

	@GetMapping("/checkin")
	public String getCheckInPage(String cursNo, Model model, RedirectAttributes rattr) {

		model.addAttribute("cursNo", cursNo);
		boolean check = checkInService.isValidClass(cursNo);
		
		if (check) {

			try {
				checkInService.initStudentCheckIn(cursNo);
			} catch (Exception e) {
				// 출석 init 내역검증
				// 있으면 패스, 없으면 오류처리
			}
		}
		
		if (!check) {
			log.info("출석이 불가능한 시간입니다.");
			model.addAttribute("msg", "출석 입력이 불가능한 시간입니다. 강의시간을 확인해 주세요.");
			
			// 추후 강의 관리 화면으로 넘기면서 리다이렉트로 변경 예정
			//rattr.addFlashAttribute("msg", "출석 입력이 불가능한 시간입니다. 강의시간을 확인해 주세요.");
			//return "redirect:/attend/checkin?cursNo="+cursNo;
		}
		
		return "attendance/qrAttendance";
	}

	@ResponseBody
	@PostMapping(value = "/checkin", produces = "application/json; charset=utf-8")
	public CheckInResultDTO insertCheckIn(@RequestBody CheckInQrDTO dto) {
		CheckInResultDTO result = new CheckInResultDTO();
		boolean check = checkInService.isValidClass(dto.getCursNo()) && qrCodeService.isValidData(dto);
		String username = dto.getUserid();

		if (check) {

			try {
				checkInService.insertCheckin(dto.getUserid(), dto.getCursNo());
				result.setStudentVO(memberService.getOneStudentById(username));
				result.setMsg(dto.getUserid() + " 학생이 출석했습니다.");
			} catch (Exception e) {
				log.info("출석 정보 입력 중 예외가 발생했습니다.");
				result.setMsg(dto.getUserid() + " 학생의 출석 정보 입력 중 예외가 발생했습니다.");
			}

		}
		if (!check) {result.setMsg("입력받은 QR코드가 유효하지 않습니다. 다시 시도해 주세요.");}
		return result;
	}

}
