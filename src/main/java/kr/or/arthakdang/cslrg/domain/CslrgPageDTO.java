package kr.or.arthakdang.cslrg.domain;

import java.util.List;

import lombok.Getter;
import lombok.ToString;


@Getter
@ToString
public class CslrgPageDTO {
	private int total;
	private int startPage;
	private int endPage;
	private boolean previous = true;
	private boolean next = true;
	private String keyword;
	private String memId;
	private List<String> cursList;
	
	private CslrgPageCondDTO cslrgPageCondDTO;
	
	public CslrgPageDTO(CslrgPageCondDTO cslrgPageCondDTO, int total) {
		
		this.keyword = cslrgPageCondDTO.getKeyword();
		this.memId = cslrgPageCondDTO.getMemId();
		
		this.cslrgPageCondDTO = cslrgPageCondDTO;
		this.total = total;
		
		this.endPage = (int)Math.ceil(cslrgPageCondDTO.getPageNum()/(cslrgPageCondDTO.getPageRange()*1.0)) * cslrgPageCondDTO.getPageRange();
		this.startPage = this.endPage - (cslrgPageCondDTO.getPageRange()-1);
		
		if(this.startPage <= 1) {
			this.previous = false;
			this.startPage = 1;
		}
		
		int realEndPage = (int)Math.ceil(this.total/(cslrgPageCondDTO.getPageSize()*1.0));
		
		if(this.endPage >= realEndPage) {
			this.next = false;
			this.endPage = realEndPage;
		}
		
	}

}
