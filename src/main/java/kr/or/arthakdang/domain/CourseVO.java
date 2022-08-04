package kr.or.arthakdang.domain;

import java.util.Date;
import java.util.List;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

/**
 * 강의VO
 */
@Getter
@Setter
@ToString
public class CourseVO {

	private String cursNo;	// 강의번호
	private String cursNm;	// 강의명
	
	
	private int cursSuNum;	// 수강인원
	private Date cursSttDt;	// 강의시작일
	private Date cursEndDt;	// 강의종료일
	private int cursevaScr;	// 강의평가점수
	private String subNo;	// 과목번호
	private String subNm;	// 과목이름
	private String curspnNo;	// 강의계획번호
	private int cursSuPri;		// 수강료
	private String faciNm;		// 시설명
	private List<CourseTimeDetailVO> cursTmdtl; // 강의시간
	
	private String tcrId; // 교원 아이디
	private String tcrNm; // 교원 이름
	
}
