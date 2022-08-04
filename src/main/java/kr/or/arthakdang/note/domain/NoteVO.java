package kr.or.arthakdang.note.domain;

import java.sql.Date;


public class NoteVO{
	
	private String nteNo; // 쪽지번호
	private String nteSd; // 보낸이
	private String nteRc; // 받는이
	private String nteTl; // 제목
	private String nteCnt; // 내용
	private Date nteSntDt; // 보낸날
	private Date nteRcvDt; // 받은날
	private String nteRed; // 읽음
	private String nteSdDel; // 보낸이삭제
	private String nteRcDel; // 받는이삭제
	
	private String empNm; // 추가 이름
	
	// 페이징 시작 , 끝
	private int start;
	private int end;
	
	public String getNteNo() {
		return nteNo;
	}

	public void setNteNo(String nteNo) {
		this.nteNo = nteNo;
	}

	public String getNteSd() {
		return nteSd;
	}

	public void setNteSd(String nteSd) {
		this.nteSd = nteSd;
	}

	public String getNteRc() {
		return nteRc;
	}

	public void setNteRc(String nteRc) {
		this.nteRc = nteRc;
	}

	public String getNteTl() {
		return nteTl;
	}

	public void setNteTl(String nteTl) {
		this.nteTl = nteTl;
	}

	public String getNteCnt() {
		return nteCnt;
	}

	public void setNteCnt(String nteCnt) {
		this.nteCnt = nteCnt;
	}

	public Date getNteSntDt() {
		return nteSntDt;
	}

	public void setNteSntDt(Date nteSntDt) {
		this.nteSntDt = nteSntDt;
	}

	public Date getNteRcvDt() {
		return nteRcvDt;
	}

	public void setNteRcvDt(Date nteRcvDt) {
		this.nteRcvDt = nteRcvDt;
	}

	public String getNteRed() {
		return nteRed;
	}

	public void setNteRed(String nteRed) {
		this.nteRed = nteRed;
	}

	public String getNteSdDel() {
		return nteSdDel;
	}

	public void setNteSdDel(String nteSdDel) {
		this.nteSdDel = nteSdDel;
	}

	public String getNteRcDel() {
		return nteRcDel;
	}

	public void setNteRcDel(String nteRcDel) {
		this.nteRcDel = nteRcDel;
	}

	public String getEmpNm() {
		return empNm;
	}

	public void setEmpNm(String empNm) {
		this.empNm = empNm;
	}


	// 페이징 관련 필드
	public int getStart() {
		return start;
	}

	public void setStart(int start) {
		this.start = start;
	}

	public int getEnd() {
		return end;
	}

	public void setEnd(int end) {
		this.end = end;
	}

	@Override
	public String toString() {
		return "NoteVO [nteNo=" + nteNo + ", nteSd=" + nteSd + ", nteRc=" + nteRc + ", nteTl=" + nteTl + ", nteCnt="
				+ nteCnt + ", nteSntDt=" + nteSntDt + ", nteRcvDt=" + nteRcvDt + ", nteRed=" + nteRed + ", nteSdDel="
				+ nteSdDel + ", nteRcDel=" + nteRcDel + ", empNm=" + empNm + ", start=" + start + ", end=" + end
				+ ", getNteNo()=" + getNteNo() + ", getNteSd()=" + getNteSd() + ", getNteRc()=" + getNteRc()
				+ ", getNteTl()=" + getNteTl() + ", getNteCnt()=" + getNteCnt() + ", getNteSntDt()=" + getNteSntDt()
				+ ", getNteRcvDt()=" + getNteRcvDt() + ", getNteRed()=" + getNteRed() + ", getNteSdDel()="
				+ getNteSdDel() + ", getNteRcDel()=" + getNteRcDel() + ", getEmpNm()=" + getEmpNm() + ", getStart()="
				+ getStart() + ", getEnd()=" + getEnd() + ", getClass()=" + getClass() + ", hashCode()=" + hashCode()
				+ ", toString()=" + super.toString() + "]";
	}
	
	
	
}
