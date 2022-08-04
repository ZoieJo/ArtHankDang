package kr.or.arthakdang.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

/**
 * 강의 시간 상세 테이블 용 VO
 * @author hs
 *
 */
@Getter
@Setter
@ToString
public class CourseTimeDetailVO {
	
	private int cursDay;
	private String cursNo;
	private int cursSttHh;
	private int cursSttMm;
	private int cursEndHh;
	private int cursEndMm;
	
}
