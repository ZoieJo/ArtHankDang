package kr.or.arthakdang.domain;

import java.util.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

/**
 * 강의 계획 VO
 */
@Getter
@Setter
@ToString
public class CurspnVO {

	private String curspnNo;	// 강의계획번호
	private Date curspnAprlDt;	// 승인일자
	private Date curspnRgDt;	// 신청일자
	private String curspnAprlSt;	// 승인상태
	private String curspnCnt;		// 내용
	private String faciNo;			// 시설번호
	private String tcrId;			// 교원아이디
	private String empId;			// 승인자아이디
	private String curspnCursNm;	// 계획서제목(강의이름)
	private int curspnCursNum;		// 강의시수
}
