package kr.or.arthakdang.facilityreserv.domain;

import java.util.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class FacilityReservVO {
	//예약 번호
	private String facirsvNo;
	//예약 시간
	private String facirsvTm;
	//예약 날짜
	private Date facirsvDt;
	//시설 이름
	private String faciNo;
	//멤버 아이디
	private String memId;
	//시설명 : 401호,402호..
	private String faciNm;

}
