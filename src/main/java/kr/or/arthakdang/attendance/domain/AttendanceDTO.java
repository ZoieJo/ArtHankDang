package kr.or.arthakdang.attendance.domain;

import java.util.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

/**
 * 데이터베이스의 컬럼과 일치하는 속성을 가진 출석테이블 조작용 DTO
 * 
 * @author hs
 *
 */
@Getter
@Setter
@ToString
public class AttendanceDTO {
	private String atdDt;
	private Date atdInTm;
	private Date atdOutTm;
	private String cursNo;
	private String atdCmcd;
	private String stuId;

}
