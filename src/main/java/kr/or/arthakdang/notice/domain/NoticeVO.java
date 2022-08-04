package kr.or.arthakdang.notice.domain;

import java.util.Date;

import lombok.Data;

@Data
public class NoticeVO {
	private String bdNo;
	private String bdTL;
	private String bdCNT;
	private String bdWTR;
	private String memNm;	
	private Date bdWtDt;
	private Date bdMdDt;
}
