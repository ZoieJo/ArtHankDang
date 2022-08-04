package kr.or.arthakdang.calender.domain;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonFormat.Shape;
import com.fasterxml.jackson.databind.jsonFormatVisitors.JsonValueFormat;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Setter
@Getter
@ToString
public class CalendarVO {
	
	private String schdNo;
	
	private String schdTl;
	private String schdCnt;
	
	@DateTimeFormat(pattern="yyyy-MM-dd")
	@JsonFormat( pattern="yyyy-MM-dd",shape = JsonFormat.Shape.STRING,timezone = "GMT+9")
	private Date schdSttDt;
	
	@DateTimeFormat(pattern="yyyy-MM-dd")
	@JsonFormat( pattern="yyyy-MM-dd",shape = JsonFormat.Shape.STRING,timezone = "GMT+9")
	private Date schdEndDt;
	private String schdCmcd;
	private String memId;	
	
	//상담신청No
	private String cslrgNo;
	
}