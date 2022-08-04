package kr.or.arthakdang.qrcode.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.arthakdang.attendance.domain.CheckInQrDTO;
import kr.or.arthakdang.domain.QrCodeDTO;
import kr.or.arthakdang.security.service.OTPService;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class QrCodeService {

	@Autowired
	private OTPService otpService;
	
	/**
	 * 클라이언트에서 생성한 밀리초 단위 시간과 서버에서 전달해준 OTP 숫자가 유효한지 이중으로 검증하는 메서드
	 * 
	 * @param time(long) 클라이언트에서 Date.now()로 생성한 밀리초
	 * @param otp        서버에서 클라이언트로 전달한 OTP 숫자
	 * @return 검증값(true, false)
	 */
	public boolean isValidData(long time, String otp) {

		long now = System.currentTimeMillis();
		boolean result = false;
		try {
			result = otpService.verify(otp);
		} catch (Exception e) {
			// 하드코딩된 암호화 키에 문제가 있거나, 알고리즘을 찾지 못했을 경우 해당 예외 발생
			// 일반적으로 발생 할 수 있는 예외 아님
			log.info("OTP 검증 과정에서 오류가 발생했습니다.");
		}

		if ((now - 30000 < time || time < now + 30000) && result) {
			return true;
		}
		return false;
	}

	/**
	 * 클라이언트에서 생성한 밀리초 단위 시간과 서버에서 전달해준 OTP 숫자가 유효한지 이중으로 검증하는 메서드 오버라이드 메서드임
	 * 
	 * @param time(String) 입력받은 밀리초 문자열
	 * @param otp          서버에서 클라이언트로 전달한 OTP 숫자
	 * @return 검증값(true, false)
	 */
	public boolean isValidData(String time, String otp) {

		return isValidData(Long.parseLong(time), otp);
	}

	/**
	 * 클라이언트에서 생성한 밀리초 단위 시간과 서버에서 전달해준 OTP 숫자가 유효한지 이중으로 검증하는 메서드 오버라이드 메서드임
	 * 
	 * @param dto(출석체크용 데이터 객체)
	 * @return 검증값(true, false)
	 */
	public boolean isValidData(CheckInQrDTO dto) {
		return isValidData(dto.getTime(), dto.getCode());
	}

	public boolean isValidData(QrCodeDTO dto) {
		return isValidData(dto.getTime(), dto.getCode());
		
	}
	
}
