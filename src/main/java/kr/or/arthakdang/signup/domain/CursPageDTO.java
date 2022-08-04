package kr.or.arthakdang.signup.domain;

import java.util.List;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@ToString
public class CursPageDTO {
	
	private int total;
	private int startPage;
	private int endPage;
	private boolean previous = true;
	private boolean next = true;
	private String keyword;
	private String memId;
	private List<String> cursList;
	
	private CursPageCondDTO cursPageCondDTO;
	
	public CursPageDTO(CursPageCondDTO cursPageCondDTO, int total) {
		
		this.keyword = cursPageCondDTO.getKeyword();
		this.memId = cursPageCondDTO.getMemId();
		
		this.cursPageCondDTO = cursPageCondDTO;
		this.total = total;
		
		this.endPage = (int)Math.ceil(cursPageCondDTO.getPageNum()/(cursPageCondDTO.getPageRange()*1.0)) * cursPageCondDTO.getPageRange();
		this.startPage = this.endPage - (cursPageCondDTO.getPageRange()-1);
		
		if(this.startPage <= 1) {
			this.previous = false;
			this.startPage = 1;
		}
		
		int realEndPage = (int)Math.ceil(this.total/(cursPageCondDTO.getPageSize()*1.0));
		
		if(this.endPage >= realEndPage) {
			this.next = false;
			this.endPage = realEndPage;
		}
		
	}
}
