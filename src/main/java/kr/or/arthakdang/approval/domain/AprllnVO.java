package kr.or.arthakdang.approval.domain;

import java.util.Date;

import lombok.Getter;
import lombok.ToString;
import lombok.Setter;

/**
 * 결재라인VO
 */
@Getter
@Setter
@ToString
public class AprllnVO {

	private String aprldocNo;	// 결재문서번호
	private int aprlOd;			// 결재순번
	private String memId;		// 아이디
	private String aprlTpCd;	// 결재유형코드
	private String aprlStCd;	// 결재상태코드
	private Date aprlDt;		// 결재일자
	private String aprlCnt;		// 결재내용
	
	
}
