package kr.or.arthakdang.employeemanagement.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class EmployeeListPageCountVO {
	private int pageNum;
	private int pageSize;
	private int pageRange;
	private String empNm;
	private String empPhNo;
	
	
	public EmployeeListPageCountVO() {
		this(1,10,10);
	}
	
	public EmployeeListPageCountVO(int pageNum, int pageSize, int pageRange) {
		this.pageNum = pageNum;
		this.pageSize = pageSize;
		this.pageRange = pageRange;
	}
	
}
