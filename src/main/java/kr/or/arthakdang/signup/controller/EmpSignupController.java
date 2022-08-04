	package kr.or.arthakdang.signup.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.arthakdang.signup.domain.PaymentVO;
import kr.or.arthakdang.signup.service.SignupService;

@Controller
@RequestMapping("/empSignup")
public class EmpSignupController {

	@Autowired
	private SignupService service;
	
	
	@GetMapping("/paymentHistory")
	public String getpaymentHistory() {
		
		return "signup/empPaymentHistory";
	}
	
	@GetMapping(value = "/getHistory", produces = "application/json;charset=utf-8")
	@ResponseBody
	public List<PaymentVO> getHistory(){
		
		return service.empPaymentHistory();
	}
}
