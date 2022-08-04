package kr.or.arthakdang.signup.domain;

import java.util.Date;
import java.util.List;

import com.fasterxml.jackson.annotation.JsonFormat;

import kr.or.arthakdang.domain.CourseVO;
import kr.or.arthakdang.studentmanagement.domain.StudentVO;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class PaymentVO {

	private String pymNo;
	private String ordNo;
	
	@JsonFormat( pattern="yyyy-MM-dd",shape = JsonFormat.Shape.STRING,timezone = "GMT+9")
	private Date pymDt;
	private String pymMtd;
	private String pymCmcd;
	private int pymAmt;
	
	private List<StudentVO> stuInfo;
	private List<CourseVO> course;
	
}
