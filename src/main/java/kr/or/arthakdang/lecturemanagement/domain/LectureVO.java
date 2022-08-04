package kr.or.arthakdang.lecturemanagement.domain;

import java.util.Date;


import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class LectureVO {
	private String cursNo;
	private String cursNm;
	private int cursSuNum;
	
	@JsonFormat(pattern="yyyy-MM-dd")
	private Date cursSttDt;
	
	@JsonFormat(pattern="yyyy-MM-dd")
	private Date cursEndDt;
	
	private int cursevaScr;
	private String subNo;
	private int cursSuPri;
	private String faciNm;
	private String curspnNo;
	private String tcrId;
	private String curspnCnt;
	private String subNm;
	private String empNm;
	
}
