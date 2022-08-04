package kr.or.arthakdang.googleotp.controller;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.arthakdang.googleotp.service.GoogleOTPService;
import kr.or.arthakdang.security.annotation.CurrentUser;
import kr.or.arthakdang.security.user.CustomUser;

@Controller
@RequestMapping("/otp")
public class GoogleOTPController {
	
	@Autowired
	GoogleOTPService googleOtpService;
	
	
	// 체크하는 메서드임
	@ResponseBody
	@GetMapping("/verify")
	public String postAuthOTP(int inputCode, String userid, Model model) {
		if(googleOtpService.auth(inputCode, userid)) {
			return "true";
		} else {
			return "false";
		}
		
	}
	
	@GetMapping("/generate")
	public String getGenOTP(Model model, @CurrentUser CustomUser user) {
		
		String username = user.getUsername();
		String host = "arthakdang";
		
		if(!googleOtpService.check(username)) {
			model.addAttribute("msg", "이미 등록된 계정입니다.");
			return "/mypage/memberinfo";
		}

		Map map = googleOtpService.generate(username, host);
		model.addAttribute("otpMap", map);
		
		return "otp/generate";
	}
}
