package kr.or.arthakdang.attendance.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class AttendanceInfoDTO {
	private String stuId; // 학생아이디
	private String cursNo; // 강의아이디
	private int checkinDay; // 출석
	private int absentDay; // 결석
	private int lateDay; // 지각
	private int earlyDepartDay; // 조퇴
	private int illnessDay; // 병결
	private int lateAndEarlyDepartDay; // 지각+조퇴
	private double totalTakenTime; // 전체 시간
	
	private String cursNm; // 강의명 
	
}
