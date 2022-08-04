package kr.or.arthakdang.crelecture.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class SearchInfoVO {
	
	private String keyword;
	private String type;
	private String tcrId; // 내 아이디
	
}
