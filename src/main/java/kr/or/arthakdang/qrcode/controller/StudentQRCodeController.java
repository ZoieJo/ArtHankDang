package kr.or.arthakdang.qrcode.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.arthakdang.common.service.MemberService;
import kr.or.arthakdang.domain.QrCodeDTO;
import kr.or.arthakdang.security.annotation.CurrentUser;
import kr.or.arthakdang.security.service.OTPService;
import kr.or.arthakdang.security.user.CustomUser;
import lombok.extern.slf4j.Slf4j;

/**
 * 학생증 qr코드 생성 컨트롤러
 * 
 * @author hyeonseo
 * 
 *
 */
@Slf4j
@Controller
public class StudentQRCodeController {

	@Autowired
	private OTPService otpService;
	@Autowired
	private MemberService memberService;

	@GetMapping("/qrCode")
	public String getQrCodePage(@CurrentUser CustomUser user, Model model) {

		model.addAttribute("member", memberService.getOneStudentById(user.getUsername()));

		return "mypage/myQrCode";
	}

	@ResponseBody
	@GetMapping(value = "/qrCode/data", produces = "application/json; charset=utf-8")
	public QrCodeDTO getQrCodeData(@CurrentUser CustomUser user) {
		QrCodeDTO dto = new QrCodeDTO();

		dto.setUserid(user.getUsername());
		dto.setTime(Long.toString(System.currentTimeMillis()));
		try {
			dto.setCode(otpService.create());
		} catch (Exception e) {
			// 하드코딩된 암호화 키에 문제가 있거나, 알고리즘을 찾지 못했을 경우 해당 예외 발생
			// 일반적으로 발생 할 수 있는 예외 아님
			log.info("OTP 생성 과정에서 예외가 발생했습니다.");
		}
		
		return dto;
	}
}
