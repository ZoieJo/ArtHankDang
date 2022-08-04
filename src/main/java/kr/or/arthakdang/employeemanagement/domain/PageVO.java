package kr.or.arthakdang.employeemanagement.domain;

import lombok.Getter;
import lombok.ToString;

@Getter
@ToString
public class PageVO {
		private int total;
		private int startPage;
		private int endPage;
		private boolean previous = true;
		private boolean next = true;
		private EmployeeListPageCountVO employeeListPageVO;
		
		public PageVO(EmployeeListPageCountVO employeeListPageVO, int total) {
			this.employeeListPageVO = employeeListPageVO;
			this.endPage = (int)Math.ceil(employeeListPageVO.getPageNum() / (employeeListPageVO.getPageRange()*1.0)) * employeeListPageVO.getPageRange();
			this.total = total;
			
			this.startPage = this.endPage - (employeeListPageVO.getPageRange()-1);
			if(this.startPage <= 1) {
				this.previous = false; // 첫 페이지라면 이전버튼 비활성화
				this.startPage = 1;
			}
			
			int realEndPage = (int) Math.ceil(this.total / (employeeListPageVO.getPageSize()*1.0));
			if(this.endPage >= realEndPage) {
				this.next = false; // 마지막페이지라면 다음버튼 비활성화
				this.endPage = realEndPage;
			}
		}
}
