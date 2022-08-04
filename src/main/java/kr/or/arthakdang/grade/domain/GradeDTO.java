package kr.or.arthakdang.grade.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

/**
 * GRD 성적 테이블 입력용 DTO
 * @author hs
 *
 */
@Getter
@Setter
@ToString
public class GradeDTO {

	private String grdScr;
	private String grdWrt;
	private String grdNo;
	private String cursNo;
	private String stuId;
	private String grdCmt;
}
