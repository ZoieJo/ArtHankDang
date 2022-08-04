package kr.or.arthakdang.studentmanagement.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class StudentListPageCountVO {
	private int pageNum;
	private int pageSize;
	private int pageRange;
	private String stuNm;
	private String stuPhNo;
	
	
	public StudentListPageCountVO() {
		this(1,10,10);
	}
	
	public StudentListPageCountVO(int pageNum, int pageSize, int pageRange) {
		this.pageNum = pageNum;
		this.pageSize = pageSize;
		this.pageRange = pageRange;
	}
	
}
