package kr.or.arthakdang.crelecture.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class TcrDtlVO {
	
	private int tcrSuNum; // 교원(달별)강의시수
	private String tcrIcSub; // 담당과목
	private String tcrId; // 담당교원
	
	private String subNo; // 과목 번호 -> sub 테이블에서 가져옴
	
	
}
