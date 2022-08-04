package kr.or.arthakdang.studentlecture.domain;

import java.util.Date;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class StudentLectureVO {

	private String cursNo;
	private String cursNm;
	private int cursSuNum;
	@JsonFormat(pattern="yyyy-MM-dd")
	private Date cursSttDt;
	@JsonFormat(pattern="yyyy-MM-dd")
	private Date cursEndDt;
	private String faciNm;
	private String empNm;
	private String stuId;
	private String stuNm;
	private String subNo;
	private String subNm;
}
