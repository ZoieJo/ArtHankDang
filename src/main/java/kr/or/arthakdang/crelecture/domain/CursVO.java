package kr.or.arthakdang.crelecture.domain;

import java.sql.Date;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

/**
 * 
 * @author Jerry
 */
@Getter
@Setter
@ToString
public class CursVO {
	
	/* 강의 정보 -> CURS */
	private String cursNo; // 강의 번호 - 자동
	private String cursNm; // 강의명 - O
	private int cursSuNum; // 강의 시수 - 자동
	@JsonFormat(pattern="yyyy-MM-dd")
	private Date cursSttDt; // 강의 시작 날짜 - O
	@JsonFormat(pattern="yyyy-MM-dd")
	private Date cursEndDt; // 강의 종료 날짜 - O
	private int cursevaScr; // 강의 점수 - 자동(초기값 = 0)
	private String subNo; // 과목번호 - 자동
	private int cursSuPri; // 강의 가격 - O
	private String faciNm; // 시설번호 - 자동
	private String curspnNo; // 강의 계획 번호 - 자동
	
	/* 강의 시간 상세 정보 -> CURSTMDTL */
	private String cursDay; // 요일 - 1 ~ 6 (번호)
	// 강의 번호랑 요일로 복합키가 만들어짐
	private int cursSttHh; // 시작 시
	private int cursSttMm; // 시작 분
	private int cursEndHh; // 종료 시
    private int cursEndMm; // 종료 분
    
    /* 강의 정보 가져올 교원 번호 -> TCRDTL */
    private String tcrId;
    
    /* 개설된 강의 보여주기 */
    private String subNm; // 강의명
    private String curspnCnt; // 강의 설명
    private String attchPath; // 섬네일 경로
    private String empNm; // 교원이름
    
}
