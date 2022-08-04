package kr.or.arthakdang.signup.domain;

import java.util.Date;
import java.util.List;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class OrderVO {

	private String ordNo;	// 주문번호
	private String stuId;	// 학생아이디
	private Date ordDt;		// 주문일자
	private int tolAmt;		// 총금액
	
	// 장바구니 상세
	private List<OrderDetailVO> suOrdDtl;
	
}
