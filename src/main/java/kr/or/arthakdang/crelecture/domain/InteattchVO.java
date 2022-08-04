package kr.or.arthakdang.crelecture.domain;

import java.util.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

/**
 * copy master jerry~
 * @author HJS
 */
@Getter
@Setter
@ToString
public class InteattchVO {
	private String inteattchNo;
	private int inteattchOd;
	private String attchPath;
	private String attchNm;
	private String attchStdNm;
	private String attchExt;
	private long attchSz;
	private Date attchRgDt;
	private Date attchMdDt;
	private String rgMemId;
	private String mdMemId;
	
}