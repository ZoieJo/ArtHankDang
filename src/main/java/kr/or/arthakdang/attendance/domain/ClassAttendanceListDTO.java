package kr.or.arthakdang.attendance.domain;

import java.util.List;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class ClassAttendanceListDTO {

	private String cursNo;
	private List<AttendanceDTO> attendanceList;
}
