package kr.or.arthakdang.studentmanagement.domain;


public class PageVO {
		private int total;
		private int startPage;
		private int endPage;
		private boolean previous = true;
		private boolean next = true;
		private StudentListPageCountVO studentListPageVO;
		
		public PageVO(StudentListPageCountVO studentListPageVO, int total) {
			this.studentListPageVO = studentListPageVO;
			this.endPage = (int)Math.ceil(studentListPageVO.getPageNum() / (studentListPageVO.getPageRange()*1.0)) * studentListPageVO.getPageRange();
			this.total = total;
			
			this.startPage = this.endPage - (studentListPageVO.getPageRange()-1);
			if(this.startPage <= 1) {
				this.previous = false; // 첫 페이지라면 이전버튼 비활성화
				this.startPage = 1;
			}
			
			int realEndPage = (int) Math.ceil(this.total / (studentListPageVO.getPageSize()*1.0));
			if(this.endPage >= realEndPage) {
				this.next = false; // 마지막페이지라면 다음버튼 비활성화
				this.endPage = realEndPage;
			}
		}

		public int getTotal() {
			return total;
		}

		public int getStartPage() {
			return startPage;
		}

		public int getEndPage() {
			return endPage;
		}

		public boolean isPrevious() {
			return previous;
		}

		public boolean isNext() {
			return next;
		}

		public StudentListPageCountVO getStudentListPageVO() {
			return studentListPageVO;
		}

		public void setStudentListPageVO(StudentListPageCountVO studentListPageVO) {
			studentListPageVO = studentListPageVO;
		}

		@Override
		public String toString() {
			return "PageVO [total=" + total + ", startPage=" + startPage + ", endPage=" + endPage + ", previous="
					+ previous + ", next=" + next + ", studentListPageVO=" + studentListPageVO + "]";
		}
		
}
