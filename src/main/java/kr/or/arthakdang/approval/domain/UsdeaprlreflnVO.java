package kr.or.arthakdang.approval.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@ToString
@Getter
@Setter
public class UsdeaprlreflnVO {

	private String usdeaprllnNo;	// 사용자 정의 결재라인번호
	private int refOd;				// 참조 순번
	private String refMemId;		// 참조자 아이디

}
