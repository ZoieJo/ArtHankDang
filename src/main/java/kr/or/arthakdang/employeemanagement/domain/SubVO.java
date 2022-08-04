package kr.or.arthakdang.employeemanagement.domain;

import java.util.Date;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class SubVO {

	private String subNo;
	private String subNm;
	private String subDelWn;
	
	@JsonFormat(pattern="yyyy-MM-dd")
	private Date subCreDt;
}
