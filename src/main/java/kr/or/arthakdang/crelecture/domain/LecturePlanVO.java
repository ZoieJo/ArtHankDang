package kr.or.arthakdang.crelecture.domain;

import java.sql.Date;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

/**
 * 
 * @author jerry
 *
 */
@Getter
@Setter
@ToString
public class LecturePlanVO {

	/* 강의 계획서 정보 */
	private String curspnNo;  // 계획 번호 O - 자동
	@JsonFormat(pattern="yyyy-MM-dd")
	private Date curspnAprlDt; // 승인 날짜 X 
	@JsonFormat(pattern="yyyy-MM-dd")
	private Date curspnRgDt; // 등록 날짜 O - 자동
	private String curspnAprlSt; // 강의 계획 승인 상태 O - 자동(대기중)
	private String curspnCursNm; // 강의(계획)명 O - 입력 2
	private String curspnCnt; // 강의 계획 내용 O - 입력 3
	private String tcrId; // 교원 아이디(내 아이디) O - 입력 1
	private String empId; // 직원 아이디(승인 담당자) X
	private int curspnCursNum; // 시수 O - 입력(매달시수 / 시수 넘어가면 작성 못하게 만들기) 5

	/* 강의실 정보 */
	private String faciNo; // 강의실 번호 O - 입력 4
	private String faciNm; // 강의실 이름
	private String faciLoc; // 강의실 위치 정보
	
	/* 파일 정보 */
	private String inteattchNo; // 번호
	private String attchPath; // 경로
	
	private String empNm; // 작성자 이름
	
	
}
