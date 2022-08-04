package kr.or.arthakdang.cslrg.domain;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;


@Setter
@Getter
@ToString
public class CslrgVO {

	private String cslrgNo;		//상담신청번호
	private String stuId;		//학생아이디

	@DateTimeFormat(pattern="yyyy-MM-dd")
	@JsonFormat( pattern="yyyy-MM-dd",shape = JsonFormat.Shape.STRING,timezone = "GMT+9")
	private Date cslrgRsvDt;	//예약날짜
	private String cslrgRsvTm;	//예약시간
	
	private String cslFdCmcd;	//상담분야 공통코드
	private String cslrgCnt;	//신청내용
	private String cslStCmcd;	//상담상태 공통코드	
	
	//상담결과
	private String empId; 		//교직원아이디
	private String cslrgRsn;	//상담결과(내용)
	
	
	//신규상담 추가 사항
	private String cslrgNm;			//신규상담자 이름
	private String cslrgPhNo;		//신규상담자 전화번호
	private String cslrgSub;		//신규상담자 희망과목
	private String cslPrivateNm;	//신규상담신청 비밀번호
}
