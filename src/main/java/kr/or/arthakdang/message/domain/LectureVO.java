package kr.or.arthakdang.message.domain;

import java.util.Date;
import java.util.List;

import com.fasterxml.jackson.annotation.JsonFormat;

import kr.or.arthakdang.message.domain.StuVO;
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
	
	private List<StuVO> stuVO;
	
}
