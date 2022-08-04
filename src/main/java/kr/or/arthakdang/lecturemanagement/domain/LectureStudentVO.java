package kr.or.arthakdang.lecturemanagement.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class LectureStudentVO {
	private String cursNo;
	private String stuId;
	private String stuNm;
	private String stuPhNo;
	private String stuEmail;
}
