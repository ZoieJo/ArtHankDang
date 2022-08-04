package kr.or.arthakdang.login.service;

import java.io.UnsupportedEncodingException;
import java.net.URISyntaxException;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import java.util.Random;

import org.apache.tomcat.util.json.ParseException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import com.fasterxml.jackson.core.JsonProcessingException;

import kr.or.arthakdang.domain.MemberVO;
import kr.or.arthakdang.login.domain.FindAccountDTO;
import kr.or.arthakdang.mapper.FindAccountMapper;
import kr.or.arthakdang.mapper.MemberMapper;
import kr.or.arthakdang.security.service.OTPService;
import kr.or.arthakdang.sens.api.service.SmsService;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class FindAccountService {

	@Autowired
	private FindAccountMapper findAccountMapper;
	@Autowired
	private MemberMapper memberMapper;

	@Autowired
	private PasswordEncoder passwordEncoder;

	@Autowired
	private SmsService smsService;
	@Autowired
	private OTPService otpService;

	public boolean findId(FindAccountDTO dto) throws JsonProcessingException, InvalidKeyException,
			UnsupportedEncodingException, NoSuchAlgorithmException, ParseException, URISyntaxException {

		String result = findAccountMapper.FindIdByPh(dto);

		if (result != null) {
			String num = "";
			try {
				num = otpService.create();
				String message = new StringBuilder().append("아트학당 ID찾기 인증번호는 [").append(num).append("] 입니다.")
						.toString();
				smsService.sendSms(dto.getMemPh(), message);
			} catch (Exception e) {
				// 암호화 알고리즘이 없는 예외, 부적절한 암호키(상수) 예외 발생
				// sms 전송이 정상적으로 이뤄지지 않는 경우
				// 정상적으로 발생하지 않는 예외임
				log.info("암호화 과정 중 문제가 발생했습니다.");
				return false;
			}

			return true;
		}

		return false;
	}

	public boolean findPw(FindAccountDTO dto) throws JsonProcessingException, InvalidKeyException,
			UnsupportedEncodingException, NoSuchAlgorithmException, ParseException, URISyntaxException {

		String result = findAccountMapper.FindAccountByIdPh(dto);

		if (result != null) {
			String num = "";
			try {
				num = otpService.create();
				String message = new StringBuilder().append("아트학당 ID찾기 인증번호는 [").append(num).append("] 입니다.")
						.toString();
				smsService.sendSms(dto.getMemPh(), message);
			} catch (Exception e) {
				// 암호화 알고리즘이 없는 예외, 부적절한 암호키(상수) 예외 발생
				// sms 전송이 정상적으로 이뤄지지 않는 경우
				// 정상적으로 발생하지 않는 예외임
				log.info("암호화 과정 중 문제가 발생했습니다.");
				return false;
			}

			return true;
		}

		return false;
	}

	public boolean checkSMS(String inputNum) {
		boolean result = false;

		try {
			result = otpService.verify(inputNum);
		} catch (Exception e) {
			log.info("인증번호 검증 과정 중 문제가 발생했습니다.");
		}

		return result;
	}

	public String getIdbyPh(FindAccountDTO dto) {

		return findAccountMapper.FindIdByPh(dto);
	}

	public boolean updatePw(FindAccountDTO dto) {

		String num = String.format("%06d", (int) (Math.random()*100000));
		try {
			
			String message = new StringBuilder().append("새 비밀번호는 [")
												.append(num)
												.append("] 입니다.").toString();
			smsService.sendSms(dto.getMemPh(), message);
			
		} catch (Exception e) {
			log.info("비밀번호 전송 중 예외가 발생했습니다.");
		}

		MemberVO member = new MemberVO(); 
		
		member.setMemId(dto.getMemId());
		member.setMemPw(passwordEncoder.encode(num));
		if(memberMapper.updateMemPw(member)>0) {
			return true;
		}
		
		return false;
	}

}
