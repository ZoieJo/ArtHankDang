package kr.or.arthakdang.sens.api.domain;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

/**
 * 메시지 전송을 요청하는 DTO
 * @author hs
 *
 */
@Getter
@Setter
@ToString
public class SmsRequestDto {
    
	
	private String type; // 요청타입
    private String contentType; // 컨텐츠 타입
    private String countryCode; // 국가코드
    private String from; // 발신인 번호
    private String content; // 내용
    private String subject;
    private List<MessagesRequestDto> messages; // 실제로 전송될 문자메시지 리스트
}