package kr.or.arthakdang.attendance.domain;

import kr.or.arthakdang.studentmanagement.domain.StudentVO;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class CheckInResultDTO {
	private StudentVO studentVO;
	private String msg;
	private String fileDir; // 나중 대비 만들어 
}
