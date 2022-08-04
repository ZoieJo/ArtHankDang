package kr.or.arthakdang.sens.api.domain;

import java.sql.Timestamp;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

/**
 * sms 전송 결과 정보를 담는 dto(디버깅용)
 * @author hs
 *
 */
@Getter
@Setter
@ToString
public class SendSmsResponseDto {
    private String statusCode; // 상태코드
    private String statusName; // 상태이름
    private String requestId; // 요청 아이디
    private Timestamp requestTime; // 요청시간
}
