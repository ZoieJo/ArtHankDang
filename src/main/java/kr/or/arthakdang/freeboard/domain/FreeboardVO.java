package kr.or.arthakdang.freeboard.domain;

import java.util.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class FreeboardVO {
	private String bdNo;
	private String bdTL;
	private String bdCNT;
	private String bdWTR;
	private String memNm;	
	private Date bdWtDt;
	private Date bdMdDt;
	private String bdViews;
	private String bdLikes;
	
}
