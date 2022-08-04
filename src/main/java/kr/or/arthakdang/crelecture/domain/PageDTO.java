package kr.or.arthakdang.crelecture.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class PageDTO {
	
	// 현재페이지, 시작페이지, 끝페이지, 게시글 총 갯수, 페이지당 글 갯수, 가장마지막페이지
	private int nowPage, startPage, endPage, total, cntPerPage, lastPage;
	// SQL쿼리에서 쓸 start, end
	private int start, end;
	// 화면에 나오는 숫자의 개수(1~10)
	private int cntPage;
	
	// 기본생성자
	public PageDTO() {
		
	}
	
	// 생성자1(검색 기능 없음)
	public PageDTO(int total, int nowPage, int cntPerPage, int cntPage) {
		this.total = total;
		this.nowPage = nowPage;
		this.cntPerPage = cntPerPage;
		this.cntPage = cntPage;
		calcStartEndPage(nowPage, cntPage);
		calcStartEnd(nowPage, cntPerPage);
		calcLastPage(total, cntPerPage);
	}
	
	// 생성자2(검색 기능 추가)
//	public PageDTO(int total, int nowPage, int cntPerPage, int cntPage, String type, String keyword) {
//		this.total = total;
//		this.nowPage = nowPage;
//		this.cntPerPage = cntPerPage;
//		calcStartEndPage(nowPage, cntPage);
//		calcStartEnd(nowPage, cntPerPage);
//		calcLastPage(total, cntPerPage);
//	}
	
	// 제일 마지막 페이지 계산
	public void calcLastPage(int total, int cntPerPage) {
		this.setLastPage((int)(Math.ceil( total / (cntPerPage * 1.0) )));
		if(this.getEndPage() >= this.getLastPage()) {
			setEndPage(this.getLastPage());
		}
	}
	
	// 시작, 끝 페이지 계산
	public void calcStartEndPage(int nowPage, int cntPage) {
		this.setEndPage((int) (Math.ceil( nowPage / (cntPage *1.0) ) * cntPage));
		this.setStartPage(this.getEndPage() - (cntPage - 1));
		if (this.getStartPage() <= 1) {
			this.setStartPage(1);
		}
	}
	
	// DB 쿼리에서 사용할 start, end값 계산
	public void calcStartEnd(int nowPage, int cntPerPage) {
		this.setEnd(nowPage * cntPerPage);
		this.setStart(this.getEnd() - (cntPerPage - 1));
		
	}
	
	
}