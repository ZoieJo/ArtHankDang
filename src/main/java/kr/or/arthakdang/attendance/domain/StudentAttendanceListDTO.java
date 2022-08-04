package kr.or.arthakdang.attendance.domain;

import java.util.List;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class StudentAttendanceListDTO {

	private String stuId;
	private List<AttendanceDTO> attendanceList;
}
