package kr.or.arthakdang.sens.api.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

/**
 * 실제로 전송되는 문자메시지 제목/내용과 수신인만을 담는 DTO 객체
 * @author hs
 *
 */
@Getter
@Setter
@ToString
public class MessagesRequestDto {
	
    public MessagesRequestDto(String recipientPhoneNumber, String content) {
		this.content = content;
		this.to = recipientPhoneNumber;
	}
    
	private String to; // 수신인
	private String subject; // 제목 (LMS, MMS의 경우 사용가능0
	private String content; // 문자내용
}