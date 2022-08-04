package kr.or.arthakdang.qna.domain;

import java.util.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class QnAVO {
	private String bdNo;
	private String bdCmcd;
	private String bdTl;
	private String bdCnt;
	private String bdWtr;
	private Date bdWtDt;
	private Date bdMdDt;
	private int bdViews;
	private String bdSuc;
}
