package kr.or.arthakdang.lecturemanagement.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class LectureListPageCountVO {
	private int pageNum;
	private int pageSize;
	private int pageRange;
	private String cursNm;
	
	public LectureListPageCountVO() {
		this(1,2,5);
	}
	
	public LectureListPageCountVO(int pageNum, int pageSize, int pageRange) {
		this.pageNum = pageNum;
		this.pageSize = pageSize;
		this.pageRange = pageRange;
	}
	
}
