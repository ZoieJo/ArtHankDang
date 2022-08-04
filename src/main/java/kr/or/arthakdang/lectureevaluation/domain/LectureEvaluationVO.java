package kr.or.arthakdang.lectureevaluation.domain;

import java.util.Date;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class LectureEvaluationVO {

	private String cursNo;
	private String cursNm;
	private String stuId;
	
	@JsonFormat(pattern="yyyy-MM-dd")
	private Date cursSttDt;
	@JsonFormat(pattern="yyyy-MM-dd")
	private Date cursEndDt;
	private int cursSuPri;
	private int cursSuNum;
	private String subNo;
	private String subNm;
	private String faciNm;
	private String empNm;
	private String suCmcd;
	
	private String cursevaCnt; 
	private int cursevaScr;
	private Date cursevaDt;
	
	private int evalChk;
	private String cursevaWidWn;
}
