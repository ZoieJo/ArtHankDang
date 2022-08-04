package kr.or.arthakdang.approval.domain;

import java.util.List;

import kr.or.arthakdang.employeemanagement.domain.EmployeeVO;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class UsdeaprllndtlVO {

	private String usdeaprllnNo;	// 사용자 정의 결재라인 번호
	private int aprlOd;				// 결재 순번
	private String aprlMemId;		// 결재자 아이디
	private String aprlTpCd;		// 결재 유형 코드
	
	private String empNm;			// 결재자 이름
	private List<EmployeeVO> employeeInfo;	// 결재자 정보
}
