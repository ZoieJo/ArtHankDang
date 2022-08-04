package kr.or.arthakdang.grade.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

/**
 * GRD 성적 테이블에서 데이터를 가져와 뷰에 보낼 때 사용하는 DTO
 * @author hs
 *
 */
@Getter
@Setter
@ToString
public class GradeInfoVO {
	
	private String grdScr; // 성적 점수
	private String grdWrt; // 성적 작성자
	private String grdNo; // 성적 번호
	private String cursNo; // 과목 아이디
	private String stuId; // 학생 아이디
	private String grdCmt; // 성적 코멘트
	
	private String cursNm; // 과목 이름
	private String stuNm; // 학생 이름
	private int grdTotal; // 전체 학생 수
	private int grdRank; // 석차
	//private double grdPercentile; // 백분위

}
