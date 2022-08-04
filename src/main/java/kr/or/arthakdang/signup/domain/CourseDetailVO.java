package kr.or.arthakdang.signup.domain;

import java.util.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class CourseDetailVO {

	private String cursNo;	// 강의번호
	private String cursNm;	// 강의명
	private int cursSuNum;	// 수강인원
	private Date cursSttDt;	// 강의시작일
	private Date cursEndDt;	// 강의종료일
	private int cursevaScr;	// 강의평가점수
	private String subNo;	// 과목번호
	private String curspnNo;	// 강의계획번호
	private int cursSuPri;		// 수강료
	private String faciNm;		// 시설명
	private String cursDay;	// 요일
	private int cursSttHh;	// 강의 시작 시
	private int cursEndHh;	// 강의 종료 시
	private int cursSttMm;	// 강의 시작 분
	private int cursEndMm;	// 강의 종료 분
	private String empNm;		// 교원명
	private String cartNo;		// 장바구니번호
	private String ordNo;		// 주문번호
	private String curspnCnt;	// 강의 내용
}
