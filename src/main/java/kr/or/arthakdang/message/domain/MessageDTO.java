package kr.or.arthakdang.message.domain;

import java.sql.Date;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class MessageDTO {
	private String msgNo; // 메시지 고유 번호
	private String msgCmcd; // 메시지 분류 - CD
	private String msgCnt; // 메시지 내용 - CNT
	private String msgRc; // 메시지 받는이
	@JsonFormat(pattern="yyyy-MM-dd")
	private Date msgSntDt; // 메시지 보낸날짜
	private String msgDelWn; // 메시지 삭제여부
	private String msgSd; // 메시지 보낸이
	
	private String empNm; // 보낸이 이름
	
}
