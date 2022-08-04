package kr.or.arthakdang.login.controller;

import java.io.UnsupportedEncodingException;
import java.net.URISyntaxException;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;

import javax.naming.spi.DirStateFactory.Result;

import org.apache.tomcat.util.json.ParseException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.core.JsonProcessingException;

import kr.or.arthakdang.domain.MemberVO;
import kr.or.arthakdang.login.domain.FindAccountDTO;
import kr.or.arthakdang.login.service.FindAccountService;
import kr.or.arthakdang.sens.api.service.SmsService;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/find")
public class FindAccountController {

	@Autowired
	private FindAccountService findAccountService;

	@ResponseBody
	@GetMapping(value="/id", produces="application/json; charset=utf-8")
	public String findId(FindAccountDTO account, Model model) {

		log.info("input : " + account);
		boolean result;
		try {
			result = findAccountService.findId(account);

			if (!result) {
				return "해당 정보로 가입한 아이디가 없습니다.";
			}

		} catch (Exception e) {
			return "인증번호 sms 전송 중 오류가 발생했습니다.";
		}

		return String.valueOf(result);
	}

	@ResponseBody
	@GetMapping(value="/verify", produces="application/json; charset=utf-8")
	public String smsAuthentication(FindAccountDTO account, @RequestParam(name = "inputNum") String inputNum) {
		
		boolean result = findAccountService.checkSMS(inputNum);
		
		if(result) {
			log.info("sms verified!");
			return findAccountService.getIdbyPh(account);
		}
		
		return "";
		
	}
	
	@ResponseBody
	@GetMapping(value="/pw", produces="application/json; charset=utf-8")
	public String findPw(FindAccountDTO account, Model model) {

		log.info("input : " + account);
		boolean result;
		try {
			result = findAccountService.findPw(account);

			if (!result) {
				return "해당 정보로 가입한 아이디가 없습니다.";
			}

		} catch (Exception e) {
			return "인증번호 sms 전송 중 오류가 발생했습니다.";
		}
		
		return String.valueOf(result);
	}
	
	@ResponseBody
	@PostMapping(value="/pw/update", produces="application/json; charset=utf-8")
	public String updatePw(@RequestBody FindAccountDTO dto) {
		
		
		boolean result = findAccountService.updatePw(dto);
		
		if(result) {
			log.info("password changed! user : " + dto.getMemId());
			return "true";
		}
		
		return "false";
	}	
	
	
	
}
