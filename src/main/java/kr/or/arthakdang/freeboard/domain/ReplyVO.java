package kr.or.arthakdang.freeboard.domain;

import java.util.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Setter
@Getter
@ToString
public class ReplyVO {
	private String rpyNo;
	private String bdNo;
	private String memNm;	
	private String rpyCnt;
	private Date rpyWtDt;
	private Date rpyMdDt;
	private String memId;
}
