package kr.or.arthakdang.approval.domain;

import java.util.List;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class UsdeaprllnVO {

	private String usdeaprllnNo;	// 사용자 정의 결재라인 번호
	private String usdeaprllnTl;	// 라인 제목
	private String memId;			// 사용자 아이디
	
	private List<UsdeaprllndtlVO> usdeaprllndtlList;	// 해당 결재라인 번호에 대한 결재라인 정보
	private List<UsdeaprlreflnVO> usdeaprlrefList;		// 해당 결재라인 번호에 대한 참조자 정보
}
