package kr.or.arthakdang.note.domain;

public class EmpVO {

	private String empId;// 아이디
	private String empNm;// 이름
	private String empPhNo; // 전번
    private String empEmail; // 이메일
	private String empDepNm; // 부서
	private String empPosiNm; // 직급
	
	private String cmcdNm; // 부서 종류
	
	public String getEmpId() {
		return empId;
	}
	public void setEmpId(String empId) {
		this.empId = empId;
	}
	public String getEmpNm() {
		return empNm;
	}
	public void setEmpNm(String empNm) {
		this.empNm = empNm;
	}
	public String getEmpPhNo() {
		return empPhNo;
	}
	public void setEmpPhNo(String empPhNo) {
		this.empPhNo = empPhNo;
	}
	public String getEmpEmail() {
		return empEmail;
	}
	public void setEmpEmail(String empEmail) {
		this.empEmail = empEmail;
	}
	public String getEmpDepNm() {
		return empDepNm;
	}
	public void setEmpDepNm(String empDepNm) {
		this.empDepNm = empDepNm;
	}
	public String getEmpPosiNm() {
		return empPosiNm;
	}
	public void setEmpPosiNm(String empPosiNm) {
		this.empPosiNm = empPosiNm;
	}
	
	public String getCmcdNm() {
		return cmcdNm;
	}
	public void setCmcdNm(String cmcdNm) {
		this.cmcdNm = cmcdNm;
	}
	
	@Override
	public String toString() {
		return "EmpVO [empId=" + empId + ", empNm=" + empNm + ", empPhNo=" + empPhNo + ", empEmail=" + empEmail
				+ ", empDepNm=" + empDepNm + ", empPosiNm=" + empPosiNm + "]";
	}
	
}
