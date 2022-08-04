package kr.or.arthakdang.employeemanagement.domain;

import java.io.Serializable;
import java.util.Date;

import kr.or.arthakdang.domain.MemberDetailInfo;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class EmployeeVO implements MemberDetailInfo, Serializable {
	private String empRrn;
	private String empNm;
	private String empPhNo;
	private String empAddr;
	private String empAddrDtl;
	private String empPostNo;
	private String empId;
	private Date empWidWn;
	private Date empEtDt;
	private String empEmail;
	private String empCmcd;
	private String empPosiNm;
	private String empDepNm;
	private String TcrIcSub;
	private String empPw;
	
	@Override
	public String getMemCmcd() {
		return empCmcd;
	}
	
	@Override
	public String getMemName() {
		return empNm;
	}
}
