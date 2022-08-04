package kr.or.arthakdang.attendance.domain;

import java.util.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class CourseDateDTO {
	private Date cursSttDt;
	private Date cursEndDt;
}
