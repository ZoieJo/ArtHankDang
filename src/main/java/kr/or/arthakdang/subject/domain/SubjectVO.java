package kr.or.arthakdang.subject.domain;

import java.sql.Date;

/**
 * 
 * @author jerry
 *
 */
public class SubjectVO {
	
	private String subNo; // 과목번호
	private String subNm; // 과목 이름
	private String SubDelWn; // 과목 삭제 여부
	private Date SubCreDt; // 과목 생성 날짜
	
	
	public String getSubNo() {
		return subNo;
	}
	public void setSubNo(String subNo) {
		this.subNo = subNo;
	}
	public String getSubNm() {
		return subNm;
	}
	public void setSubNm(String subNm) {
		this.subNm = subNm;
	}
	public String getSubDelWn() {
		return SubDelWn;
	}
	public void setSubDelWn(String subDelWn) {
		SubDelWn = subDelWn;
	}
	public Date getSubCreDt() {
		return SubCreDt;
	}
	public void setSubCreDt(Date subCreDt) {
		SubCreDt = subCreDt;
	}

	@Override
	public String toString() {
		return "SubjectVO [subNo=" + subNo + ", subNm=" + subNm + ", SubDelWn=" + SubDelWn + ", SubCreDt=" + SubCreDt
				+ "]";
	}

}