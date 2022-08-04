package kr.or.arthakdang.facilityreserv.service;

import java.util.List;

import kr.or.arthakdang.facilityreserv.domain.FacilityReservVO;
import kr.or.arthakdang.facilityreserv.domain.TimeVO;

public interface FacilityReservService {
	//전체 강의실 예약 리스트 
	public List<FacilityReservVO> facilityReservList(String facirsvDt); 
	//예약 신청
	public int insertFacReserv(FacilityReservVO facilityReservVO);
	//예약 변경
	public int updateFacReserv(FacilityReservVO facilityReservVO);
	//예약 취소 = delete
	public int deleteFacReserv(FacilityReservVO facilityReservVO);
	//예약할 때 수정 혹은 삭제할 때 하나만 선택해서 불러오는거
	public int onePickFacList(String memId);
	//시간
	public List<TimeVO> timeList(TimeVO timevo);
	//전체 강의실 예약 리스트 2
	public List<FacilityReservVO> facilityReservList2(FacilityReservVO facilityReservVO);
	//데이트피커에 날짜 가져오깅
	public List<String> facTimeList(String facirsvDt); 
	
}
