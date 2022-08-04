package kr.or.arthakdang.studentmanagement.domain;

import java.io.Serializable;
import java.util.Date;

import kr.or.arthakdang.domain.MemberDetailInfo;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class StudentVO implements MemberDetailInfo, Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private String stuId;
	private String stuNm;
	private String stuEmail;
	private String stuPhNo;
	private String stuAddr;
	private String stuAddrDtl;
	private String stuPostNo;
	private String stuIntFd;
	private Date stuWidWn;
	private String stuPw;

	@Override
	public String getMemCmcd() {
		return "01";
	}

	@Override
	public String getMemName() {
		return stuNm;
	}
}
