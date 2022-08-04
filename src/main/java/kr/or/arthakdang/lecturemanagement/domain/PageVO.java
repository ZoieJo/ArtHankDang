package kr.or.arthakdang.lecturemanagement.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class PageVO {
		private int total;
		private int startPage;
		private int endPage;
		private boolean previous = true;
		private boolean next = true;
		private LectureListPageCountVO lectureListPageCountVO;
		
		public PageVO(LectureListPageCountVO lectureListPageCountVO, int total) {
			this.lectureListPageCountVO = lectureListPageCountVO;
			this.endPage = (int)Math.ceil(lectureListPageCountVO.getPageNum() / (lectureListPageCountVO.getPageRange()*1.0)) * lectureListPageCountVO.getPageRange();
			this.total = total;
			
			this.startPage = this.endPage - (lectureListPageCountVO.getPageRange()-1);
			if(this.startPage <= 1) {
				this.previous = false; // 첫 페이지라면 이전버튼 비활성화
				this.startPage = 1;
			}
			
			int realEndPage = (int) Math.ceil(this.total / (lectureListPageCountVO.getPageSize()*1.0));
			if(this.endPage >= realEndPage) {
				this.next = false; // 마지막페이지라면 다음버튼 비활성화
				this.endPage = realEndPage;
			}
		}
		
}
