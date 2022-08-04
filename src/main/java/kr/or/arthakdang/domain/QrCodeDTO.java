package kr.or.arthakdang.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

/**
 * qr코드 학생증에 담긴 정보를 관리하는 DTO
 * @author hs
 *
 */
@Getter
@Setter
@ToString
public class QrCodeDTO {
	private String time; // 현재 시간(밀리초)
	private String code; // OTP 코드
	private String userid; // 사용자 아이디

}
