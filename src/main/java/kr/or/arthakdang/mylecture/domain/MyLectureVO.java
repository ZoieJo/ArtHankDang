package kr.or.arthakdang.mylecture.domain;

import java.util.Date;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class MyLectureVO {

	// 나의 강의에 필요한 데이터
	private String cursNo;
	private String cursNm;
	private int cursSuNum;
	@JsonFormat(pattern="yyyy-MM-dd")
	private Date cursSttDt;
	@JsonFormat(pattern="yyyy-MM-dd")
	private Date cursEndDt;
	private int cursevaScr;
	private int cursSuPri;
	private String faciNm;
	private String curspnNo;
	private String curspnCnt;
	private String subNo;
	private String subNm;
	private String tcrId;
	private String empNm;
	
	private int cursStuCnt;
	
	private int cursevaScrAvg;
	@JsonFormat(pattern="yyyy-MM-dd")
	private Date cursevaDt;
	private String cursevaCnt;
	private String stuId;
	private String stuNm;
	
}
