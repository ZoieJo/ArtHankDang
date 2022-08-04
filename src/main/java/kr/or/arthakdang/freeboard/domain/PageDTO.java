package kr.or.arthakdang.freeboard.domain;

import lombok.Getter;
import lombok.ToString;

@Getter
@ToString
public class PageDTO {
	
	private int total;
	private int startPage;
	private int endPage;
	private boolean previous = true; /* boolean 타입은 isPrevious 식의 getter 맹글어 줌*/
	private boolean next = true;
	
	private PageCondDTO pageCondDTO;
	
	public PageDTO(PageCondDTO pageCondDTO, int total) {

		// 숫자가 이상한 사람은 실험을 통행 눈으로 확인
		this.pageCondDTO = pageCondDTO;
		this.total= total;

		this.endPage = (int)Math.ceil(pageCondDTO.getPageNum() / (pageCondDTO.getPageRange()*1.0)) * pageCondDTO.getPageRange();

		//이 값이 순서에 영향 받으니 주의
		this.startPage = this.endPage - (pageCondDTO.getPageRange()-1);
		if(this.startPage <= 1) {
			this.previous = false;
			this.startPage = 1;
		}

		// 그리고 항상 endPage는 데이타 갯수가 딱 안 떨어질 수 있어서 신경써야 함
		int realEndPage = (int)Math.ceil(this.total / (pageCondDTO.getPageSize()*1.0));
		if(this.endPage >= realEndPage) {
			this.next = false;
			this.endPage = realEndPage;
		}		
	}
}
