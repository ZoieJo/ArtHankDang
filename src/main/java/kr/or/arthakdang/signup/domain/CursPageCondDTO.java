package kr.or.arthakdang.signup.domain;

import java.util.List;

import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Setter
@Getter
@ToString
public class CursPageCondDTO {

	private int pageNum;	// 현재페이지
	private int pageSize;	// 한페이지에 나올 리스트의 수
	private int pageRange;	// 페이지 길이
	private String keyword;	// 검색 키워드
	private String memId;	// 로그인한 회원의 아이디
	private List<String> cursList;	// 장바구니에 담아놓은 강의번호 리스트
	
	public CursPageCondDTO() {
		this(1,10,5, "");
	}
	
	public CursPageCondDTO(int pageNum, int pageSize, int pageRange, String keyword) {
		this.pageNum = pageNum;
		this.pageSize = pageSize;
		this.pageRange = pageRange;
		this.keyword = keyword;
	}
}
