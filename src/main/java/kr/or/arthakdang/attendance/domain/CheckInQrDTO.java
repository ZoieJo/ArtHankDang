package kr.or.arthakdang.attendance.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

/**
 * QR학생증으로 출석체크할 때 필요한 정보를 담을 DTO
 * @author hs
 *
 */
@Getter
@Setter
@ToString
public class CheckInQrDTO {

	private String time; // 현재 시간(밀리초)
	private String code; // OTP 코드
	private String userid; // 사용자 아이디
	private String cursNo; // 강의 이름
}
