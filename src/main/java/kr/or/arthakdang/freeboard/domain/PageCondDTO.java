package kr.or.arthakdang.freeboard.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Setter
@Getter
@ToString 
public class PageCondDTO {
	private int pageNum;
	private int pageSize;
	private int pageRange;

	//Default생성자를 이용해서 초기값 할당
	public PageCondDTO() {
		this(1,10,10);
	}

	public PageCondDTO(int pageNum, int pageSize, int pageRange) {
		this.pageNum = pageNum;
		this.pageSize= pageSize;
		this.pageRange = pageRange;
	}
	public PageCondDTO(String pageNum, String pageSize, String pageRange) {
		this.pageNum = Integer.parseInt(pageNum);
		this.pageSize= Integer.parseInt(pageSize);
		this.pageRange = Integer.parseInt(pageRange);
	}

}
