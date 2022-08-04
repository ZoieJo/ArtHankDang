package kr.or.arthakdang.approval.domain;

import java.util.Date;
import java.util.List;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

/**
 *	결재문서VO
 */
@Getter
@Setter
@ToString
public class AprldocVO {

	private String aprldocNo;	// 결재문서번호
	private String aprldocTl;	// 제목
	private String aprldocCnt;	// 내용
	private String memId;		// 결재자 아이디
	private String aprlStCd;	// 결재상태코드
	private Date aprldocDfDt;	// 기안일자
	private Date aprldocWtDt;	// 작성일자
	private String docStCd;		// 문서상태코드
	private String aprlAttchNo;	// 첨부파일
	private String refDoc;		// 참조문서
	
	private String empDepNm;	// 부서
	
	private List<AprllnVO> aprllnList;	// 결재라인
	
}
