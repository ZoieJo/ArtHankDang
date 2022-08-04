package kr.or.arthakdang.signup.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class OrderDetailVO {

	private String ordNo;	// 주문번호
	private String cursNo;	// 강의번호
	private int ordAmt;		// 수강료
	private String stuId;	// 학생아이디
	
}
