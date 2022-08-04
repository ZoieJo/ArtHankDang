package kr.or.arthakdang.crelecture.domain;

import java.sql.Date;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class CursEvaluationVO {
	
	@JsonFormat(pattern="yyyy-MM-dd")
	private Date cursevaDt; // 날짜
	private int cursevaScr; // 점수
	private String cursevaCnt; // 평가내용
	private String cursNm; // 강의 제목
	
	private String cursNo;
	private String stuId;
	private String cursevaWidWn;
	
	
	
	
}
